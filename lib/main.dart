import 'package:flutter/material.dart';
import '/utils/app_themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/views/screens/login_screen.dart';
import '/views/screens/main_screen.dart';
import '/bloc/main_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:flutter_loc';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.normalTheme,
      home: LoginHomeRouting(),
    );
  }
}

class LoginHomeRouting extends StatefulWidget {
  const LoginHomeRouting({Key key}) : super(key: key);

  @override
  _LoginHomeRoutingState createState() => _LoginHomeRoutingState();
}

class _LoginHomeRoutingState extends State<LoginHomeRouting> {
  String phoneNumber;
  String email;
  String deviceId;
  String username;
  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    //final mainBloc = BlocProvider.of<MainBloc>(context);
    if (phoneNumber == null || deviceId == null) {
      //mainBloc.add(GoToStateEvent(inputState: LogInState()));
      return BlocProvider(
        create: (context) => MainBloc(LogInState()),
        child: LoginScreen(),
      );
    } else {
      //mainBloc.add(GoToStateEvent(inputState: HomeState()));
      return BlocProvider(
        create: (context) => MainBloc(HomeState()),
        child: MainScreen(
          phoneNumber: phoneNumber,
        ),
      );
    }
  }

  Future getDetails() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      phoneNumber = pref.getString('phoneNumber');
      deviceId = pref.getString('deviceId');
    });
  }
}
