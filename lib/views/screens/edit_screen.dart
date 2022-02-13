import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '/utils/app_themes.dart';
import '/bloc/main_bloc.dart';
import 'package:sizer/sizer.dart';
import 'main_screen.dart';
import 'package:lensapp/views/widgets/general_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final int fieldIndex;
  final String newPhoneNumber;
  final String username;
  final String email;
  final String phoneNumber;
  List<String> fieldName = ['email', 'username', 'phone'];
  List<Icon> icon = [
    Icon(Icons.email_outlined),
    Icon(Icons.text_fields_outlined),
    Icon(Icons.phone_android_outlined)
  ];
  EditScreen(
      {Key key,
      this.fieldIndex,
      this.email,
      this.username,
      this.phoneNumber,
      this.newPhoneNumber})
      : super(key: key);
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // bloc reference
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Sizer(
            builder: (context, orientaion, deviceType) {
              return Container(
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 4.h)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: TextInput(
                        controller: _controller,
                        icon: icon[fieldIndex],
                        hintText: fieldName[fieldIndex],
                        inputType: TextInputType.text,
                      ),
                    ),
                    BlocBuilder<MainBloc, MainState>(
                      builder: (context, state) {
                        if (state is EditState) {
                          return Column(children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 5.h),
                              child: InkWell(
                                onTap: () {
                                  if (fieldIndex == 0) {
                                    mainBloc.add(EditEvent(
                                        email: _controller.text,
                                        phoneNumber: phoneNumber));
                                  } else if (fieldIndex == 1) {
                                    mainBloc.add(EditEvent(
                                        username: _controller.text,
                                        phoneNumber: phoneNumber));
                                  } else if (fieldIndex == 2) {
                                    mainBloc.add(EditEvent(
                                        newPhoneNumber: _controller.text,
                                        phoneNumber: phoneNumber));
                                  }
                                },
                                child: Container(
                                  height: 6.h,
                                  child: Center(
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(color: Pallete.primary),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Pallete.accent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2.0.h))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 5.h),
                              child: InkWell(
                                onTap: () {
                                  // Move to th appropriate screen
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 6.h,
                                  child: Center(
                                    child: Text(
                                      'Go back',
                                      style:
                                          TextStyle(color: Pallete.secondary),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Pallete.accent),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(2.0.h))),
                                ),
                              ),
                            )
                          ]);
                        } else if (state is EditLoadingState) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is EditError) {
                          mainBloc.add(ResetEvent(inputState: EditState()));
                          SchedulerBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            showInSnackBar(state.message);
                          });
                        } else if (state is EditedState) {
                          // Display edited and go back
                          // to previous screen
                          SchedulerBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            showInSnackBar('Data Edited');
                            //mainBloc.add(GoToStateEvent(inputState: HomeState()));
                            Navigator.of(context).pop();
                          });
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Icon(
                            Icons.check_outlined,
                            color: Pallete.accent,
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}
