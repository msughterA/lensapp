import 'package:flutter/material.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import '../widgets/general_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'package:lensapp/services/storage.dart';
import 'main_screen.dart' as mn;

class HistoryScreen extends StatefulWidget {
  final module;
  HistoryScreen({Key key, this.module}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  PageController pageController = PageController();
  int currentPage = 0;
  List history;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistory();
  }

  getHistory() async {
    switch (widget.module) {
      case mn.Module.chemistry:
        history = await DatabaseHelper.instance.queryQA('Chemistry');
        break;
      case mn.Module.mathematics:
        history = await DatabaseHelper.instance.queryQA('Mathematics');
        break;
      case mn.Module.summarizer:
        history = await DatabaseHelper.instance.querySummary();
        break;
      default:
    }
    setState(() {
      //history=hi
    });
  }

  @override
  Widget build(BuildContext context) {
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
              height: 100.h,
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          child: Icon(Icons.arrow_back_ios_outlined),
                          height: 7.0.h,
                          width: 15.0.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Pallete.backround),
                        ),
                      )
                    ],
                  ),
                  history != null
                      ? Expanded(
                          child: Container(
                              child: PageView.builder(
                                  itemCount: history.length,
                                  itemBuilder: (context, index) {
                                    return history.isEmpty
                                        ? Container(
                                            height: 10.h,
                                            width: 100.w,
                                            child: Center(
                                              child: Text('No History yet'),
                                            ),
                                          )
                                        : HistoryTile(
                                            question: widget.module !=
                                                    mn.Module.summarizer
                                                ? history[index]['question']
                                                : null,
                                            answer: widget.module !=
                                                    mn.Module.summarizer
                                                ? history[index]['answer']
                                                : null,
                                            summary: widget.module ==
                                                    mn.Module.summarizer
                                                ? history[index]['summary']
                                                : null,
                                          );
                                  })))
                      : Container(
                          height: 10.h,
                          width: 100.w,
                          child: Center(
                            child: Text('No History yet'),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}

class HistoryTile extends StatelessWidget {
  final List question;
  final List answer;
  final List summary;
  HistoryTile({Key key, this.question, this.answer, this.summary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (summary != null) {
      return Container(
        constraints: BoxConstraints(minHeight: 100.h, maxWidth: 100.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.h,
            ),
            Text(
              'Summary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            RenderData(
              pods: summary,
            ),
          ],
        ),
      );
    } else {
      return Container(
        constraints: BoxConstraints(minHeight: 100.h, maxWidth: 100.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.h,
            ),
            Text(
              'Quesiton',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            RenderData(
              pods: question,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Answer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 2.h,
            ),
            RenderData(pods: answer)
          ],
        ),
      );
    }
  }
}