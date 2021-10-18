import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveRoute {
  final BuildContext context;
  final Function(BuildContext context) destination;

  AdaptiveRoute({@required this.context, @required this.destination});

  Route getRoute() {
    final targetPlatform = Theme.of(context).platform;
    return targetPlatform == TargetPlatform.iOS
        ? CupertinoPageRoute(builder: destination)
        : MaterialPageRoute(builder: destination);
  }
}
