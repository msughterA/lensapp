import 'package:flutter/material.dart';
import 'package:lensapp/views/screens/verify_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:lensapp/views/widgets/general_widgets.dart';
import '/utils/app_themes.dart';
import 'signup_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lensapp/bloc/main_bloc.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height + 10,
          width: MediaQuery.of(context).size.width,
          child: Sizer(
            builder: (context, orientation, deviceType) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 4.h)),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 4.w, right: 4.w),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // email input field
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: TextInput(
                        icon: Icon(Icons.email_outlined),
                        hintText: 'email',
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: TextInput(
                        icon: Icon(Icons.password_outlined),
                        hintText: 'password',
                        inputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 5.h),
                      child: InkWell(
                        onTap: () {
                          // Move to th appropriate screen
                          if (_formKey.currentState.validate()) {
                            //move to the right screen
                          }
                        },
                        child: Container(
                          height: 6.h,
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(color: Pallete.primary),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Pallete.accent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0.h))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 5.h),
                      child: InkWell(
                        onTap: () {
                          // Move to th appropriate screen
                          mainBloc
                              .add(GoToStateEvent(inputState: SignUpState()));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<MainBloc>(context),
                              child: SignUpScreen(),
                            );
                          })).then(
                              (value) => ResetEvent(inputState: LogInState()));
                        },
                        child: Container(
                          height: 6.h,
                          child: Center(
                            child: Text(
                              'Sign up',
                              style: TextStyle(color: Pallete.secondary),
                            ),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Pallete.accent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0.h))),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ));
  }
}
