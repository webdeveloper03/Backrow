import 'package:back_row/ui/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/api/preference.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/custom_app_button.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;


class ProfilePage extends StatefulWidget {
  final Function onLogout;
  ProfilePage({this.onLogout});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  String ac, cc,cd;
  String name;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bodyView();

  }



  bodyView() {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.all(20),
        child: GestureDetector(
          onTap:  widget.onLogout,
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_rounded,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Logout",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: getData(),
        builder: (context, snapshot) {
          if(snapshot.hasData)
            {
              return Container(
                margin: EdgeInsets.only(left: 20,bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 60),
                          child: Text(
                            name ?? "sample name",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.black),
                          ),
                        ),InkWell(
                          onTap: (){
                            setState(() {
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.transparent,
                            margin: EdgeInsets.only(top: 60,right: 30),
                            child: Icon(Icons.refresh_rounded,color: Colors.black,size: 30,),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.black),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "GHC " + Preference.pref.getString(CC).toString() ?? "",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ColorConstant.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text(
                                    StringConstant.conCost,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: ColorConstant.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "GHC " + Preference.pref.getString(AC).toString() ?? "",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ColorConstant.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    StringConstant.actCost,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: ColorConstant.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:30),
                      child: Text(
                        "Package",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.black),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 30),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          alignment: Alignment.centerLeft,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data["data"]['package']['name'],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.black),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "${snapshot.data["data"]['package']['start_date']} - ${snapshot.data["data"]['package']['end_date']}",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.black.withOpacity(0.4)),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Date Paid : ${snapshot.data["data"]['package']['paid_date']}",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.black.withOpacity(0.4)),
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Payment type - ${snapshot.data["data"]['package']['pay_type']}",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.black.withOpacity(0.4)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }

  getAssetIcon(int index) {
    if (index == 0) {
      return SvgPicture.asset(
        ImageConstant.siteOverviewItemIcon,
        height: 32,
        width: 32,
      );
    } else if (index == 1) {
      return SvgPicture.asset(
        ImageConstant.progresItemIcon,
        height: 32,
        width: 32,
      );
    } else if (index == 2) {
      return SvgPicture.asset(
        ImageConstant.materialItemIcon,
        height: 32,
        width: 32,
      );
    } else if (index == 3) {
      return SvgPicture.asset(
        ImageConstant.budgetItemIcon,
        height: 32,
        width: 32,
      );
    } else if (index == 4) {
      return SvgPicture.asset(
        ImageConstant.milestoneItemIcon,
        height: 32,
        width: 32,
      );
    } else if (index == 5) {
      return SvgPicture.asset(
        ImageConstant.reportItemIcon,
        height: 32,
        width: 32,
      );
    }
  }

  getAssetItemName(int index) {
    if (index == 0) {
      return StringConstant.siteOverview;
    } else if (index == 1) {
      return StringConstant.siteAgenda;
    } else if (index == 2) {
      return StringConstant.material;
    } else if (index == 3) {
      return StringConstant.budget;
    } else if (index == 4) {
      return StringConstant.reportMenu;
    } else if (index == 5) {
      return StringConstant.booking;
    }
  }

  Future<dynamic> getData() async {
    http.Response res = await ApiRoute.callRouteAPI(
        url: DASHBOARD_URL,
        body: "",
        callMethod: GET,
        isWithToken: false,
        context: context);
    print(res.body);
    final response = json.decode(res.body);
    ac = response['data']['actual_cost']['cost'].toString();
    cc = response['data']['construction']['cost'].toString();
    Preference.pref.setString(AC, ac);
    Preference.pref.setString(CC, cc);
    Preference.pref.setString(CD, response['data']['current date']['date'].toString());
    name = response['data']['client']['name'].toString();
   return response;
  }
}
