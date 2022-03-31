import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import '/services/storage.dart';
import '../widgets/general_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'dart:convert';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key key}) : super(key: key);

  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  List examples;
  bool _isSaved = false;
  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return SafeArea(child: Scaffold(
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
                      Container(
                        child: Icon(Icons.arrow_back_ios_outlined),
                        height: 7.0.h,
                        width: 15.0.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Pallete.backround),
                      ),
                    ],
                  ),
                  BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      if (state is Example) {
                        examples = state.examples;
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(examples.length, (index) {
                              int indx = index + 1;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Text(
                                    'Example $indx',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  RenderData(
                                    pods: examples[index]['example'],
                                  )
                                ],
                              );
                            }));
                      } else if (state is ExampleLoading) {
                        return Padding(
                          padding: EdgeInsets.only(top: 18.h),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.pink,
                            ),
                          ),
                        );
                      } else if (state is ExampleError) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 90),
                            child: Text(state.message),
                          ),
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  Future saveToDatabase() async {
    String jsn = json.encode(examples).toString();
    var obj = json.decode(jsn);
    print('THIS IS A STRING ${jsn}');
    print('THIS IS A JSON ${obj}');
    print(obj[0]['example']);
    setState(() {
      _isSaved = true;
    });
    for (int i = 0; i < examples.length; i++) {
      //await DatabaseHelper.instance.insertExample()
    }
  }
}
