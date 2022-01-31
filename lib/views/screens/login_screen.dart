import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lensapp/views/screens/verify_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:lensapp/views/widgets/general_widgets.dart' as InputWidget;
import '/utils/app_themes.dart';
import 'signup_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'main_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordObscure = true;
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PhoneNumber getNumber = PhoneNumber(isoCode: 'NG');
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  //Function to store all the necessary

  Future storeDetails({String phonenumber}) async {
    String id = _deviceData['id'];
    String product = _deviceData['product'];
    String model = _deviceData['model'];

    String deviceId = product + model + id;
    final pref = await SharedPreferences.getInstance();
    pref.setString('phoneNumber', phonenumber);
    pref.setString('deviceId', deviceId);
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
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
                        child: Container(
                          padding: EdgeInsets.only(left: 5.w),
                          decoration: new BoxDecoration(
                            color: Pallete.secondaryBackround,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: StatefulBuilder(
                            builder: (_context, _setState) {
                              return InternationalPhoneNumberInput(
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
                                initialValue: getNumber,
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
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Pallete.accent),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Pallete.primary))),
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                inputBorder: OutlineInputBorder(),
                                onSaved: (PhoneNumber number) {
                                  print('On Saved: $number');
                                  _setState(() {
                                    getNumber = number;
                                  });
                                },
                              );
                            },
                          ),
                        )),
                    SizedBox(
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: InputWidget.TextInput(
                        icon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordObscure = !_passwordObscure;
                            });
                          },
                          icon: _passwordObscure
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                        ),
                        hintText: 'password',
                        inputType: TextInputType.text,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                      ),
                    ),

                    BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                      if (state is LogInState) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 5.h),
                              child: InkWell(
                                onTap: () async {
                                  // Move to th appropriate screen
                                  if (_formKey.currentState.validate()) {
                                    //move to the right screen
                                    _formKey.currentState.save();
                                    String deviceId = getDeviceId();
                                    print('Device id is ${deviceId}');
                                    mainBloc.add(LogInEvent(
                                      password: _passwordController.text,
                                      phoneNumber: getNumber.phoneNumber,
                                      deviceId: deviceId,
                                    ));
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
                                  mainBloc.add(GoToStateEvent(
                                      inputState: SignUpState()));
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (_) {
                                    return BlocProvider(
                                      create: (context) =>
                                          MainBloc(SignUpState()),
                                      child: SignUpScreen(),
                                    );
                                  }));
                                },
                                child: Container(
                                  height: 6.h,
                                  child: Center(
                                    child: Text(
                                      'Sign up',
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
                      } else if (state is LogInLoadingState) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is LogInError) {
                        mainBloc.add(ResetEvent(inputState: LogInState()));
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          showInSnackBar(state.message);
                        });
                      } else if (state is HomeState) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          storeDetails(phonenumber: getNumber.phoneNumber);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) {
                            return BlocProvider(
                              create: (context) => MainBloc(HomeState()),
                              child: MainScreen(
                                phoneNumber: _phoneNumberController.text,
                                deviceId: getDeviceId(),
                              ),
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
    ));
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        //deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  String getDeviceId() {
    String id = _deviceData['id'];
    String product = _deviceData['product'];
    String model = _deviceData['model'];
    String deviceId = product + model + id;
    return deviceId;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}
