import 'dart:convert';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/api/preference.dart';
import 'package:back_row/utils/adaptive_route.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:back_row/utils/view_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class MilestoneDetailsPage extends StatefulWidget {
  @override
  _MilestoneDetailsPageState createState() => _MilestoneDetailsPageState();
}

class _MilestoneDetailsPageState extends State<MilestoneDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<SizePlot> sizePlotList = [];
  int subTotal;
  String sq;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data is String)
                ? Expanded(
                    child: Center(
                        child: Text(
                    snapshot.data,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )))
                : loadBuildView(context, snapshot.data);
          } else {
            return Expanded(child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget loadBuildView(BuildContext context, data) {
    int ghsValue = 0;
    try {
      ghsValue = (int.tryParse(
              Preference.pref.getString(CC).toString().replaceAll(",", "")) -
          int.tryParse(Preference.pref.getString(AC).toString()));
    } catch (e) {
      print(e.toString());
    }

    return Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                height: 100,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "GHC " +
                                              Preference.pref
                                                  .getString(CC)
                                                  .toString() ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ColorConstant.white,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
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
                                padding: EdgeInsets.all(15),
                                height: 100,
                                width: 175,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "GHC " +
                                              Preference.pref
                                                  .getString(AC)
                                                  .toString() ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ColorConstant.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
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
                          SizedBox(height: 10,),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                      text: "GHC " +
                                          Preference.pref
                                              .getString(CC)
                                              .toString() +
                                          " - " +
                                          "GHS " +
                                          Preference.pref
                                              .getString(AC)
                                              .toString() +
                                          " = " +
                                          "GHS ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ghsValue.toString(),
                                          style: TextStyle(
                                              color:(ghsValue<0)?Colors.red:Colors.black, fontSize: 16),
                                        )
                                      ]),
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                    height: 40,
                                    width: 100,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      StringConstant.sizePlot,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 16),
                                    )),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 40),
                                  height: 40,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text("${sq} SQ. FT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,),),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                            left: 10, right: 10, bottom: 10, top: 20),
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            height: 100 + ((data.length + 1) * 50.0),
                            child: Stack(
                              children: [
                                backgroundEffect(),
                                backgroundEffectWithColor(),
                                loadView(data),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  margin:
                                      EdgeInsets.only(bottom: 30, right: 30),
                                  child: Text(
                                    "Subtotal    -      GHC ${subTotal ?? 0}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: ColorConstant.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  loadView(data) {
    return Container(
        height: 65 + (data.length * 50.0),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          elevation: 10,
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.grey.shade300,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: Text(StringConstant.material,
                            style: TextStyle(
                              color: ColorConstant.black,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      SizedBox(
                          child: Text(StringConstant.rate,
                              style: TextStyle(
                                color: ColorConstant.black,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ))),
                      SizedBox(
                          child: Text(StringConstant.qty,
                              style: TextStyle(
                                color: ColorConstant.black,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ))),
                      SizedBox(
                          child: Text(StringConstant.percentage,
                              style: TextStyle(
                                color: ColorConstant.black,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ))),
                      SizedBox(
                          child: Text(StringConstant.amount,
                              style: TextStyle(
                                color: ColorConstant.black,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ))),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            final destination = (context) => ViewImagePage(
                                  url: data[index].fileLink,
                                );
                            final adaptiveRoute = AdaptiveRoute(
                                context: context, destination: destination);
                            Navigator.push(context, adaptiveRoute.getRoute());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(data[index].name,
                                            style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            )),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Text(data[index].rate,
                                            style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ))),
                                    Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(data[index].qty,
                                            style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ))),
                                    Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(data[index].percent,
                                            style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ))),
                                    Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(data[index].amount,
                                            style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal,
                                            ))),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                if (index != data.length-1) Divider(thickness: 1,),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  backgroundEffect() {
    return Row(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width / 3.5 +
              MediaQuery.of(context).size.width / 40),
          decoration: BoxDecoration(
            color: ColorConstant.milestonePageLineColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        ),
        Container(
          width: (MediaQuery.of(context).size.width / 3.5 +
              MediaQuery.of(context).size.width / 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ColorConstant.yellowGradient1,
              ColorConstant.yellowGradient2
            ]),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(10),
            ),
          ),
        )
      ],
    );
  }

  Container customSpace(
      double width, List<Color> gradient, List<double> topLeftRadius) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: gradient,
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius[0]),
          topRight: Radius.circular(topLeftRadius[1]),
          bottomLeft: Radius.circular(topLeftRadius[2]),
          bottomRight: Radius.circular(topLeftRadius[3]),
        ),
      ),
    );
  }

  backgroundEffectWithColor() {
    return Row(
      children: [
        customSpace(MediaQuery.of(context).size.width / 3.5, [
          ColorConstant.black,
          ColorConstant.black
        ], [
          10,
          10,
          10,
          10
        ]),
        Expanded(
          child: customSpace(
              MediaQuery.of(context).size.width / 1.5,
              [Colors.grey.shade100, Colors.grey.shade100],
              [0, 10, 0, 10]),
        )
      ],
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

  Future<dynamic> getData(BuildContext context) async {
    http.Response res = await ApiRoute.callRouteAPI(
        url: SIZE_PLOT_URL,
        body: "",
        callMethod: GET,
        isWithToken: false,
        context: context);
    print(res.body);
    final resBody = json.decode(res.body);
    if (resBody['success'] == false) {
      return resBody['data']['error'];
    } else {
      final response = json.decode(res.body)['data'];
      sizePlotList.clear();
      for (var data in response['plots']) {
        sizePlotList.add(SizePlot(
            name: data["name"],
            rate: data['rate'],
            amount: data['amount'].toString(),
            percent: data['percentage'].toString(),
            qty: data['qty'].toString()));
      }
      await getCostData(context);
      subTotal = response['sub_total'];
      sq = response['sq_ft'].toString();
      return sizePlotList;
      // name = response['data']['client']['name'].toString();
    }
  }
}

Future<dynamic> getCostData(BuildContext context) async {
  http.Response res = await ApiRoute.callRouteAPI(
      url: DASHBOARD_URL,
      body: "",
      callMethod: GET,
      isWithToken: false,
      context: context);
  print(res.body);
  final response = json.decode(res.body);
  var ac = response['data']['actual_cost']['cost'].toString();
  var cc = response['data']['construction']['cost'].toString();
  Preference.pref.setString(AC, ac);
  Preference.pref.setString(CC, cc);
  var name = response['data']['client']['name'].toString();
}

class SizePlot {
  String name, rate, percent, amount, qty, sqFt;

  SizePlot(
      {this.name, this.amount, this.percent, this.rate, this.qty, this.sqFt});
}
