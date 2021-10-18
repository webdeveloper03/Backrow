import 'dart:async';

import 'package:back_row/api/preference.dart';
import 'package:back_row/ui/home/home_page.dart';
import 'package:back_row/ui/home/profile.dart';
import 'package:back_row/ui/home/report.dart';
import 'package:back_row/ui/home/site_overview.dart';
import 'package:back_row/ui/login/login_screen.dart';
import 'package:back_row/utils/adaptive_route.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/custom_botton_nav.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

PageController _pageController;
PersistentTabController _controller;
bool isHide = false;
StreamController loadStream;

class MyNavigationHomePage extends StatefulWidget {
  static PersistentTabController getPageController() => _controller;

  @override
  _MyNavigationHomePageState createState() => _MyNavigationHomePageState();
}

class _MyNavigationHomePageState extends State<MyNavigationHomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadStream = StreamController.broadcast();
    _controller = PersistentTabController(initialIndex: 0);
    _pageController = PageController();
  }

  @override
  void dispose() {
    loadStream.close();
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // transparent status bar
        systemNavigationBarColor: Colors.black,
        // navigation bar color
        statusBarIconBrightness: Brightness.dark,
        // status bar activeIcons' color
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: StreamBuilder(
            stream: loadStream.stream,
            builder: (context, snapshot) {
              return PersistentTabView(
                context,
                controller: _controller,
                onItemSelected: (index) {
                  setState(() {});
                },
                hideNavigationBar: isHide,
                screens: [
                  MyHomePage(loadStream: loadStream),
                  SiteOverviewPage(),
                  ReportPage(),
                  ProfilePage(onLogout:(){
                    Preference.pref.clear();
                    _controller.dispose();
                    final destination = (context) => LoginScreen();
                    final adaptiveRoute = AdaptiveRoute(
                        context: context, destination: destination);
                    Navigator.pushAndRemoveUntil(
                        context, adaptiveRoute.getRoute(),(Route<dynamic> route) => false);
                  })
                ],
                items: _navBarsItems(),
                confineInSafeArea: true,
                backgroundColor: Colors.white,
                // Default is Colors.white.
                handleAndroidBackButtonPress: true,
                // Default is true.
                resizeToAvoidBottomInset: true,
                // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                stateManagement: true,
                // Default is true.
                hideNavigationBarWhenKeyboardShows: true,
                // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                decoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  colorBehindNavBar: Colors.white,
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: ItemAnimationProperties(
                  // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: ScreenTransitionAnimation(
                  // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle
                    .style6, // Choose the nav bar style with this property.
              );
            })
        /*Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                children: <Widget>[
                  MyHomePage(),
                  SiteOverviewPage(),
                  ReportPage(),
                  ProfilePage()
                ],
              ),
              Visibility(
                visible: false,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavigationBar(
                    selectedIndex: _currentIndex,
                    onItemSelected: (index) {
                      setState(() => _currentIndex = index);
                      _pageController.jumpToPage(index);
                    },
                    items: <CustomBottomNavyBarItem>[
                      CustomBottomNavyBarItem(
                          title: Text(StringConstant.home),
                          inActiveIcon: SvgPicture.asset(
                            ImageConstant.home,
                            color: Colors.white,
                          ),
                          activeIcon: SvgPicture.asset(ImageConstant.home,
                              color: ColorConstant.navIconColor),
                          inactiveColor: Colors.white,
                          activeColor: ColorConstant.navIconColor),
                      CustomBottomNavyBarItem(
                          title: Text(StringConstant.overview),
                          inActiveIcon: SvgPicture.asset(
                            ImageConstant.so,
                            color: Colors.white,
                          ),
                          activeIcon: SvgPicture.asset(ImageConstant.so,
                              color: ColorConstant.navIconColor),
                          inactiveColor: Colors.white,
                          activeColor: ColorConstant.navIconColor),
                      CustomBottomNavyBarItem(
                          title: Text(StringConstant.report),
                          inActiveIcon: SvgPicture.asset(
                            ImageConstant.report,
                            color: Colors.white,
                          ),
                          activeIcon: SvgPicture.asset(ImageConstant.report,
                              color: ColorConstant.navIconColor),
                          inactiveColor: Colors.white,
                          activeColor: ColorConstant.navIconColor),
                      CustomBottomNavyBarItem(
                          title: Text(StringConstant.profile),
                          inActiveIcon: SvgPicture.asset(
                            ImageConstant.profile,
                            color: Colors.white,
                          ),
                          activeIcon: SvgPicture.asset(ImageConstant.profile,
                              color: ColorConstant.navIconColor),
                          inactiveColor: Colors.white,
                          activeColor: ColorConstant.navIconColor),
                    ],
                  ),
                ),
              )
            ],
          ),
        )*/
        ,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/bot_icon1.png",
          height: 20,
          width: 20,
          color: (_controller.index == 0)
              ? CupertinoColors.black
              : CupertinoColors.black.withOpacity(0.6),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/bot_icon2.png",
          height: 24,
          width: 24,
          color: (_controller.index == 1)
              ? CupertinoColors.black
              : CupertinoColors.black.withOpacity(0.6),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/bot_icon3.png",
          height: 20,
          width: 20,
          color: (_controller.index == 2)
              ? CupertinoColors.black
              : CupertinoColors.black.withOpacity(0.6),
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/bot_icon4.png",
          height: 20,
          width: 20,
          color: (_controller.index == 3)
              ? CupertinoColors.black
              : CupertinoColors.black.withOpacity(0.6),
        ),
      ),
    ];
  }
}
