import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_url.dart';

const String USER_ID="USER_ID";
const String AC="AC";
const String CC="CC";
const String CD="CD";

class Preference {
  static SharedPreferences pref;

  static inItPreference() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> getPreference() async {
    return pref;
  }
}

class StaticMethods{
  static snackBar(String message,BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static String getIndexBasedURL(int homePageSelectedIndex) {
    String url;
    if (homePageSelectedIndex == 0) {
      url = SO_RECENT_URL;
    } else if (homePageSelectedIndex == 1) {
      url = RECENT_AGENDA_URL;
    } else if (homePageSelectedIndex == 2) {
      url = RECENT_MATERIAL_URL;
    } else if (homePageSelectedIndex == 3) {
      url = SIZE_PLOT_URL;
    } else if (homePageSelectedIndex == 4) {
      url = REPORT_URL;
    } else if (homePageSelectedIndex == 5) {
      url = BOOKING_URL;
    } else {
      url = SO_RECENT_URL;
    }
    return url;
  }

}


