import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import 'package:pay/pay.dart';

void main() {
  runApp(MaterialApp(
    home: PlanScreen(),
  ));
}

//#2C9340 background color for payment
class PlanScreen extends StatefulWidget {
  const PlanScreen({Key key}) : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
  // handle the google payment result
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFF0F0E4),
        body: Sizer(builder: (context, orientation, deviceType) {
          return SingleChildScrollView(
              child: Container(
                  constraints:
                      BoxConstraints(minHeight: 110.h, maxWidth: 100.w),
                  padding: EdgeInsets.only(
                    left: 4.w,
                    right: 1.h,
                    top: 1.h,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: Container(
                            child: Icon(Icons.arrow_back_ios_outlined),
                            height: 7.0.h,
                            width: 15.0.w,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Pallete.backround),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                            child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Premium Plan',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '\$10',
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                '''
1. Get answers to complex calculative questions ranging from solving equations to word problems.

2. summarize paragraphs of text in a way you can understand.

3. Get answers to non calculative questions.

4. Get examples on how to solve some complex questions by snapping them. 
to answer or solve a problem.

''',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              GooglePayButton(
                                width: 300,
                                paymentConfigurationAsset: 'gpay.json',
                                onError: (error) {
                                  // Print the error that has occurred
                                  print('This is the error ${error}');
                                },
                                paymentItems: _paymentItems,
                                style: GooglePayButtonStyle.black,
                                type: GooglePayButtonType.pay,
                                margin: const EdgeInsets.only(top: 15.0),
                                onPaymentResult: onGooglePayResult,
                                loadingIndicator: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                          width: 90.w,
                          constraints: BoxConstraints(minHeight: 40.h),
                          decoration: BoxDecoration(
                              color: Color(0XFF2C9340),
                              borderRadius: BorderRadius.circular(25.0)),
                        )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Container(
                            width: 90.w,
                            constraints: BoxConstraints(minHeight: 40.h),
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Free Plan',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '\$0',
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  '''
1. Get answers to simple calculative science questions involving simple equations by snapping them.

2. Get examples on how to solve some complex questions by snapping them 
to answer or solve a problem
''',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0XFF2C9340),
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        )
                      ])));
        }),
      ),
    );
  }
}
