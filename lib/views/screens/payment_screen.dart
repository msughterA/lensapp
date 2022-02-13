import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import 'card_screen.dart';
import 'plans_screen.dart';

void main() {
  runApp(MaterialApp(
    home: PaymentScreen(),
  ));
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sizer(builder: (context, orientation, deviceType) {
        return Container(
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Icon(
                Icons.account_balance_outlined,
                size: 20.h,
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
                        'Pay',
                        style: TextStyle(color: Pallete.primary),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Pallete.accent,
                        borderRadius: BorderRadius.all(Radius.circular(2.0.h))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 5.h),
                child: InkWell(
                  onTap: () {
                    // Move to th appropriate screen
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PlanScreen();
                    }));
                  },
                  child: Container(
                    height: 5.h,
                    child: Center(
                      child: Text(
                        'See our Plans',
                        style: TextStyle(color: Pallete.secondary),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Pallete.accent),
                        borderRadius: BorderRadius.all(Radius.circular(2.0.h))),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
