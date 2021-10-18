import 'dart:convert';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/api/preference.dart';
import 'package:back_row/ui/home/bottom_nav_control_page.dart';
import 'package:back_row/utils/adaptive_route.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/custom_app_button.dart';
import 'package:back_row/utils/custom_dialog.dart';
import 'package:back_row/utils/custom_text_field.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:back_row/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final dialog= CustomDialog();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 20, bottom: 20, top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  StringConstant.signInTitle,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  StringConstant.signInTitleContent,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                controller: emailController,
                fillBorderWithColor: true,
                fromChangePassword: true,
                label: StringConstant.userName,
                validator: validateUserNameField,
                save: (value) {
                  print('username $value');
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                fillBorderWithColor: true,
                fromChangePassword: true,
                isObscure: true,
                hint: StringConstant.password,
                label: StringConstant.password,
                validator: validateUserNameField,
                save: (value) {
                  print('username $value');
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: (){
                      checkLogin(context);
                    },
                      child: CustomAppButton(content: StringConstant.signin)
                      )),
              Visibility(
                visible: false,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: CustomAppButton(
                    content: StringConstant.signinApple,
                    gradientColors: LinearGradient(colors: [
                      Colors.black,
                      Colors.black,
                    ], begin: Alignment.centerLeft),
                    iconName: ImageConstant.appleIcon,
                    isPrefixIcon: true,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: false,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    StringConstant.noAccount,
                    style: TextStyle(
                      color: ColorConstant.titlesColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void checkLogin(BuildContext context) async {
    if (validate(context)) {
      final body = json.encode(
          {
            "email": emailController.text.toString(),
            "password": passwordController.text.toString(),
          }
      );
      FocusScope.of(context).unfocus();
      dialog.show(context, IS_LOADING_DIALOG);
      http.Response res = await ApiRoute.callRouteAPI(url: LOGIN_URL,
          body: body,
          callMethod: POST,
          isWithToken: false,
          context: context);
      print(res);
      final response = json.decode(res.body);
      dialog.hide(context);
      if (res.statusCode == 200) {
        print(res);
        Preference.pref.setInt(USER_ID, response['data']["id"]);
        StaticMethods.snackBar("Login successful",context);
        dialog.hide(context);
        final destination = (context) => MyNavigationHomePage();
        final adaptiveRoute = AdaptiveRoute(
            context: context, destination: destination);
        Navigator.pushAndRemoveUntil(
            context, adaptiveRoute.getRoute(),(Route<dynamic> route) => false);
      }
      else if (res.statusCode == 199) {
        StaticMethods.snackBar(
            "Something went wrong. Please try again.", context);
      }
      else {
        StaticMethods.snackBar(response['data']['error'], context);
      }
    }
  }

  bool validate(BuildContext context) {
    if(emailController.text.toString().isEmpty)
      {
        StaticMethods.snackBar("Please Enter your email", context);
        return false;
      }
    else if(passwordController.text.trim().isEmpty)
      {
        StaticMethods.snackBar("Please Enter your password", context);
        return false;
      }
    else{
      return true;
    }
  }
}


