import 'package:flutter/material.dart';
import '/utils/app_themes.dart';
import 'package:sizer/sizer.dart';
import 'package:lensapp/views/widgets/general_widgets.dart';
import 'verify_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/main_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key}) : super(key: key);

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
                  height: 5.h,
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 4.w, right: 4.w),
                        child: Text(
                          'Sign Up',
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
                // email input field
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: TextInput(
                    icon: Icon(Icons.text_fields_outlined),
                    hintText: 'Username',
                    inputType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: TextInput(
                    icon: Icon(Icons.email_outlined),
                    hintText: 'email',
                    inputType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: TextInput(
                    icon: Icon(Icons.phone_android_outlined),
                    hintText: 'password',
                    inputType: TextInputType.text,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: TextInput(
                    icon: Icon(Icons.password_outlined),
                    hintText: 'Confirm password',
                    inputType: TextInputType.text,
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return BlocProvider.value(
                          value: BlocProvider.of<MainBloc>(context),
                          child: VerifyScreen(),
                        );
                      }));
                    },
                    child: Container(
                      height: 6.h,
                      child: Center(
                        child: Text(
                          'Sign Up',
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
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 6.h,
                      child: Center(
                        child: Text(
                          'Login',
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
