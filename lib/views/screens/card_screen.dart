import 'package:flutter/material.dart';
import 'package:lensapp/constants/api_constants.dart';
import 'package:lensapp/views/widgets/general_widgets.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/services/app_client.dart';
import '/services/app_exceptions.dart';

String paystackPublicKey = 'pk_test_899fb395288f8b89bbbb66a5d5868f4a47a08a36';

void main() {
  runApp(MaterialApp(
    theme: AppThemes.normalTheme,
    home: CardScreen(),
  ));
}

class CardScreen extends StatefulWidget {
  const CardScreen({Key key}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final plugin = PaystackPlugin();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _verticalSizeBox = const SizedBox(height: 20.0);
  final _horizontalSizeBox = const SizedBox(width: 10.0);
  var _border = new Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.red,
  );
  int _radioValue = 0;
  CheckoutMethod _method;
  TextEditingController cardNumberController = new TextEditingController();
  TextEditingController cvvController = new TextEditingController();
  TextEditingController expiryMonthController = new TextEditingController();
  TextEditingController expiryYearController = new TextEditingController();

  bool _inProgress = false;
  //bool _isLocal=true;
  String _cardNumber;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;
  String _phoneNumber;
  String _deviceId;
  String _email;
  @override
  void initState() {
    plugin.initialize(publicKey: paystackPublicKey);
    super.initState();
    getDeviceDetails();
    print('PhoneNumber is $_phoneNumber');
  }

  @override
  Widget build(BuildContext context) {
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
                child: Form(
                  key: _formKey,
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
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: TextInput(
                          controller: cardNumberController,
                          hintText: 'Card Number',
                          icon: Icon(Icons.payment),
                          inputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: TextInput(
                          controller: cvvController,
                          hintText: 'CVV 000',
                          icon: Icon(Icons.payment),
                          inputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: TextInput(
                          controller: expiryMonthController,
                          hintText: 'Expiry Month 00',
                          icon: Icon(Icons.calendar_today_outlined),
                          inputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, right: 5.w),
                        child: TextInput(
                          controller: expiryYearController,
                          hintText: 'Expiry Year 00',
                          icon: Icon(Icons.calendar_today_outlined),
                          inputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 2.w, right: 2.w, top: 5.h),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              accentColor: Pallete.accent,
                              primaryColorLight: Colors.white,
                              primaryColorDark: Colors.blue,
                              textTheme: Theme.of(context).textTheme.copyWith(
                                    bodyText2: TextStyle(
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                            ),
                            child: Builder(
                              builder: (context) {
                                return _inProgress
                                    ? new Container(
                                        alignment: Alignment.center,
                                        height: 10.h,
                                        child: Platform.isIOS
                                            ? new CupertinoActivityIndicator()
                                            : new CircularProgressIndicator(),
                                      )
                                    : new Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new SizedBox(
                                            height: 1.h,
                                            width: 80.w,
                                          ),
                                          new Container(
                                            child: new RaisedButton(
                                              elevation: 0,
                                              child: new Text(
                                                'Pay',
                                                style: new TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                //Navigate to the sign up page
                                                _startAfreshCharge();
                                              },
                                              color: Pallete.accent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                              ),
                                            ),
                                            height: 6.h,
                                            width: 90.w,
                                            decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            ),
                                          )
                                        ],
                                      );
                              },
                            ),
                          ))
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    ///_scaffoldKey.currentState.showBottomSheet((context) => null);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: duration,
      action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar()),
    ));
  }

  _startAfreshCharge() async {
    // This is where we set the card parameters
    //_formKey.currentState.save();
    _cardNumber = cardNumberController.text;
    _cvv = cvvController.text;
    _expiryMonth = int.tryParse(expiryMonthController.text);
    _expiryYear = int.tryParse(expiryYearController.text);

    Charge charge = Charge();
    print('ERROR HAPPENS BEFORE CHARGE CARD 1');
    charge.card = _getCardFromUI();

    setState(() => _inProgress = true);

    if (_isLocal) {
      // Set transaction params directly in app (note that these params
      // are only used if an access_code is not set. In debug mode,
      // setting them after setting an access code would throw an exception
      print('ERROR HAPPENS HERE');
      charge
        ..amount = 500000 // In base currency i.e kobo
        ..email = 'msughtera37@gmail.com'
        ..reference = _getReference()
        ..putCustomField('Charged From', 'Flutter SDK');
      _chargeCard(charge);
      print('ERROR HAPPENS HERE 2');
    }
  }

  void handleError(error, reference) {
    if (error is BadRequestException) {
      print('Bad Request ${error}');
      _updateStatus(message: 'Bad Request');
    } else if (error is ApiNotRespondingException) {
      saveIncompletetransaction(transaction_id: reference, amount: 5000);
      _updateStatus(message: 'Took too long');
    } else if (error is UnAuthorizedException) {
      _updateStatus(message: error.message);
    } else if (error is FetchDataException) {
      _updateStatus(message: 'Fetch data exception');
    }
  }

  _updateStatus({String message}) {
    _showMessage('$message', const Duration(seconds: 2));
  }

  _chargeCard(Charge charge) async {
    print('ERROR HAPPENS BEFORE CHARGE CARD 2');
    final response = await plugin.chargeCard(context, charge: charge);
    print('ERROR HAPPENS AFTER CHARGE CARD');
    final reference = response.reference;

    // Checking if the transaction is successful
    if (response.status) {
      // if the transaction is successful verify it on our backend
      print('RESPONSE IS POSITIVE');
      await _verifyOnServer(reference);
      return;
    }

    // The transaction failed. Checking if we should verify the transaction
    if (response.verify) {
      await _verifyOnServer(reference);
    } else {
      setState(() => _inProgress = false);
      _updateStatus(message: response.message);
    }
  }

  Future _verifyOnServer(String reference) async {
    _updateStatus(message: 'Verifying...');
    var request = {
      'amount_paid': 5000,
      'transaction_id': reference,
      'phone_number': _phoneNumber,
      'transaction_device_id': _deviceId
    };
    var response = await BaseClient()
        .post(ApiConstants.BASE_URL, ApiConstants.PAY_WITH_CARD, request)
        .catchError((error) {
      handleError(error, reference);
    });
    if (response != null) {
      _updateStatus(message: 'Payment succesful');
    }
    setState(() => _inProgress = false);
  }

  Future saveIncompletetransaction({transaction_id, amount}) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('transaction_id', transaction_id);
    pref.setString('amount', amount);
  }

  Future verifyIncompleteTransactions() async {
    final pref = await SharedPreferences.getInstance();
    var transactionId = pref.getString('transaction_id');
    var amount = pref.getString('amount');
    if (amount != null && transactionId != null) {
      _verifyOnServer(transactionId);
    }
  }

  Widget _getPlatformButton(String string, Function() function) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = new CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: CupertinoColors.activeBlue,
        child: new Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = new RaisedButton(
        onPressed: function,
        color: Colors.blueAccent,
        textColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
        child: new Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
    return widget;
  }

  // Get the transaction refer
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }
    print('ERROR IS FROM GET REFERENCE');
    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future getDeviceDetails() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _phoneNumber = pref.getString('phoneNumber');
      _deviceId = pref.getString('deviceId');
      _email = pref.getString('email');
    });
    print(_phoneNumber);
  }

  bool get _isLocal => _radioValue == 0;
}
