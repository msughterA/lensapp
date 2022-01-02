import 'package:flutter/material.dart';
import '/utils/app_themes.dart';
import '/bloc/main_bloc.dart';
import 'package:sizer/sizer.dart';
import 'main_screen.dart';
import 'package:lensapp/views/widgets/general_widgets.dart';

class EditScreen extends StatelessWidget {
  final int fieldIndex;
  List<String> fieldName = ['email', 'username', 'phone'];
  List<Icon> icon = [
    Icon(Icons.email_outlined),
    Icon(Icons.text_fields_outlined),
    Icon(Icons.phone_android_outlined)
  ];
  EditScreen({Key key, this.fieldIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sizer(
        builder: (context, orientaion, deviceType) {
          return Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 4.h)),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w),
                  child: TextInput(
                    icon: icon[fieldIndex],
                    hintText: fieldName[fieldIndex],
                    inputType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 5.h),
                  child: InkWell(
                    onTap: () {
                      // Move to th appropriate screen
                      // mainBloc.add(VerifyEvent());
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
                          'Go back',
                          style: TextStyle(color: Pallete.secondary),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Pallete.accent),
                          borderRadius:
                              BorderRadius.all(Radius.circular(2.0.h))),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
