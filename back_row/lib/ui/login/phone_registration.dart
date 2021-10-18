import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/custom_app_button.dart';
import 'package:back_row/utils/custom_text_field.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:back_row/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:back_row/utils/font_style.dart';

import 'package:flutter/material.dart';

class PhoneRegistrationScreen extends StatefulWidget {
  @override
  _PhoneRegistrationScreenState createState() => _PhoneRegistrationScreenState();
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
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
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  StringConstant.phoneRegistration,
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
                  StringConstant.phoneRegistrationContent,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  StringConstant.location,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child:  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 10),
                        height:30,width:30,
                        child: Image.asset(ImageConstant.accountSuccess),),
                        Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            child: VerticalDivider(color: Colors.grey,))
                    ],),
                    design()
                    ],
                  )
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  StringConstant.phoneNumber,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                height: 55,
                width: MediaQuery.of(context).size.width,
                child:  TextFormField(
                  keyboardType: TextInputType.phone,
                  toolbarOptions: ToolbarOptions(
                      copy: true, cut: true, paste: true, selectAll: true),
                  cursorColor: Colors.black,
                  style:TextStyle(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: ColorConstant.textFieldBorderColor, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: ColorConstant.textFieldBorderColor, width: 2.0)),
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    filled: true,
                    fillColor:
                        ColorConstant.textFieldBorderColor.withAlpha(35),
                    hintText: "+000000000000",
                    hintStyle: FontStyle.labelTextStyle.copyWith(color: ColorConstant.textFieldFillColor.withOpacity(1)),
                    labelStyle: FontStyle.labelTextStyle.copyWith(
                        color:  Colors.black.withOpacity(0.9)),
                  ),
                )
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: CustomAppButton(content: StringConstant.continueText)),

              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  StringConstant.registerTandC,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 15,
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

  design() {
    return   TextFormField(
        enabled: false,
    style:TextStyle(color: ColorConstant.textFieldBorderColor.withOpacity(0.1), fontSize: 14),
    decoration: InputDecoration(
    enabledBorder:OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(
    color:ColorConstant.textFieldBorderColor.withOpacity(0.1), width: 2.0)),
    focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(
    color: ColorConstant.textFieldBorderColor.withOpacity(0.1), width: 2.0)),
    border:OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    ),
    contentPadding:
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    filled: true,
    fillColor:
    ColorConstant.textFieldBorderColor.withOpacity(0.1),
    labelStyle: FontStyle.labelTextStyle.copyWith(
    color: ColorConstant.textFieldBorderColor.withOpacity(0.1)),
    ),
    );
  }
}
