import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/main_bloc.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutScreen extends StatelessWidget {
  final String phoneNumber;
  final String deviceId;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LogoutScreen({Key key, this.phoneNumber, this.deviceId}) : super(key: key);

  //
  Future deleteDetails() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
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
              return Container(
                height: 100.h,
                width: 100.w,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 4.h)),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                      if (state is LogOutState) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(left: 4.w, right: 4.w),
                                    child: Text(
                                      'Do you want to logout',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 5.h),
                              child: InkWell(
                                onTap: () {
                                  mainBloc.add(LogOutEvent(
                                    phoneNumber: phoneNumber,
                                    deviceId: deviceId,
                                  ));
                                },
                                child: Container(
                                  height: 6.h,
                                  child: Center(
                                    child: Text(
                                      'Yes',
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
                                      'No',
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
                      } else if (state is LogOutLoadingState) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Container(
                              height: 15.h,
                              width: 15.h,
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Logging out....')
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (state is LogOutError) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          showInSnackBar(state.message);
                        });
                        mainBloc.add(ResetEvent(inputState: LogOutState()));
                      } else if (state is LogInState) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          deleteDetails();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return BlocProvider(
                              create: (context) => MainBloc(LogInState()),
                              child: LoginScreen(),
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

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}
