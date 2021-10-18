import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'color.dart';

class AdaptiveTheme extends StatelessWidget {
  final Widget child;

  AdaptiveTheme({this.child});

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
        theme: NeumorphicThemeData(
            baseColor: Colors.grey[900],
            accentColor: ColorConstant.customBtnTextColor,
            defaultTextColor: Colors.white,
            disableDepth: true),
        child: child);
  }
}
