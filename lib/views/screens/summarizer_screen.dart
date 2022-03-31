import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import '../widgets/general_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'package:lensapp/services/storage.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    theme: AppThemes.normalTheme,
    home: SummarizerScreen(),
  ));
}

class SummarizerScreen extends StatefulWidget {
  const SummarizerScreen({Key key}) : super(key: key);

  @override
  _SummarizerScreenState createState() => _SummarizerScreenState();
}

class _SummarizerScreenState extends State<SummarizerScreen> {
  bool _isSaved = false;
  List _summary;
  //FileManagerBloc _fileManagerBloc;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //final mainBloc = BlocProvider.of<MainBloc>(context);
    //final mainBloc = BlocProvider.of<MainBloc>(context);
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Pallete.primary,
      body: Sizer(
        builder: (context, orientation, deviceType) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: 4.w,
                right: 4.w,
                top: 1.h,
              ),
              constraints: BoxConstraints(minHeight: 100.h, maxWidth: 100.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: Icon(Icons.arrow_back_ios_outlined),
                          height: 7.0.h,
                          width: 15.0.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Pallete.backround),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Save the examples to the database
                          await saveToDatabase();
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              _isSaved ? 'Saved' : 'Save',
                              style: TextStyle(
                                  color:
                                      _isSaved ? Colors.white : Colors.black),
                            ),
                          ),
                          height: 7.0.h,
                          width: 18.0.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color:
                                  _isSaved ? Colors.black : Pallete.backround),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    'Summary',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  // The BlocProvider would be inserted here
                  SizedBox(
                    height: 3.h,
                  ),
                  BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                    if (state is Summary) {
                      SchedulerBinding.instance
                          .addPostFrameCallback((timeStamp) {
                        setState(() {
                          _summary = state.summary;
                        });
                      });
                      return RenderData(
                        pods: state.summary,
                      );
                    } else if (state is Summarizing) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SummaryError) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 90),
                          child: Text(state.message),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  Future saveToDatabase() async {
    if (_summary != null) {
      String sjsn = json.encode(_summary).toString();
      final summaryModel = SummaryModel(summary: sjsn);
      setState(() {
        _isSaved = true;
      });
      await DatabaseHelper.instance.insertSummary(summaryModel.toMap());
    } else {
      print('Cannot save null to DB');
      showInSnackBar('Cannot save to History');
    }
  }
}
