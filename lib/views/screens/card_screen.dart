import 'package:flutter/material.dart';
import 'package:lensapp/views/widgets/general_widgets.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';

void main() {}

class CardScreen extends StatelessWidget {
  const CardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sizer(
        builder: (context, orientation, deviceType) {
          return SingleChildScrollView(
            child: Container(
              height: 100.h,
              width: 100.w,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4.h,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 6.h,
                          //color: Colors.black,
                          child: IconButton(
                            onPressed: () {
                              // Go back to home screen
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.arrow_back_ios_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Icon(
                    Icons.payment_outlined,
                    size: 15.h,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: TextInput(
                      hintText: 'Card Number',
                      icon: Icon(Icons.payment),
                      inputType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: TextInput(
                      hintText: 'CVV 000',
                      icon: Icon(Icons.payment),
                      inputType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: TextInput(
                      hintText: 'Expiry Month 00',
                      icon: Icon(Icons.calendar_today_outlined),
                      inputType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: TextInput(
                      hintText: 'Expiry Year 00',
                      icon: Icon(Icons.calendar_today_outlined),
                      inputType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 5.h),
                    child: InkWell(
                      onTap: () {
                        // Move to th appropriate screen
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CardScreen();
                        }));
                      },
                      child: Container(
                        height: 5.h,
                        child: Center(
                          child: Text(
                            'Subscribe',
                            style: TextStyle(color: Pallete.primary),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Pallete.accent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0.h))),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
