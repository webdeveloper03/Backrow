import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/custom_app_button.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountCreatedSuccessScreen extends StatefulWidget {
  @override
  _AccountCreatedSuccessScreenState createState() => _AccountCreatedSuccessScreenState();
}

class _AccountCreatedSuccessScreenState extends State<AccountCreatedSuccessScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 130),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 40, right: 40,bottom: 50),
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              child: Image.asset(
                ImageConstant.accountSuccess,
              ),
            ),
            Container(
              child: Text(
                StringConstant.accountCreated,
                style: TextStyle(
                  color: ColorConstant.titlesColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(
                StringConstant.accountCreatedContent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorConstant.titlesColor,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 30, right: 30,bottom: 30),
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child:
                  CustomAppButton(content: StringConstant.continueText)),
            )
          ],
        ),
      ),
    );
  }
}
