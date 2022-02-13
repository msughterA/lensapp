import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';

void main() {
  runApp(MaterialApp(
    home: PlanScreen(),
  ));
}

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key key}) : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Sizer(builder: (context, orientation, deviceType) {
          return SingleChildScrollView(
              child: Container(
                  constraints:
                      BoxConstraints(minHeight: 100.h, maxWidth: 100.w),
                  padding: EdgeInsets.only(
                    left: 4.w,
                    right: 1.h,
                    top: 1.h,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Container(
                            height: 50.h,
                            width: 90.w,
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Free Plan',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '\$0',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  '''
Get access to out examples module that uses ai to give you examples that guide you on how 
to answer or solve a problem
''',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Center(
                            child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Premium Plan',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '\$10',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                '''
Get access to out examples to your questions, summarize complex paragragphs of text,
get answers to math questions,
get answers to chemistry questions
''',
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          height: 50.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        )),
                      ])));
        }),
      ),
    );
  }
}
