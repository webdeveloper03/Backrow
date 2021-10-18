
import 'package:back_row/api/preference.dart';
import 'package:back_row/utils/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const String GET="0";
const String POST="1";
const String DELETE="2";
const String PATCH="3";
class ApiRoute{
  static Future<http.Response>callRouteAPI({String url,String body,String callMethod,bool isWithToken,BuildContext context})async {
    try {
      final header = (isWithToken)
          ? await getHeaderWithToken()
          : await getHeader();
      if(callMethod!=GET) showCurrentURLHitData(body, url, header.toString());
      http.Response result;
      if (callMethod == GET) {
        showCurrentURLHitData(body, url+Preference.pref.getInt(USER_ID).toString(), header.toString());
        result = await http.get(Uri.parse(url+Preference.pref.getInt(USER_ID).toString()), headers: header);
      }
      else if (callMethod == POST) {
        result = await http.post(Uri.parse(url), body: body, headers: header);
      }
      else if (callMethod == DELETE) {
        result = await http.delete(Uri.parse(url), headers: header);
      }
      else if (callMethod == PATCH) {
        result = await http.patch(Uri.parse(url), body: body, headers: header);
      }
      print(result.body);
      return result;
    }
    catch(e){
     return http.Response("",199);
    }

  }
}

Future<dynamic> getHeaderWithToken() async {
  SharedPreferences preference = await Preference.getPreference();
  return {
    "Content-Type": "application/json",
    "Authorization": preference.getString(USER_ID)
  };
}

Future<dynamic> getHeader() async {
  return {"Content-Type": "application/json"};
}

void showCurrentURLHitData(String body, String url, String token) {
  print("********URL******");
  print(url);
  print("********ReqquestData******");
  print(body);
  print("********Token******");
  print(token);
}
