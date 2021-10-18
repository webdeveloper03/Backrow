import 'dart:ui';

import 'package:flutter/material.dart';

class FontStyle {
  static TextStyle inputTopLabelTextStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: Colors.white,
      fontSize: 17.0,
      fontFamily: 'Poppins'),
      normalTextStyle = TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 15.0,
          fontFamily: 'Lato'),
      smallContentStyle = normalTextStyle.copyWith(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.normal),
      inputTextStyle = normalTextStyle.copyWith(
          color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.normal),
      labelTextStyle = smallContentStyle
        ..copyWith(color: Colors.black, fontSize: 15.0);
}