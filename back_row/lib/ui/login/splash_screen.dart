import 'package:back_row/api/preference.dart';
import 'package:back_row/ui/home/bottom_nav_control_page.dart';
import 'package:back_row/ui/login/login_screen.dart';
import 'package:back_row/utils/adaptive_route.dart';
import 'package:back_row/utils/custom_app_button.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () async {
      print("init preference started");
      await Preference.inItPreference();
      print("init preference completed");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 40, right: 40, bottom: 50),
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Image.asset(
                ImageConstant.splashLogo,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                    onTap: () {

                      if(Preference.pref!=null&&Preference.pref.containsKey(USER_ID)&&Preference.pref.getInt(USER_ID).toString().isNotEmpty){
                        final destination = (context) => MyNavigationHomePage();
                        final adaptiveRoute = AdaptiveRoute(
                            context: context, destination: destination);
                        Navigator.pushReplacement(
                            context, adaptiveRoute.getRoute());
                      }
                      else {
                        final destination = (context) => LoginScreen();
                        final adaptiveRoute = AdaptiveRoute(
                            context: context, destination: destination);
                        Navigator.pushReplacement(
                            context, adaptiveRoute.getRoute());
                      }
                    },
                    child:
                        CustomAppButton(content: StringConstant.splashBtnText)))
          ],
        ),
      ),
    );
  }
}
