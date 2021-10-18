
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
const String IS_LOADING_DIALOG="2";

class CustomDialog {
  final String title;
  final String content;
  final bool isToogleButtonEnabled;
  final bool isActionButtonEnabled;
  final String actionButtonTitle1;
  final String actionButtonTitle2;
  final VoidCallback actionCallback1;
  final VoidCallback actionCallback2;
  final double width;
  final double height;

  CustomDialog(
      {this.title,
        this.content,
        this.isToogleButtonEnabled = false,
        this.actionButtonTitle1,
        this.actionButtonTitle2,
        this.isActionButtonEnabled = false,
        this.actionCallback1,
        this.actionCallback2,
        this.width,
        this.height});

  dynamic show(BuildContext buildContext, String flag) async {
    return showCupertinoDialog(
        context: buildContext,
        builder: (BuildContext context) {
          return Dialog(
            insetAnimationDuration: const Duration(milliseconds: 200),
            insetAnimationCurve: Curves.bounceOut,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child:
                 loadingDialog(context)
          );
        });
  }
  void hide(BuildContext buildContext) async {
      Navigator.of(buildContext).pop();
  }

  Widget loadingDialog(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: Container(
          child: SizedBox(
              height: 70,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Loading...", style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),),
                  Container(
                      height: 30, width: 30,
                      child: (Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator())
                  )
                ],)
          ),
        ));
  }}