import 'dart:async';
import 'dart:convert';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/api/preference.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/custom_app_button.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:back_row/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'bottom_nav_control_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


int selectedIndex = 0;

class MyHomePage extends StatefulWidget {
  static int getCardIndex() => selectedIndex;

  static void setCardIndex(int index) {
    selectedIndex = index;
  }
    final StreamController loadStream;

  MyHomePage({this.loadStream});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  String ac, cc;
  String name;

  @override
  void dispose() {
    super.dispose();
  }
  Future<Null> _refreshLocalGallery() async{

    Future.delayed(Duration(seconds: 2), () async {
      await getData();
      setState(() {

      });
      print('refreshing stocks...');
    });


  }
  @override
  Widget build(BuildContext context) {
    if (name == null)
      return FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return loadView(context);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    else { //getData();
      return loadView(context);
    }
  }

  Widget loadView(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFromHex("F8F7FB"),
      body: RefreshIndicator(
        onRefresh: _refreshLocalGallery,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringConstant.hello,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      name ?? "",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 20, top: 20),
                            alignment: Alignment.topLeft,
                            child: Text(
                              StringConstant.overview,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 18),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.all(13),
                              height: 100,
                              width: 175,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "GHC "+ cc??"",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstant
                                            .white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      StringConstant.conCost,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstant.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(13),
                              height: 100,
                              width: 175,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "GHC "+ ac??"",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstant
                                            .black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      StringConstant.actCost,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ColorConstant.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20, top: 20),
                            alignment: Alignment.topLeft,
                            child: Text(
                              StringConstant.operations,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 15),
                            )),
                        Container(
                          height: 400,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                child: new Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        name=null;
                                        selectedIndex = index;
                                        PersistentTabController pc = MyNavigationHomePage
                                            .getPageController();
                                        //  pc.jumpToTab(1);
                                        pc.index=1;
                                        widget.loadStream.add("");
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            color: (index == selectedIndex)
                                                ? Colors.black
                                                : null,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              getAssetIcon(index),
                                              Text(
                                                getAssetItemName(index),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: (index == selectedIndex)?Colors.yellow:Colors.black),
                                              )
                                            ],
                                          )),
                                    )),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getAssetIcon(int index) {
    Color colorsToSet = (selectedIndex == index)?Colors.yellow:Colors.black;

    if (index == 0) {
      return SvgPicture.asset(
        ImageConstant.siteOverviewItemIcon,
        color: colorsToSet,
        height: 32,
        width: 32,
      );
    } else if (index == 1) {
      return SvgPicture.asset(
        ImageConstant.progresItemIcon,
        color: colorsToSet,
        height: 32,
        width: 32,
      );
    } else if (index == 2) {
      return SvgPicture.asset(
        ImageConstant.materialItemIcon,
        color: colorsToSet,
        height: 32,
        width: 32,
      );
    } else if (index == 3) {
      return SvgPicture.asset(
        ImageConstant.budgetItemIcon,
        color: colorsToSet,
        height: 32,
        width: 32,
      );
    } else if (index == 4) {
      return SvgPicture.asset(
        ImageConstant.milestoneItemIcon,
        color: colorsToSet,
        height: 32,
        width: 32,
      );
    } else if (index == 5) {
      return SvgPicture.asset(
        ImageConstant.reportItemIcon,
        color: colorsToSet,
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
    setState(() {});
  }
}
