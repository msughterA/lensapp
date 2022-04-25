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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

class VerifyScreen extends StatelessWidget {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String deviceId;
  final String verificationId;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static final facebookAppEvents = FacebookAppEvents();

  final _formKey = GlobalKey<FormState>();
  VerifyScreen(
      {Key key,
      this.username,
      this.email,
      this.password,
      this.phoneNumber,
      this.verificationId,
      this.deviceId})
      : super(key: key);
  TextEditingController _otpController = TextEditingController();

  Future storeDetails({String phonenumber, String deviceId}) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('phoneNumber', phonenumber);
    pref.setString('deviceId', deviceId);
    pref.setString('username', username);
    pref.setString('email', email);
  }

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
              return Form(
                  key: _formKey,
                  child: Container(
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
                            controller: _otpController,
                            icon: Icon(Icons.phone_android_outlined),
                            hintText: 'Enter Verification Code',
                            inputType: TextInputType.number,
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Code';
                              }
                              return null;
                            },
                          ),
                        ),
                        BlocBuilder<MainBloc, MainState>(
                            builder: (context, state) {
                          print(state);
                          if (state is VerifyState) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 4.w, right: 4.w, top: 5.h),
                                  child: InkWell(
                                    onTap: () {
                                      // Move to th appropriate screen
                                      print(email);
                                      if (_formKey.currentState.validate()) {
                                        PhoneAuthCredential
                                            phoneAuthCredential =
                                            PhoneAuthProvider.credential(
                                                verificationId: verificationId,
                                                smsCode: _otpController.text);
                                        mainBloc.add(VerifyNumberEvent(
                                            phoneAuthCredential:
                                                phoneAuthCredential,
                                            email: email,
                                            password: password,
                                            phoneNumber: phoneNumber,
                                            deviceId: deviceId,
                                            username: username));
                                      }
                                    },
                                    child: Container(
                                      height: 6.h,
                                      child: Center(
                                        child: Text(
                                          'Verify',
                                          style:
                                              TextStyle(color: Pallete.primary),
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
                                          value: BlocProvider.of<MainBloc>(
                                              context),
                                          child: SignUpScreen(),
                                        );
                                      }));
                                    },
                                    child: Container(
                                      height: 6.h,
                                      child: Center(
                                        child: Text(
                                          'Go back',
                                          style: TextStyle(
                                              color: Pallete.secondary),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Pallete.accent),
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
                          } else if (state is VerifyError) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              showInSnackBar(state.message);
                              mainBloc.add(ResetEvent(
                                  inputState: VerifyState(
                                      verificationId: verificationId)));
                            });
                          } else if (state is SignUpError) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              showInSnackBar(state.message);
                              mainBloc.add(ResetEvent(
                                  inputState: VerifyState(
                                      verificationId: verificationId)));
                            });
                          } else if (state is HomeState) {
                            SchedulerBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              storeDetails(
                                  phonenumber: phoneNumber, deviceId: deviceId);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                // log the signup event to facebook
                                facebookAppEvents.logEvent(
                                  name: 'sign_up_event',
                                  parameters: {
                                    'button_id': 'the_sign_up_button',
                                  },
                                );
                                return BlocProvider(
                                  create: (context) => MainBloc(HomeState()),
                                  child: MainScreen(
                                    phoneNumber: phoneNumber,
                                    deviceId: deviceId,
                                  ),
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
                  ));
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
