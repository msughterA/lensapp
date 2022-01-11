import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '/utils/app_themes.dart';
import 'package:sizer/sizer.dart';
import 'package:lensapp/views/widgets/general_widgets.dart';
import 'verify_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/main_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SignUpScreen({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordontroller = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height + 110,
          width: MediaQuery.of(context).size.width,
          child: Sizer(
            builder: (context, orientation, deviceType) {
              return Form(
                key: _formKey,
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
                        controller: _userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter username';
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
                        icon: Icon(Icons.email_outlined),
                        hintText: 'email',
                        inputType: TextInputType.emailAddress,
                        controller: _emailController,
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
                      child: Container(
                        padding: EdgeInsets.only(left: 5.w),
                        decoration: new BoxDecoration(
                          color: Pallete.secondaryBackround,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          ignoreBlank: false,
                          initialValue: number,
                          textFieldController: _phoneNumberController,
                          formatInput: false,
                          inputDecoration: InputDecoration(
                              icon: Icon(Icons.phone_android_outlined),
                              labelText: 'Phone Number',
                              hintText: 'Phone Number',
                              //errorText:errorText() ,
                              border: InputBorder.none,
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Pallete.accent),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Pallete.primary))),
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          inputBorder: OutlineInputBorder(),
                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
                        ),
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
                        controller: _passwordontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          } else if (value.length != 8) {
                            return 'Password must be 8 characters';
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
                        hintText: 'Confirm Password',
                        inputType: TextInputType.text,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Confirm Password';
                          } else if (value.length != 8) {
                            return 'Password must be 8 characters';
                          } else if (_passwordontroller.text !=
                              _confirmPasswordController.text) {
                            return 'Password not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    BlocBuilder<MainBloc, MainState>(
                      builder: (context, state) {
                        if (state is SignUpState) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 4.w, right: 4.w, top: 5.h),
                                child: InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      // Move to th appropriate screen
                                      mainBloc.add(ValidateDataEvent(
                                          username: _userNameController.text,
                                          deviceId: 'A30',
                                          password: _passwordontroller.text,
                                          email: _emailController.text,
                                          phoneNumber:
                                              _phoneNumberController.text));
                                    }
                                  },
                                  child: Container(
                                    height: 6.h,
                                    child: Center(
                                      child: Text(
                                        'Sign Up',
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
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: 6.h,
                                    child: Center(
                                      child: Text(
                                        'Login',
                                        style:
                                            TextStyle(color: Pallete.secondary),
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
                        } else if (state is ValidateLoadingState) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 4.h),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is ErrorState) {
                          SchedulerBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            showInSnackBar(state.message);
                          });

                          mainBloc.add(ResetEvent(inputState: SignUpState()));
                        } else if (state is VerifyState) {
                          SchedulerBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            // mainBloc.add(GoToStateEvent(inputState: VerifyState()));
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (_) {
                              return BlocProvider.value(
                                value: BlocProvider.of<MainBloc>(context),
                                child: VerifyScreen(),
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
