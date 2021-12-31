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
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      body: Sizer(
        builder: (context, orientation, deviceType) {
          return Container(
            height: 100.h,
            width: 100.w,
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
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 5.h),
                  child: InkWell(
                    onTap: () {
                      // Move to th appropriate screen
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
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
    );
  }
}
