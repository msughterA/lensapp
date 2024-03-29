import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '/utils/app_themes.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/main_screen_widgets.dart';
import 'camera_screen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:lensapp/models/subject_models.dart';
import 'edit_screen.dart';
import 'plans_screen.dart';
import 'logout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'history_screen.dart';
import 'package:upgrader/upgrader.dart';

void main() {
  runApp(MaterialApp(
    theme: AppThemes.normalTheme,
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  final String phoneNumber;
  final String deviceId;
  const MainScreen({Key key, this.deviceId, this.phoneNumber})
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();

  int currentPageValue = 0;
  List<String> HeaderText = ['Question', 'History', 'Profile'];
  List<String> SubHeaderText = ['categories', 'menu', 'menu'];
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  List<Widget> pages;
  String phoneNumber;
  String username;
  String email;
  String deviceId;
  Future getDetails() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      phoneNumber = pref.getString('phoneNumber');
      username = pref.getString('username');
      email = pref.getString('email');
      deviceId = pref.getString('deviceId');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails().then((value) {});
    print('THE PHONE NUMBER IS ${phoneNumber}');
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      SubjectMenu(),
      HistoryMenu(),
      ProfileMenu(
        phoneNumber: phoneNumber,
        username: username,
        email: email,
        onPressed: () {
          showInSnackBar('Phone number cannot be edited');
        },
      )
    ];
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      drawer: Drawer(
        // All the drawer items would go here
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
                child: Column(
                  children: [
                    Container(
                      height: 20.h,
                      color: Pallete.accent,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 4.w),
                      height: 45.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(context,
                          //         MaterialPageRoute(builder: (_) {
                          //       return BlocProvider.value(
                          //           value: BlocProvider.of<MainBloc>(context),
                          //           child: PlanScreen());
                          //     })).then((value) {
                          //       // Reset the state here
                          //       mainBloc
                          //           .add(ResetEvent(inputState: HomeState()));
                          //     });
                          //   },
                          //   child: Container(
                          //     height: 3.h,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //         Icon(Icons.account_balance_outlined),
                          //         SizedBox(
                          //           width: 2.w,
                          //         ),
                          //         Text('Payment')
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            height: 3.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.info_outlined),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text('About')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            height: 3.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.share_outlined),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text('Share')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Move to the logout screen
                              mainBloc.add(
                                  GoToStateEvent(inputState: LogOutState()));
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                return BlocProvider(
                                    //value: BlocProvider.of<MainBloc>(context),
                                    create: (context) =>
                                        MainBloc(LogOutState()),
                                    child: LogoutScreen(
                                      phoneNumber: widget.phoneNumber,
                                      deviceId: deviceId,
                                    ));
                              }));
                            },
                            child: Container(
                              height: 3.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.logout_outlined),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text('Log out')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      key: _scaffoldState,
      body: UpgradeAlert(
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return Container(
              child: Padding(
                padding: EdgeInsets.only(top: 6.h, left: 5.w, right: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 0.w),
                          child: GestureDetector(
                            onTap: () {
                              _scaffoldState.currentState.openDrawer();
                            },
                            child: Container(
                              child: Icon(Icons.menu_outlined),
                              height: 7.0.h,
                              width: 15.0.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: Theme.of(context).backgroundColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 0.w),
                          child: Container(
                            height: 7.0.h,
                            width: 15.0.w,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Text(
                          HeaderText[currentPageValue],
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          SubHeaderText[currentPageValue],
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pageController.animateToPage(0,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeIn);
                            //setState(() {});
                          },
                          child: CategoryTile(
                            icon: Icon(
                              Icons.book_outlined,
                              color: currentPageValue == 0
                                  ? Pallete.primaryVariant
                                  : Pallete.secondary,
                              size: 5.0.h,
                            ),
                            spacing: 1.0.h,
                            title: 'categories',
                            height: currentPageValue == 0 ? 15.0.h : 12.0.h,
                            width: 25.0.w,
                            radius: 4.0.h,
                            color: currentPageValue == 0
                                ? Theme.of(context).accentColor
                                : Theme.of(context).backgroundColor,
                            textColor: currentPageValue == 0
                                ? Pallete.primaryVariant
                                : Pallete.secondary,
                          ),
                        ),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.animateToPage(1,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeIn);
                            //setState(() {});
                          },
                          child: CategoryTile(
                            icon: Icon(
                              Icons.history_outlined,
                              color: currentPageValue == 1
                                  ? Pallete.primaryVariant
                                  : Pallete.secondary,
                              size: 5.0.h,
                            ),
                            spacing: 1.0.h,
                            title: 'History',
                            height: currentPageValue == 1 ? 15.0.h : 12.0.h,
                            width: 25.0.w,
                            radius: 4.0.h,
                            color: currentPageValue == 1
                                ? Theme.of(context).accentColor
                                : Theme.of(context).backgroundColor,
                            textColor: currentPageValue == 1
                                ? Pallete.primaryVariant
                                : Pallete.secondary,
                          ),
                        ),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.animateToPage(2,
                                duration: Duration(milliseconds: 250),
                                curve: Curves.easeIn);
                            //setState(() {});
                          },
                          child: CategoryTile(
                            icon: Icon(
                              Icons.person_outlined,
                              color: currentPageValue == 2
                                  ? Pallete.primaryVariant
                                  : Pallete.secondary,
                              size: 5.0.h,
                            ),
                            spacing: 1.0.h,
                            title: 'Profile',
                            height: currentPageValue == 2 ? 15.0.h : 12.0.h,
                            width: 25.0.w,
                            radius: 4.0.h,
                            color: currentPageValue == 2
                                ? Theme.of(context).accentColor
                                : Theme.of(context).backgroundColor,
                            textColor: currentPageValue == 2
                                ? Pallete.primaryVariant
                                : Pallete.secondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    //ProfileMenu()
                    //SubjectMenu()
                    //HistoryMenu()
                    pages != null
                        ? Expanded(
                            child: PageView.builder(
                                onPageChanged: (value) {
                                  setState(() {
                                    currentPageValue = value;
                                  });
                                },
                                itemCount: pages.length,
                                controller: pageController,
                                itemBuilder: (context, index) {
                                  return pages[index];
                                }))
                        : Expanded(
                            child: Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    _scaffoldState.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }
}

// Menu of subject Categories
class SubjectMenu extends StatelessWidget {
  const SubjectMenu({Key key}) : super(key: key);
  Future<List<CameraDescription>> initializeCameras() async {
    //cameras = await availableCameras();
    return await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    final subBloc = BlocProvider.of<MainBloc>(context);
    return StaggeredGridView.countBuilder(
      // addRepaintBoundaries: false,
      // shrinkWrap: false,
      padding: EdgeInsets.all(0),
      crossAxisCount: 2,
      // change item count to 4 to eliminate chemistry
      itemCount: 4,
      crossAxisSpacing: 4.0.w,
      mainAxisSpacing: 2.0.h,
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            // Go to the camera screen
            // WidgetsFlutterBinding.ensureInitialized();
            List<CameraDescription> cameras = await initializeCameras();
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<MainBloc>(context),
                child: CameraScreen(
                  color: subjectModels[index].color,
                  cameras: cameras,
                  modes: subjectModels[index].modes,
                  module: Module.values[index],
                ),
              );
            })).then((value) {
              subBloc.add(GoToStateEvent(inputState: HomeState()));
            });
          },
          child: SubjectTile(
            icon: subjectModels[index].icon,
            index: index,
            spacing: 5.0.h,
            tileEvenHeight: 25.0.h,
            tileOddHeight: 20.0.h,
            tileBorderRadius: 3.0.h,
            title: subjectModels[index].subjectName,
            color: subjectModels[index].color,
          ),
        );
      },
    );
  }
}

// Profile Menu
class ProfileMenu extends StatelessWidget {
  final String phoneNumber;
  final String username;
  final String email;
  final Function onPressed;
  ProfileMenu(
      {Key key, this.phoneNumber, this.email, this.username, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subBloc = BlocProvider.of<MainBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 20.0.h,
          width: 20.0.h,
          child: Icon(
            Icons.person_outlined,
            size: 13.h,
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0.h))),
        ),
        SizedBox(
          height: 2.0.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Email:   ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(email),
              ],
            ),
            IconButton(
                onPressed: () {
                  subBloc.add(GoToEdit());
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                        value: BlocProvider.of<MainBloc>(context),
                        child: EditScreen(
                          fieldIndex: EditMode.email.index,
                          phoneNumber: phoneNumber,
                        ));
                  })).then((value) {
                    // Reset the state here
                    subBloc.add(ResetEvent(inputState: HomeState()));
                  });
                },
                icon: Icon(Icons.edit))
          ],
        ),
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Username:   ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(username),
              ],
            ),
            IconButton(
                onPressed: () {
                  subBloc.add(GoToEdit());
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                        value: BlocProvider.of<MainBloc>(context),
                        child: EditScreen(
                          fieldIndex: EditMode.username.index,
                          phoneNumber: phoneNumber,
                        ));
                  })).then((value) {
                    // Reset the state here
                    subBloc.add(ResetEvent(inputState: HomeState()));
                  });
                },
                icon: Icon(Icons.edit))
          ],
        ),
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'phone:   ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(phoneNumber)
              ],
            ),
            IconButton(
                onPressed: () {
                  //subBloc.add(GoToEdit());
                  onPressed();
                },
                icon: Icon(Icons.edit))
          ],
        ),
        SizedBox(
          height: 2.0.h,
        ),
      ],
    );
  }
}

//History Menu

class HistoryMenu extends StatelessWidget {
  const HistoryMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: subjectModels.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          var title = subjectModels[itemIndex].subjectName;
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HistoryScreen(
                  module: Module.values[itemIndex],
                );
              }));
            },
            child: Container(
              height: 50.h,
              width: 40.w,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('saved'),
                    subjectModels[itemIndex].icon,
                    Text('${title}')
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.h)),
                color: subjectModels[itemIndex].color,
              ),
            ),
          );
        },
        options: CarouselOptions(
          // height: 40.0.h,
          aspectRatio: 4 / 3,
          viewportFraction: 0.5,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
        ));
  }
}

enum EditMode { email, username, phone }
enum Module { mathematics, summarizer, examples, gst, chemistry }
