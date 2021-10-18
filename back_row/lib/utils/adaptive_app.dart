import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AdaptiveApp extends StatefulWidget {
  final Widget child;

  AdaptiveApp({@required this.child});

  @override
  _AdaptiveAppState createState() => _AdaptiveAppState();
}

class _AdaptiveAppState extends State<AdaptiveApp> {
  @override
  void initState() {
    // changeLocale(context, 'de');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('de', 'DE'),
      ],
      theme: ThemeData(
          primaryColor: Colors.red,
          cursorColor: Colors.blue,
          textTheme: TextTheme(
              bodyText2: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold))),
      home: widget.child,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}
