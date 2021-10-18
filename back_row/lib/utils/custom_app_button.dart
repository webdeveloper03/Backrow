import 'package:back_row/utils/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'color.dart';

class CustomAppButton extends StatefulWidget {
  final String content;
  final TextStyle style;
  final LinearGradient gradientColors;
  final double height;
  final double width;
  final bool isPrefixIcon;
  final bool isSuffixIcon;
  final String iconName;
  final Function onPressed;

  CustomAppButton(
      {this.content, this.style, this.height, this.onPressed, this.width, this.gradientColors,
        this.isPrefixIcon, this.isSuffixIcon, this.iconName});

  @override
  _CustomAppButtonState createState() => _CustomAppButtonState();
}

class _CustomAppButtonState extends State<CustomAppButton> {
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: widget.width ?? MediaQuery
            .of(context)
            .size
            .width,
        height: widget.height ?? 55.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: widget.gradientColors ?? LinearGradient(colors: [
              ColorConstant.black.withOpacity(0.7),
              ColorConstant.black,
            ], begin: Alignment.topCenter,end: Alignment.bottomCenter)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (widget.isPrefixIcon??false)?Container(
              margin: EdgeInsets.only(right: 20),
                child: SvgPicture.asset(ImageConstant.appleIcon)):Container(),
            Text(
              widget.content,
              style: widget.style ??
                  TextStyle(
                      fontSize: 18.0,
                      color: ColorConstant.customBtnTextColor,
                      fontWeight: FontWeight.w700),
            ),
            (widget.isSuffixIcon??false)?Container(
                margin: EdgeInsets.only(left: 20),
                child: SvgPicture.asset(ImageConstant.appleIcon)):Container(),

          ],
        ),
      ),
    );
  }
}
