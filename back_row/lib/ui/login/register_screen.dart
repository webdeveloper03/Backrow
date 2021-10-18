import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/custom_app_button.dart';
import 'package:back_row/utils/custom_text_field.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:back_row/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  StringConstant.loginwWelcome,
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
                child: Text(
                  StringConstant.loginwWelcomeContent1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                child: Text(
                  StringConstant.loginwWelcomeContent2,
                  textAlign: TextAlign.center,
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
                fillBorderWithColor: true,
                fromChangePassword: true,
                label: StringConstant.firstName,
                validator: validateUserNameField,
                save: (value) {
                  print('username $value');
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                fillBorderWithColor: true,
                fromChangePassword: true,
                hint: StringConstant.email,
                label: StringConstant.email,
                validator: validateUserNameField,
                save: (value) {
                  print('username $value');
                },
              ),
              CustomTextField(
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
              CustomTextField(
                fillBorderWithColor: true,
                fromChangePassword: true,
                isObscure: true,
                hint: StringConstant.mobile,
                label: StringConstant.mobile,
                validator: validateUserNameField,
                save: (value) {
                  print('username $value');
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    SvgPicture.asset(ImageConstant.uncheck),
                    SizedBox(width: 10),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        StringConstant.tc,
                        style: TextStyle(
                          color: ColorConstant.titlesColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: CustomAppButton(content: StringConstant.signupBtnText)),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                alignment: Alignment.center,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: CustomAppButton(content: StringConstant.signupAppleBtnText,
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
                ),),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  StringConstant.alreadyHaveAccount,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
