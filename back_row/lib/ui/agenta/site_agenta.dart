import 'dart:convert';
import 'dart:ffi';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/api/preference.dart';
import 'package:back_row/ui/home/scope_model.dart';
import 'package:back_row/ui/home/site_overview.dart';
import 'package:back_row/ui/milestones/milestone_detail_page.dart';
import 'package:back_row/ui/site_overview_details/details_page.dart';
import 'package:back_row/utils/adaptive_route.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:back_row/utils/view_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:http/http.dart' as http;

class SiteAgentaDataPage extends StatefulWidget {
  final int selectedIndex;

  SiteAgentaDataPage({this.selectedIndex});

  @override
  _SiteAgentaDataPageState createState() => _SiteAgentaDataPageState();
}

class _SiteAgentaDataPageState extends State<SiteAgentaDataPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double length = (widget.selectedIndex == 1) ? 100.0 : 120.0;
    String url = StaticMethods.getIndexBasedURL(widget.selectedIndex);
    return FutureBuilder(
        future: getApiResponseData(url),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data is List<ScopeModel>) {
            return Expanded(
              child: Container(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    (snapshot.data[0].itemsList.length == 0)
                        ? Container()
                        : Container(
                        margin: EdgeInsets.only(left: 5, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20, top: 0),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  (widget.selectedIndex == 1)
                                      ? "Today"
                                      : snapshot
                                      .data[0].scopeOverollTitle ??
                                      "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 20),
                                )),
                            GestureDetector(
                              onTap: () {
                                print("so");
                                final destination =
                                    (context) => DetailsPage(
                                  url: (widget.selectedIndex == 0)
                                      ? SO_DETAILS_URL
                                      : AGRNDA_DETAILS_URL,
                                  flag: (widget.selectedIndex == 0)
                                      ? 0
                                      : 3,
                                );
                                final adaptiveRoute = AdaptiveRoute(
                                    context: context,
                                    destination: destination);
                                Navigator.push(
                                    context, adaptiveRoute.getRoute());
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 20, top: 0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    StringConstant.viewMore,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 15),
                                  )),
                            ),
                          ],
                        )),
                    if (snapshot.data[0].itemsList.length == 0)
                      Container()
                    else
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 20),
                        child: Card(
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Container(
                            height: ((widget.selectedIndex == 1) ? 40.0 : 0.0) +
                                100.0 +
                                (snapshot.data[0].itemsList.length * length),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        right: 20, top: 10, bottom: 20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      /* snapshot.data[0].itemsList[0]
                                        .scopeTitleOrDateString*/
                                     Preference.pref.getString(CD),
                                      style: TextStyle(
                                          color: ColorConstant.soDateColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    )),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      child: Text(
                                        "Most Recent",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: ColorConstant.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "",
                                              style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              child: Text(
                                                "",
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.9),
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                Expanded(
                                  child: Container(
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.all(0),
                                        scrollDirection: Axis.vertical,
                                        itemCount:
                                        snapshot.data[0].itemsList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              final destination =
                                                  (context) => ViewImagePage(
                                                url: snapshot
                                                    .data[0]
                                                    .itemsList[index]
                                                    .fileLink,
                                              );
                                              final adaptiveRoute =
                                              AdaptiveRoute(
                                                  context: context,
                                                  destination: destination);
                                              Navigator.push(context,
                                                  adaptiveRoute.getRoute());
                                            },
                                            child: (widget.selectedIndex == 1)
                                                ? Column(
                                              children: [
                                                Card(
                                                  shape:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .all(
                                                        Radius.circular(18),
                                                      )),
                                                  //  shadowColor:Colors.yellow,
                                                  elevation: 5,
                                                  child: Container(
                                                    height:100+setHeightYellowCard( snapshot
                                                        .data[0]
                                                        .itemsList[index]
                                                        .description),
                                                    decoration:
                                                    BoxDecoration(
                                                        color: Colors
                                                            .white,
                                                        borderRadius:
                                                        BorderRadius
                                                            .only(
                                                          topLeft: Radius
                                                              .circular(
                                                              18),
                                                          topRight: Radius
                                                              .circular(
                                                              18),
                                                          bottomLeft:
                                                          Radius.circular(
                                                              18),
                                                          bottomRight:
                                                          Radius.circular(
                                                              18),
                                                        ),
                                                        border: Border.all(
                                                            color: Colors
                                                                .yellow,
                                                            width:
                                                            1.2)),
                                                    padding:
                                                    EdgeInsets.only(
                                                        top: 20,
                                                        left: 20,
                                                        right: 20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                    top: 10),
                                                                child:
                                                                Text(
                                                                  snapshot
                                                                      .data[0]
                                                                      .itemsList[index]
                                                                      .itemTitle,
                                                                  style: TextStyle(
                                                                      color: ColorConstant
                                                                          .black,
                                                                      fontSize:
                                                                      15,
                                                                      fontWeight:
                                                                      FontWeight.normal),
                                                                ),
                                                              ),
                                                              Visibility(
                                                                child:
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top:
                                                                      10,
                                                                      bottom:
                                                                      20),
                                                                  child:
                                                                  Text(
                                                                    snapshot
                                                                        .data[0]
                                                                        .itemsList[index]
                                                                        .description,
                                                                    maxLines:
                                                                    5,
                                                                    style: TextStyle(
                                                                        color: Colors.grey.withOpacity(0.9),
                                                                        fontSize: 13,
                                                                        fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: false,
                                                          child:
                                                          Container(
                                                            child: Card(
                                                              child:
                                                              Container(
                                                                padding: EdgeInsets.only(
                                                                    top:
                                                                    4,
                                                                    bottom:
                                                                    4,
                                                                    left:
                                                                    7,
                                                                    right:
                                                                    7),
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.all(
                                                                      Radius.circular(4),
                                                                    ),
                                                                    gradient: LinearGradient(colors: [
                                                                      ColorConstant.customBtnGradient1,
                                                                      ColorConstant.customBtnGradient2,
                                                                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                                                                child: Center(
                                                                    child: Text(
                                                                      "View",
                                                                      style: TextStyle(
                                                                          color: ColorConstant
                                                                              .yellowGradient2,
                                                                          fontSize:
                                                                          11.0,
                                                                          fontWeight:
                                                                          FontWeight.w500),
                                                                    )),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: false,
                                                          child: Expanded(
                                                            child:
                                                            Container(
                                                              height: 30,
                                                              alignment:
                                                              Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                snapshot
                                                                    .data[
                                                                0]
                                                                    .itemsList[
                                                                index]
                                                                    .date,
                                                                style: TextStyle(
                                                                    color: Colors.grey.withOpacity(
                                                                        0.6),
                                                                    fontSize:
                                                                    10.0,
                                                                    fontWeight:
                                                                    FontWeight.w500),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                                : Column(
                                              children: [
                                                (index != 0)
                                                    ? Container(
                                                  margin: EdgeInsets
                                                      .only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 20),
                                                  child: DottedLine(
                                                    lineThickness:
                                                    0.5,
                                                    dashColor:
                                                    Colors.grey,
                                                  ),
                                                )
                                                    : Container(),
                                                Container(
                                                  height: setHeight(
                                                      snapshot
                                                          .data[0]
                                                          .itemsList[
                                                      index]
                                                          .description),
                                                  margin: EdgeInsets.only(
                                                      top: 10,
                                                      left: 20,
                                                      right: 20),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  top:
                                                                  10),
                                                              child: Text(
                                                                snapshot
                                                                    .data[
                                                                0]
                                                                    .itemsList[
                                                                index]
                                                                    .itemTitle,
                                                                style: TextStyle(
                                                                    color: ColorConstant
                                                                        .black,
                                                                    fontSize:
                                                                    15,
                                                                    fontWeight:
                                                                    FontWeight.normal),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible:
                                                              false,
                                                              child:
                                                              Container(
                                                                width:
                                                                160,
                                                                child:
                                                                Text(
                                                                  "",
                                                                  maxLines:
                                                                  5,
                                                                  style: TextStyle(
                                                                      color: Colors.grey.withOpacity(
                                                                          0.9),
                                                                      fontSize:
                                                                      13,
                                                                      fontWeight:
                                                                      FontWeight.normal),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: 30,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            snapshot
                                                                .data[0]
                                                                .itemsList[
                                                            index]
                                                                .description,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    0.7),
                                                                fontSize:
                                                                12.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                (index ==
                                                    snapshot
                                                        .data[0]
                                                        .itemsList
                                                        .length -
                                                        1)
                                                    ? Container(
                                                    margin: EdgeInsets
                                                        .only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 20),
                                                    child: DottedLine(
                                                      lineThickness:
                                                      0.5,
                                                      dashColor:
                                                      Colors.grey,
                                                    ))
                                                    : Container()
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    (snapshot.data[1].itemsList.length == 0)
                        ? Container()
                        : Container(
                        margin: EdgeInsets.only(left: 5, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20, top: 0),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  snapshot.data[1].scopeOverollTitle ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 20),
                                )),
                            (widget.selectedIndex == 0)
                                ? Visibility(
                              visible: true,
                              child: GestureDetector(
                                onTap: () {
                                  print("EA");
                                  if (widget.selectedIndex == 0) {
                                    final destination =
                                        (context) => DetailsPage(
                                      url: EA_DETAILS_URL,
                                      flag:
                                      (widget.selectedIndex ==
                                          0)
                                          ? 1
                                          : 4,
                                    );
                                    final adaptiveRoute =
                                    AdaptiveRoute(
                                        context: context,
                                        destination: destination);
                                    Navigator.push(context,
                                        adaptiveRoute.getRoute());
                                  }
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20, top: 0),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      StringConstant.viewMore,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 15),
                                    )),
                              ),
                            )
                                : Container(),
                          ],
                        )),
                    (snapshot.data[1].itemsList.length == 0)
                        ? Container()
                        : Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Container(
                          height: (snapshot.data[1].itemsList.length *90.0),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Visibility(
                                visible: false,
                                child: Container(
                                    margin: EdgeInsets.all(20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      (snapshot.data[1].itemsList
                                          .length ==
                                          0)
                                          ? ""
                                          : snapshot.data[1].itemsList[0]
                                          .scopeTitleOrDateString,
                                      style: TextStyle(
                                          color:
                                          ColorConstant.soDateColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ),
                              Visibility(
                                visible: false,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: DottedLine(
                                    lineThickness: 0.5,
                                    dashColor: Colors.grey,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: false,
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    child: Text(
                                      "Most Recent",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                              Visibility(
                                visible: false,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 0, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "",
                                            style: TextStyle(
                                                color:
                                                ColorConstant.black,
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                2,
                                            child: Text(
                                              "",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.9),
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Expanded(
                                child: Container(
                                  child: ListView.builder(
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(0),
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot
                                          .data[1].itemsList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            final destination =
                                                (context) =>
                                                ViewImagePage(
                                                  url: snapshot
                                                      .data[1]
                                                      .itemsList[
                                                  index]
                                                      .fileLink,
                                                );
                                            final adaptiveRoute =
                                            AdaptiveRoute(
                                                context: context,
                                                destination:
                                                destination);
                                            Navigator.push(context,
                                                adaptiveRoute.getRoute());
                                          },
                                          child: Container(
                                            height: setHeight(snapshot
                                                .data[1]
                                                .itemsList[index]
                                                .description),
                                            margin: EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .only(top: 0),
                                                        child: Text(
                                                          snapshot
                                                              .data[1]
                                                              .itemsList[
                                                          index]
                                                              .itemTitle,
                                                          style: TextStyle(
                                                              color: ColorConstant
                                                                  .black,
                                                              fontSize:
                                                              15,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: true,
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              top:
                                                              10),
                                                          child: Text(
                                                            snapshot
                                                                .data[1]
                                                                .itemsList[
                                                            index]
                                                                .description,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    0.7),
                                                                fontSize:
                                                                13,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: (widget
                                                            .selectedIndex ==
                                                            1),
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              top:
                                                              10),
                                                          child:
                                                          DottedLine(
                                                            lineThickness:
                                                            0.5,
                                                            dashColor:
                                                            Colors
                                                                .grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: false,
                                                  child: Container(
                                                    child: Card(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                            top: 4,
                                                            bottom: 4,
                                                            left: 7,
                                                            right: 7),
                                                        decoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(
                                                              Radius.circular(
                                                                  4),
                                                            ),
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  ColorConstant.customBtnGradient1,
                                                                  ColorConstant.customBtnGradient2,
                                                                ],
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter)),
                                                        child: Center(
                                                            child: Text(
                                                              "View",
                                                              style: TextStyle(
                                                                  color: ColorConstant
                                                                      .yellowGradient2,
                                                                  fontSize:
                                                                  11.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: false,
                                                  child: Expanded(
                                                    child: Container(
                                                      height: 30,
                                                      alignment: Alignment
                                                          .centerRight,
                                                      child: Text(
                                                        snapshot
                                                            .data[1]
                                                            .itemsList[
                                                        index]
                                                            .date,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey
                                                                .withOpacity(
                                                                0.6),
                                                            fontSize:
                                                            10.0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    (widget.selectedIndex == 1 &&
                        snapshot.data[2].itemsList.length != 0)
                        ? Container()
                        : (widget.selectedIndex == 0 &&
                        snapshot.data[2].itemsList.length != 0)
                        ? Container(
                        margin: EdgeInsets.only(left: 5, right: 25),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin:
                                EdgeInsets.only(left: 20, top: 0),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  snapshot.data[2].scopeOverollTitle ??
                                      "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 20),
                                )),
                            Visibility(
                              visible: true,
                              child: GestureDetector(
                                onTap: () {
                                  print("PC");
                                  final destination = (context) =>
                                      DetailsPage(
                                        url: (widget.selectedIndex == 0)
                                            ? PC_DETAILS_URL
                                            : MILESTONE_URL,
                                        flag:
                                        (widget.selectedIndex == 0)
                                            ? 2
                                            : 5,
                                      );
                                  final adaptiveRoute = AdaptiveRoute(
                                      context: context,
                                      destination: destination);
                                  Navigator.push(context,
                                      adaptiveRoute.getRoute());
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: 20, top: 0),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      StringConstant.viewMore,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: 15),
                                    )),
                              ),
                            ),
                          ],
                        ))
                        : Container(),
                    (widget.selectedIndex == 1 &&
                        snapshot.data[2].itemsList.length != 0)
                        ? Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 5, right: 25),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin:
                                    EdgeInsets.only(left: 20, top: 0),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      snapshot.data[2]
                                          .scopeOverollTitle ??
                                          "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 20),
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    final destination =
                                        (context) => MilestoneDataPage();
                                    final adaptiveRoute = AdaptiveRoute(
                                        context: context,
                                        destination: destination);
                                    Navigator.push(context,
                                        adaptiveRoute.getRoute());
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          left: 20, top: 0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        StringConstant.viewMore,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 15),
                                      )),
                                ),
                              ],
                            )),
                        Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(
                              left: 10, right: 10, bottom: 10, top: 10),
                          child: Card(
                            elevation: 20,
                            color: Colors.white.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Container(
                              height: 20 +
                                  (snapshot.data[2].itemsList.length *
                                      130.0),
                              child: Stack(
                                children: [
                                  backgroundEffect(),
                                  backgroundEffectWithColor(),
                                  titleView(),
                                  loadList(snapshot.data[2].itemsList)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Container(),
                    (widget.selectedIndex == 0 &&
                        snapshot.data[2].itemsList.length != 0)
                        ? Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Container(
                          height: (snapshot.data[2].itemsList.length *
                              MediaQuery.of(context).size.height *
                              0.17),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Visibility(
                                visible: false,
                                child: Container(
                                    margin: EdgeInsets.all(20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data[2].itemsList[0]
                                          .scopeTitleOrDateString ??
                                          "",
                                      style: TextStyle(
                                          color:
                                          ColorConstant.soDateColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ),
                              Visibility(
                                visible: false,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: DottedLine(
                                    lineThickness: 0.5,
                                    dashColor: Colors.grey,
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: false,
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      child: Text(
                                        "Most Recent",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: ColorConstant.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ))),
                              Visibility(
                                visible: false,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "",
                                            style: TextStyle(
                                                color:
                                                ColorConstant.black,
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                2,
                                            child: Text(
                                              "",
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.9),
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0,
                              ),
                              Expanded(
                                child: Container(
                                  child: ListView.builder(
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(0),
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot
                                          .data[2].itemsList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            final destination =
                                                (context) =>
                                                ViewImagePage(
                                                  url: snapshot
                                                      .data[2]
                                                      .itemsList[
                                                  index]
                                                      .fileLink,
                                                );
                                            final adaptiveRoute =
                                            AdaptiveRoute(
                                                context: context,
                                                destination:
                                                destination);
                                            Navigator.push(context,
                                                adaptiveRoute.getRoute());
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .only(
                                                            top: 10),
                                                        child: Text(
                                                          snapshot
                                                              .data[2]
                                                              .itemsList[
                                                          index]
                                                              .itemTitle,
                                                          style: TextStyle(
                                                              color: ColorConstant
                                                                  .black,
                                                              fontSize:
                                                              15,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal),
                                                        ),
                                                      ),
                                                      Visibility(
                                                        child: Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                              top:
                                                              10),
                                                          child: Text(
                                                            snapshot
                                                                .data[2]
                                                                .itemsList[
                                                            index]
                                                                .description,
                                                            maxLines: 5,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    0.7),
                                                                fontSize:
                                                                13,
                                                                fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: false,
                                                  child: Container(
                                                    child: Card(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                            top: 4,
                                                            bottom: 4,
                                                            left: 7,
                                                            right: 7),
                                                        decoration:
                                                        BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .all(
                                                              Radius.circular(
                                                                  4),
                                                            ),
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  ColorConstant.customBtnGradient1,
                                                                  ColorConstant.customBtnGradient2,
                                                                ],
                                                                begin: Alignment
                                                                    .topCenter,
                                                                end: Alignment
                                                                    .bottomCenter)),
                                                        child: Center(
                                                            child: Text(
                                                              "View",
                                                              style: TextStyle(
                                                                  color: ColorConstant
                                                                      .yellowGradient2,
                                                                  fontSize:
                                                                  11.0,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: false,
                                                  child: Expanded(
                                                    child: Container(
                                                      height: 30,
                                                      alignment: Alignment
                                                          .centerRight,
                                                      child: Text(
                                                        snapshot
                                                            .data[0]
                                                            .itemsList[
                                                        index]
                                                            .date,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey
                                                                .withOpacity(
                                                                0.6),
                                                            fontSize:
                                                            10.0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasData && snapshot.data is String) {
            return Expanded(
                child: Center(
                    child: Text(
                      snapshot.data,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )));
          } else
            return Expanded(child: Center(child: CircularProgressIndicator()));
        });
  }

  Container customSpace(
      double width, List<Color> gradient, List<double> topLeftRadius) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        /* gradient: LinearGradient(
            colors: gradient,
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter),*/
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeftRadius[0]),
          topRight: Radius.circular(topLeftRadius[1]),
          bottomLeft: Radius.circular(topLeftRadius[2]),
          bottomRight: Radius.circular(topLeftRadius[3]),
        ),
      ),
    );
  }

  backgroundEffect() {
    return Row(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width / 3.5 +
              MediaQuery.of(context).size.width / 40),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
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
            /*gradient: LinearGradient(colors: [
              ColorConstant.yellowGradient1,
              ColorConstant.yellowGradient2
            ]),*/
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

  backgroundEffectWithColor() {
    return Row(
      children: [
        customSpace(MediaQuery.of(context).size.width / 3.5, [
          ColorConstant.customBtnGradient1,
          ColorConstant.customBtnGradient2
        ], [
          50,
          10,
          10,
          10
        ]),
        customSpace(MediaQuery.of(context).size.width / 30, [
          ColorConstant.milestonePageLineColor,
          ColorConstant.milestonePageLineColor
        ], [
          0,
          10,
          0,
          10
        ]),
        Expanded(
          child: customSpace(
              MediaQuery.of(context).size.width / 1.5,
              [ColorConstant.yellowGradient1, ColorConstant.yellowGradient2],
              [0, 10, 0, 10]),
        )
      ],
    );
  }

  loadList(data) {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: Stack(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
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
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 40, bottom: 40),
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  topRight: Radius.circular(7),
                                  bottomLeft: Radius.circular(7),
                                  bottomRight: Radius.circular(7),
                                ),
                                border: Border.all(
                                    color: data[index]
                                        .status
                                        .toString()
                                        .toLowerCase()
                                        .contains("com")
                                        ? ColorConstant.green
                                        : data[index]
                                        .status
                                        .toString()
                                        .toLowerCase()
                                        .contains("in")
                                        ? Colors.yellow
                                        : ColorConstant.red,
                                    width: 1.2)),
                            child: Text(
                              data[index].status ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: data[index]
                                      .status
                                      .toString()
                                      .toLowerCase()
                                      .contains("com")
                                      ? ColorConstant.black
                                      : data[index]
                                      .status
                                      .toString()
                                      .toLowerCase()
                                      .contains("in")
                                      ? Colors.black
                                      : ColorConstant.black,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 30,
                            child: SvgPicture.asset(
                              ImageConstant.dot,
                              color: Colors.yellow,
                            )),
                        Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                color: Colors.transparent,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 30 + getHeight(data[index].itemTitle),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index].scopeTitleOrDateString,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.black
                                                  .withOpacity(0.8),
                                              fontSize: 10),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(bottom: 6),
                                              child: Text(
                                                data[index].itemTitle,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: ColorConstant.black,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              }),
          Container(
            width: 6,
            margin: EdgeInsets.only(top: 53,left: MediaQuery.of(context).size.width/3.37),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return(index==data.length-1)?Container(): Container(
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(1))),
                  );
                }),
          ),
        ],
      ),
    );
  }

  titleView() {
    return Row(
      children: [
        Container(
            width: (MediaQuery.of(context).size.width / 3.5 +
                MediaQuery.of(context).size.width / 40),
            margin: EdgeInsets.only(top: 30, left: 30),
            child: Text(
              StringConstant.status,
              style: TextStyle(
                  fontSize: 15,
                  color: ColorConstant.white.withOpacity(0.7),
                  fontWeight: FontWeight.normal),
            )),
        Container(
            margin: EdgeInsets.only(top: 30, left: 0),
            width: (MediaQuery.of(context).size.width / 3.5 +
                MediaQuery.of(context).size.width / 40),
            child: Text(StringConstant.task,
                style: TextStyle(
                    fontSize: 15,
                    color: ColorConstant.blueGrey.withOpacity(0.5),
                    fontWeight: FontWeight.normal))),
      ],
    );
  }

  getAssetItemName(int index) {
    if (index == 0) {
      return StringConstant.siteOverview;
    } else if (index == 1) {
      return StringConstant.material;
    } else if (index == 2) {
      return StringConstant.siteAgenda;
    } else if (index == 3) {
      return StringConstant.budget;
    } else if (index == 4) {
      return StringConstant.reportMenu;
    } else if (index == 5) {
      return StringConstant.booking;
    }
  }

  getApiResponseData(String url) async {
    return (widget.selectedIndex == 0)
        ? siteOverViewData(url)
        : siteAgenda(url);
  }

  siteOverViewData(url) async {
    http.Response res = await ApiRoute.callRouteAPI(
        url: url,
        body: "",
        callMethod: GET,
        isWithToken: false,
        context: context);
    print(res.body);
    final resBody = json.decode(res.body);
    if (resBody['success'] == false) {
      return resBody['data']['error'];
    } else {
      final response = json.decode(res.body);
      List<ScopeModel> scopeModelData = [];
      final overViewList = response['data']['overview'];
      final progressCheckList = response['data']['progress'];
      final arriveList = response['data']['arrive'];
      List<ItemsViewList> itemList = [];
      for (var data in overViewList) {
        itemList.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['text'],
          date: data['date'],
          description: data['description'],
          fileLink: data['file'],
        ));
      }
      scopeModelData.add(
          ScopeModel(scopeOverollTitle: "Site Overview", itemsList: itemList));

      List<ItemsViewList> itemList1 = [];
      for (var data in arriveList) {
        itemList1.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['text'],
          date: data['date'],
          description: data['description'],
          fileLink: data['file'],
        ));
      }
      scopeModelData.add(ScopeModel(
          scopeOverollTitle: "Expected to Arrive", itemsList: itemList1));

      List<ItemsViewList> itemList2 = [];
      for (var data in progressCheckList) {
        itemList2.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['text'],
          date: data['date'],
          description: data['description'],
          fileLink: data['file'],
        ));
      }
      scopeModelData.add(ScopeModel(
          scopeOverollTitle: "Progress/Checks", itemsList: itemList2));
      return scopeModelData;
    }
  }

  siteAgenda(String url) async {
    http.Response res = await ApiRoute.callRouteAPI(
        url: url,
        body: "",
        callMethod: GET,
        isWithToken: false,
        context: context);
    print(res.body);
    final resBody = json.decode(res.body);
    if (resBody['success'] == false) {
      return resBody['data']['error'];
    } else {
      final response = json.decode(res.body);
      List<ScopeModel> scopeModelData = [];
      final overViewList = response['data']['agenda'];
      final progressCheckList = response['data']['end_day'];
      final arriveList = response['data']['milestone'];
      List<ItemsViewList> itemList = [];
      for (var data in overViewList) {
        itemList.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['text'],
          date: data['date'],
          description: data['description'],
          fileLink: data['file'],
        ));
      }
      scopeModelData.add(
          ScopeModel(scopeOverollTitle: "Site Agenda", itemsList: itemList));

      List<ItemsViewList> itemList1 = [];
      for (var data in progressCheckList) {
        itemList1.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['text'],
          date: data['date'],
          description: data['description'],
          fileLink: data['file'],
        ));
      }
      scopeModelData.add(
          ScopeModel(scopeOverollTitle: "End of Day", itemsList: itemList1));

      List<ItemsViewList> itemList2 = [];
      for (var data in arriveList) {
        itemList2.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['text'],
          date: data['date'],
          status: data['status'],
          fileLink: data['file'],
        ));
      }
      scopeModelData.add(
          ScopeModel(scopeOverollTitle: "Milestones", itemsList: itemList2));
      return scopeModelData;
    }
  }

  getStringSize(itemsList) {
    double returnSize = 0;
    for (var listdata in itemsList) {
      int len = listdata.itemTitle.length;
      if (len < 30) {
        returnSize = 90.0;
      } else if (len < 60) {
        returnSize = 120.0;
      } else if (len < 90) {
        returnSize = 150.0;
      } else if (len < 120) {
        returnSize = 180.0;
      } else if (len < 150) {
        returnSize = 180.0;
      } else if (len < 180) {
        returnSize = 210.0;
      } else if (len < 210) {
        returnSize = 240.0;
      } else {
        returnSize = 160.0;
      }
    }

    return returnSize;
  }

  setHeight(description) {
    if (description.length < 100) {
      return 60.0;
    } else if (description.length < 200) {
      return 100.0;
    } else if (description.length < 300) {
      return 120.0;
    } else if (description.length < 400) {
      return 140.0;
    }
    return 160.0;
  }

  setHeightYellowCard(description) {
    if (description.length < 100) {
      return 0.0;
    } else if (description.length < 200) {
      return 60.0;
    } else if (description.length < 300) {
      return 60.0;
    } else if (description.length < 400) {
      return 80.0;
    }
    return 100.0;
  }

  num getHeight(itemTitle) {
    if (itemTitle.length < 70) {
      return 60.0;
    } else if (itemTitle.length < 140) {
      return 85.0;
    }
    return 60.0;
  }
}
