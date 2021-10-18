import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'color.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final targetPlatform = Theme.of(context).platform;
    return targetPlatform == TargetPlatform.iOS ? _IOSApp() : _AndroidApp();
  }
}

class _IOSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CupertinoActivityIndicator(
      radius: 14.0,
    ));
  }
}

class _AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor:
            AlwaysStoppedAnimation<Color>(ColorConstant.customBtnGradient1),
      ),
    );
  }
}
