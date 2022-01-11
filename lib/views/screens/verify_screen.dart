import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:lensapp/views/widgets/general_widgets.dart';
import '/utils/app_themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/main_bloc.dart';
import 'main_screen.dart';
import 'signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class VerifyScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  VerifyScreen({Key key}) : super(key: key);
  TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Sizer(
            builder: (context, orientation, deviceType) {
              return Container(
                height: 100.h,
                width: 100.w,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 4.h)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 4.w, right: 4.w),
                            child: Text(
                              'Verify Number',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: TextInput(
                        icon: Icon(Icons.phone_android_outlined),
                        hintText: 'Enter Verification Code',
                        inputType: TextInputType.text,
                      ),
                    ),
                    BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                      if (state is VerifyState) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 5.h),
                              child: InkWell(
                                onTap: () {
                                  // Move to th appropriate screen
                                  PhoneAuthCredential phoneAuthCredential =
                                      PhoneAuthProvider.credential(
                                          verificationId: state.verificationId,
                                          smsCode: _otpController.text);
                                  mainBloc.add(VerifyNumberEvent(
                                      phoneAuthCredential:
                                          phoneAuthCredential));
                                },
                                child: Container(
                                  height: 6.h,
                                  child: Center(
                                    child: Text(
                                      'Verify',
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
                                  mainBloc.add(GoToStateEvent(
                                      inputState: SignUpState()));
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) {
                                    return BlocProvider.value(
                                      value: BlocProvider.of<MainBloc>(context),
                                      child: SignUpScreen(),
                                    );
                                  }));
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
                            ),
                          ],
                        );
                      } else if (state is VerifyLoadingState) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is HomeState) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<MainBloc>(context),
                              child: MainScreen(),
                            );
                          }));
                        });
                      }
                      return Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Icon(
                          Icons.check_outlined,
                          color: Pallete.accent,
                        ),
                      );
                    })
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
