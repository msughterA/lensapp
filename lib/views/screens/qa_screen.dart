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
    home: AnswerScreen(),
  ));
}

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({Key key}) : super(key: key);

  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  List question;
  List answer;
  bool _isSaved = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //final mainBloc = BlocProvider.of<MainBloc>(context);
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
                  BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      if (state is Solution) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              'Quesiton',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            RenderData(
                              pods: state.question,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Answer',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            RenderData(pods: state.answer)
                          ],
                        );
                      } else if (state is Calculatiing) {
                        return Padding(
                          padding: EdgeInsets.only(top: 18.h),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.pink,
                            ),
                          ),
                        );
                      } else if (state is CalculationError) {
                        return Center(
                          child: Text(state.message),
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
    String qjsn = json.encode(question).toString();
    String ajsn = json.encode(answer).toString();
    final qaModel =
        QAModel(question: qjsn, answer: ajsn, module: 'Mathematics');
    setState(() {
      _isSaved = true;
    });
    print('THE QUESTION IS ${qaModel.question}');
    print('THE ANSWER IS QA MODEL ${qaModel.answer}');
    await DatabaseHelper.instance.insertQA(qaModel.toMap());
  }
}

class ChemistryAnswer extends StatefulWidget {
  const ChemistryAnswer({Key key}) : super(key: key);

  @override
  _ChemistryAnswerState createState() => _ChemistryAnswerState();
}

class _ChemistryAnswerState extends State<ChemistryAnswer> {
  List question;
  List answer;
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
                  BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) {
                      if (state is AnsweredChemistry) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          setState(() {
                            question = state.question;
                            answer = state.answer;
                          });
                          print('THIS IS THE QUESTION ${question}');
                        });
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              'Quesiton',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            RenderData(
                              pods: state.question,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'Answer',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            RenderData(pods: state.answer)
                          ],
                        );
                      } else if (state is AnsweringChemistry) {
                        return Padding(
                          padding: EdgeInsets.only(top: 18.h),
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.pink,
                            ),
                          ),
                        );
                      } else if (state is AnswerChemistryError) {
                        return Center(
                          child: Text(state.message),
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
    String qjsn = json.encode(question).toString();
    String ajsn = json.encode(answer).toString();
    final qaModel = QAModel(question: qjsn, answer: ajsn, module: 'Chemistry');
    setState(() {
      _isSaved = true;
    });
    print('THE QUESTION IS ${qaModel.question}');
    print('THE ANSWER IS QA MODEL ${qaModel.answer}');
    await DatabaseHelper.instance.insertQA(qaModel.toMap());
  }
}
