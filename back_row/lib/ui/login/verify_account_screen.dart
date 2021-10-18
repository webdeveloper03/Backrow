import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/custom_app_button.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:back_row/utils/font_style.dart';


class VerifyAccountScreen extends StatefulWidget {
  @override
  _VerifyAccountScreenState createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  StringConstant.verifyAccount,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30,),

              Container(
                child: Text(
                  StringConstant.verifyAccountContent,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Container(
                child: Text(
                  "+000-000000000",
                  style: TextStyle(
                    color: ColorConstant.customBtnGradient2,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 60,),

              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      height: 70,
                      width:70,
                      child:  TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                     //   maxLength: 1,
                          inputFormatters:[
                            LengthLimitingTextInputFormatter(1),
                          ],
                        toolbarOptions: ToolbarOptions(
                            copy: true, cut: true, paste: true, selectAll: true),
                        cursorColor: Colors.black,
                        style:TextStyle(color: Colors.black, fontSize: 30),
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
                          hintStyle: FontStyle.labelTextStyle.copyWith(color: ColorConstant.textFieldFillColor.withOpacity(1)),
                          labelStyle: FontStyle.labelTextStyle.copyWith(
                              color:  Colors.black.withOpacity(0.9)),
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      height: 70,
                      width:70,
                      child:  TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        //   maxLength: 1,
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(1),
                        ],
                        toolbarOptions: ToolbarOptions(
                            copy: true, cut: true, paste: true, selectAll: true),
                        cursorColor: Colors.black,
                        style:TextStyle(color: Colors.black, fontSize: 30),
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
                          hintStyle: FontStyle.labelTextStyle.copyWith(color: ColorConstant.textFieldFillColor.withOpacity(1)),
                          labelStyle: FontStyle.labelTextStyle.copyWith(
                              color:  Colors.black.withOpacity(0.9)),
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      height: 70,
                      width:70,
                      child:  TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        //   maxLength: 1,
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(1),
                        ],
                        toolbarOptions: ToolbarOptions(
                            copy: true, cut: true, paste: true, selectAll: true),
                        cursorColor: Colors.black,
                        style:TextStyle(color: Colors.black, fontSize: 30),
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
                          hintStyle: FontStyle.labelTextStyle.copyWith(color: ColorConstant.textFieldFillColor.withOpacity(1)),
                          labelStyle: FontStyle.labelTextStyle.copyWith(
                              color:  Colors.black.withOpacity(0.9)),
                        ),
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10,right: 10),
                      height: 70,
                      width:70,
                      child:  TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        //   maxLength: 1,
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(1),
                        ],
                        toolbarOptions: ToolbarOptions(
                            copy: true, cut: true, paste: true, selectAll: true),
                        cursorColor: Colors.black,
                        style:TextStyle(color: Colors.black, fontSize: 30),
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
                          hintStyle: FontStyle.labelTextStyle.copyWith(color: ColorConstant.textFieldFillColor.withOpacity(1)),
                          labelStyle: FontStyle.labelTextStyle.copyWith(
                              color:  Colors.black.withOpacity(0.9)),
                        ),
                      )
                  ),
                ],
              ),
            SizedBox(height: 50,),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  StringConstant.otpTimeLine,
                  style: TextStyle(
                    color: ColorConstant.titlesColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 6,),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      StringConstant.didNotGetCode,
                      style: TextStyle(
                        color: ColorConstant.titlesColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),Text(
                      StringConstant.recendCode,
                      style: TextStyle(
                        color: ColorConstant.customBtnGradient2,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(

                    margin: EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.bottomCenter,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: CustomAppButton(content: StringConstant.continueText)),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
