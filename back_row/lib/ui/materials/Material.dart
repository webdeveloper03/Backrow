import 'dart:convert';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/api/preference.dart';
import 'package:back_row/ui/home/scope_model.dart';
import 'package:back_row/ui/materials/materials_details.dart';
import 'package:back_row/utils/adaptive_route.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:back_row/utils/view_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class MaterialDataPage extends StatefulWidget {
  final int selectedIndex;

  MaterialDataPage({this.selectedIndex});

  @override
  _MaterialDataPageState createState() => _MaterialDataPageState();
}

class _MaterialDataPageState extends State<MaterialDataPage> {
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
    String url = StaticMethods.getIndexBasedURL(widget.selectedIndex);
    return FutureBuilder(
        future: getApiResponseData(url),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data is List<ScopeModel>) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
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
                                Visibility(
                                  visible: true,
                                  child: Container(
                                      margin: EdgeInsets.only(left: 20, top: 0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data[0].scopeOverollTitle ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 20),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("so");
                                    final destination =
                                        (context) => MaterialsDetailsPage(
                                              url: MATERIAL_DETAILS_URL,
                                              flag: 0,
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
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.black,
                                            fontSize: 15),
                                      )),
                                ),
                              ],
                            )),
                    (snapshot.data[0].itemsList.length == 0)
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
                                height: 50+
                                    (snapshot.data[0].itemsList.length * MediaQuery.of(context).size.height*0.17),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                             /* snapshot.data[0].itemsList[0]
                                                  .scopeTitleOrDateString*/snapshot.data[0].scopeOverollTitle ?? "",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.soDateColor,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )),
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot.data[0].count,
                                              style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: DottedLine(
                                        lineThickness: 0.5,
                                        dashColor: Colors.grey,
                                      ),
                                    ),
                                    Visibility(
                                      visible: false,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20, top: 0),
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
                                            Container(
                                              child: SvgPicture.asset(
                                                  ImageConstant.truckIcon),
                                              height: 40,
                                              width: 40,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
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
                                                .data[0].itemsList.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  final destination =
                                                      (context) =>
                                                          ViewImagePage(
                                                            url: snapshot
                                                                .data[0]
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
                                                                    .data[0]
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
                                                                child: Text(
                                                                  snapshot
                                                                      .data[0]
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
                                                      Container(
                                                        height: 30,
                                                        width: 50,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          snapshot
                                                              .data[0]
                                                              .itemsList[
                                                                  index]
                                                              .availableCount,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                    (snapshot.data[1].itemsList.length == 0)
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(left: 5, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: false,
                                  child: Container(
                                      margin: EdgeInsets.only(left: 20, top: 0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data[1].scopeOverollTitle ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 20),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("EA");
                                    final destination =
                                        (context) => MaterialsDetailsPage(
                                              url: EQIPEMENT_DETAILS_URL,
                                              flag: 1,
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
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.black,
                                            fontSize: 15),
                                      )),
                                )
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
                                height: 40 +
                                    (snapshot.data[1].itemsList.length * MediaQuery.of(context).size.height*0.17),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                            /*  snapshot.data[1].itemsList[0]
                                                  .scopeTitleOrDateString*/snapshot.data[1].scopeOverollTitle ?? "",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.soDateColor,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )),
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot.data[1].count,
                                              style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: DottedLine(
                                        lineThickness: 0.5,
                                        dashColor: Colors.grey,
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
                                            top: 20, left: 20, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: SvgPicture.asset(
                                                  ImageConstant.truckIcon),
                                              height: 40,
                                              width: 40,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
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
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        width: 50,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          snapshot
                                                              .data[1]
                                                              .itemsList[
                                                                  index]
                                                              .availableCount,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                    (snapshot.data[2].itemsList.length == 0)
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(left: 5, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: false,
                                  child: Container(
                                      margin: EdgeInsets.only(left: 20, top: 0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data[2].scopeOverollTitle ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 20),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("PC");
                                    final destination =
                                        (context) => MaterialsDetailsPage(
                                              url: VECHICLE_DETAILS_URL,
                                              flag: 2,
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
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.black,
                                            fontSize: 15),
                                      )),
                                ),
                              ],
                            )),
                    (snapshot.data[2].itemsList.length == 0)
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
                                height: 40+
                                    (snapshot.data[2].itemsList.length *  MediaQuery.of(context).size.height*0.165),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              /*snapshot.data[2].itemsList[0]
                                                  .scopeTitleOrDateString*/snapshot.data[2].scopeOverollTitle ?? "",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.soDateColor,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )),
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot.data[2].count,
                                              style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: DottedLine(
                                        lineThickness: 0.5,
                                        dashColor: Colors.grey,
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
                                                              visible: true,
                                                              child: Container(
                                                                child: Text(
                                                                  snapshot
                                                                      .data[2]
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
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        width: 50,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          snapshot
                                                              .data[2]
                                                              .itemsList[
                                                                  index]
                                                              .availableCount,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                    (snapshot.data[3].itemsList.length == 0)
                        ? Container()
                        : Container(
                            margin: EdgeInsets.only(left: 5, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: false,
                                  child: Container(
                                      margin: EdgeInsets.only(left: 20, top: 0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data[3].scopeOverollTitle ?? "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            fontSize: 20),
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("PC");
                                    final destination =
                                        (context) => MaterialsDetailsPage(
                                              url: CONTRACTOR_DETAILS_URL,
                                              flag: 3,
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
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.black,
                                            fontSize: 15),
                                      )),
                                ),
                              ],
                            )),
                    (snapshot.data[3].itemsList.length == 0)
                        ? Container()
                        : Container(
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 30, top: 20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Container(
                                height:
                                    (snapshot.data[3].itemsList.length * MediaQuery.of(context).size.height*0.2),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                             /* snapshot.data[3].itemsList[0]
                                                  .scopeTitleOrDateString*/  snapshot.data[3].scopeOverollTitle ?? "",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.soDateColor,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )),
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot.data[3].count,
                                              style: TextStyle(
                                                  color: ColorConstant.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ],
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: DottedLine(
                                        lineThickness: 0.5,
                                        dashColor: Colors.grey,
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
                                                .data[3].itemsList.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  /* final destination = (context) => ViewImagePage(
                                              url:  snapshot.data[3].itemsList[index].fileLink,
                                            );
                                            final adaptiveRoute = AdaptiveRoute(
                                                context: context, destination: destination);
                                            Navigator.push(
                                                context, adaptiveRoute.getRoute());*/
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
                                                                    .data[3]
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
                                                                child: Text(
                                                                  snapshot
                                                                      .data[3]
                                                                      .itemsList[
                                                                  index].description,
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
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 30,
                                                        width: 50,
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          snapshot
                                                              .data[3]
                                                              .itemsList[
                                                                  index]
                                                              .availableCount,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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

  material(String url) async {
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
      final material = response['data']['materials'];
      final equipement = response['data']['equipments'];
      final vechicle = response['data']['vehicles'];
      final contractor = response['data']['contractors'];
      List<ItemsViewList> itemList = [];
      int qty = 0;
      for (var data in material) {
        qty += int.parse(data['quantity '].toString());
        itemList.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['name'],
          date: data['created_date'],
          fileLink: data['file'],
          description: data['description'],
          availableCount: data['available'],
          scopeCount: data['quantity '],
          location: data['location'],
          onsite: data['onsite'],
        ));
      }
      scopeModelData.add(ScopeModel(
          scopeOverollTitle: "Material",
          itemsList: itemList,
          count: qty.toString()));

      List<ItemsViewList> itemList1 = [];
      int qty1 = 0;
      for (var data in equipement) {
        qty1 += int.parse(data['quantity ']);

        itemList1.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['name'],
          date: data['created_date'],
          fileLink: data['file'],
          availableCount: data['available'],
          description: data['description'],
          scopeCount: data['quantity '],
          location: data['location'],
          onsite: data['onsite'],
        ));
      }
      scopeModelData.add(ScopeModel(
          scopeOverollTitle: "Equipment",
          itemsList: itemList1,
          count: qty1.toString()));

      List<ItemsViewList> itemList2 = [];
      int qty2 = 0;

      for (var data in vechicle) {
        qty2 += int.parse(data['quantity ']);

        itemList2.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['name'],
          date: data['created_date'],
          description: data['description'],
          fileLink: data['file'],
          availableCount: data['available'],
          scopeCount: data['quantity '],
          location: data['location'],
          onsite: data['onsite'],
        ));
      }
      scopeModelData.add(ScopeModel(
          scopeOverollTitle: "Vehicle",
          itemsList: itemList2,
          count: qty2.toString()));

      List<ItemsViewList> itemList3 = [];
      int qty3 = 0;

      for (Map<String, dynamic> data in contractor) {
        qty3 +=
            int.parse(data.containsKey('quantity ') ? data['quantity '] : "0");
        itemList3.add(ItemsViewList(
          scopeTitleOrDateString: data['project'],
          itemTitle: data['name'],
          date: data['created_date'].toString(),
          fileLink: data.containsKey('file') ? data['file'] : "",
          description: data['description'],
          availableCount:
              data.containsKey('available') ? data['available'] : "",
          scopeCount: data.containsKey('quantity ') ? data['quantity '] : "",
          location: data.containsKey('location') ? data['location'] : "",
          onsite: data.containsKey('onsite') ? data['onsite'] : "",
        ));
      }
      scopeModelData.add(ScopeModel(
          scopeOverollTitle: "Contractor",
          itemsList: itemList3,
          count: /*qty3.toString()*/ ""));
      return scopeModelData;
    }
  }

  getApiResponseData(String url) async {
    return material(url);
  }
}
