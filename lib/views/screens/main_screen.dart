import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/avd.dart';
//import 'package:flutter_svg/';
import '/utils/app_themes.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../widgets/main_screen_widgets.dart';
import 'camera_screen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:lensapp/models/subject_models.dart';

void main() {
  runApp(MaterialApp(
    theme: AppThemes.normalTheme,
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController();

  int currentPageValue = 0;
  List<String> HeaderText = ['Subject', 'History', 'Profile'];
  List<Widget> pages = [SubjectMenu(), HistoryMenu(), ProfileMenu()];
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      drawer: Drawer(
          // All the drawer items would go here
          ),
      key: _scaffoldState,
      body: Sizer(
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
                          child: Icon(Icons.search_outlined),
                          height: 7.0.h,
                          width: 15.0.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Theme.of(context).backgroundColor),
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
                        'Menu',
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
                            Icons.menu_book_outlined,
                            color: currentPageValue == 0
                                ? Pallete.primaryVariant
                                : Pallete.secondary,
                            size: 5.0.h,
                          ),
                          spacing: 1.0.h,
                          title: 'Subjects',
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
                            Icons.edit_outlined,
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
                  Expanded(
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
                ],
              ),
            ),
          );
        },
      ),
    );
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
    return StaggeredGridView.countBuilder(
      // addRepaintBoundaries: false,
      // shrinkWrap: false,

      padding: EdgeInsets.all(0),
      crossAxisCount: 2,
      itemCount: 5,
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
                  cameras: cameras,
                  modes: subjectModels[index].modes,
                ),
              );
            }));
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
  const ProfileMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 20.0.h,
          width: 20.0.h,
          child: Image.asset(
            'assets/images/user.png',
            height: 20.0.h,
            width: 20.0.h,
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0.h))),
        ),
        SizedBox(
          height: 2.0.h,
        ),
        Row(
          children: [
            Text(
              'Email: ',
              style: TextStyle(fontSize: 20),
            ),
            Text('sample@gmail.com')
          ],
        ),
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          children: [
            Text(
              'Username: ',
              style: TextStyle(fontSize: 20),
            ),
            Text('Msughter')
          ],
        ),
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          children: [
            Text(
              'phone: ',
              style: TextStyle(fontSize: 20),
            ),
            Text('+23480891204')
          ],
        ),
        SizedBox(
          height: 2.0.h,
        ),
        Container(
          width: 90.0.w,
          height: 5.0.h,
          child: Center(
            child: Text(
              'Edit',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.all(Radius.circular(2.0.h))),
        )
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
          return Container(
            height: 50.h,
            width: 40.w,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('200 queries'),
                  subjectModels[itemIndex].icon,
                  Text('${title}')
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.h)),
              color: subjectModels[itemIndex].color,
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
