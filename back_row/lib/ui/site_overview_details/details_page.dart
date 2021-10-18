import 'dart:convert';
import 'dart:ffi';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/api/preference.dart';
import 'package:back_row/ui/home/scope_model.dart';
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

class DetailsPage extends StatefulWidget {
  final String url;
  final int flag;

  DetailsPage({this.flag, this.url});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  Future<Null> _refreshLocalGallery() async{

    Future.delayed(Duration(seconds: 2), () async {
      setState(() {

      });
      print('refreshing stocks...');
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:_refreshLocalGallery,
        child: Column(
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.transparent,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        left: 20,
                        child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ))),
                    Text(
                     getTitle(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: FutureBuilder(
                    future: getApiResponseData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data is List<ScopeModel>) {
                        return (widget.flag==1)? SingleChildScrollView(
                          child: Container(
                            height:90*snapshot
                                .data[0].itemsList.length*1.0,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(bottom: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
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
                                          height: setHeight(
                                              snapshot
                                                  .data[0]
                                                  .itemsList[
                                              index]
                                                  .description),
                                          margin: EdgeInsets.only(
                                              top: 20,
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
                                              Container(
                                                margin: EdgeInsets
                                                    .only(top: 0),
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
                                                  margin: EdgeInsets
                                                      .only(
                                                      top:
                                                      10),
                                                  child: Text(
                                                    snapshot
                                                        .data[0]
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
                                      );
                                    }),
                              )
                            ),
                          ),
                        ):Container(
                        //  padding: EdgeInsets.only(bottom: 70),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20, top: 20),
                                child:(widget.flag!=3)? Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Container(
                                    height: 80 +
                                        (snapshot.data[0].itemsList.length *MediaQuery.of(context).size.height*0.145),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                       /* Container(
                                            margin: EdgeInsets.all(20),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot.data[0].itemsList[0]
                                                  .scopeTitleOrDateString,
                                              style: TextStyle(
                                                  color: ColorConstant.soDateColor,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal),
                                            )),
                                        Container(
                                          margin:
                                              EdgeInsets.only(left: 20, right: 20),
                                          child: DottedLine(
                                            lineThickness: 0.5,
                                            dashColor: Colors.grey,
                                          ),
                                        ),*/

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
                                          height: 20,
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
                                                      final destination = (context) => ViewImagePage(
                                                        url:  snapshot.data[0].itemsList[index].fileLink,
                                                      );
                                                      final adaptiveRoute = AdaptiveRoute(
                                                          context: context, destination: destination);
                                                      Navigator.push(
                                                          context, adaptiveRoute.getRoute());
                                                    },
                                                    child: Column(
                                                      children: [
                                                        (index!=0)? Container(
                                                          margin:
                                                          EdgeInsets.only(left: 20, right: 20,top: 20),
                                                          child: DottedLine(
                                                            lineThickness: 0.5,
                                                            dashColor: Colors.grey,
                                                          ),
                                                        ):Container(),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              top: 20,
                                                              left: 20,
                                                              right: 20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              /*Container(
                                                                child: SvgPicture.asset(
                                                                    ImageConstant
                                                                        .truckIcon),
                                                                height: 40,
                                                                width: 40,
                                                              ),*/
                                                              SizedBox(
                                                                width: 10,
                                                              ),
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
                                                                      margin:
                                                                          EdgeInsets.only(
                                                                              top: 10),
                                                                      child: Text(
                                                                        snapshot
                                                                            .data[0]
                                                                            .itemsList[
                                                                                index]
                                                                            .itemTitle,
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorConstant
                                                                                    .black,
                                                                            fontSize:( snapshot
                                                                                .data[
                                                                            0]
                                                                                .itemsList[
                                                                            index].highLight=="1")?18: 15,
                                                                            fontWeight:
                                                                            ( snapshot
                                                                                .data[
                                                                            0]
                                                                                .itemsList[
                                                                            index].highLight=="1")?FontWeight.w700: FontWeight
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
                                                                              fontSize:( snapshot
                                                                                  .data[
                                                                              0]
                                                                                  .itemsList[
                                                                              index].highLight=="1")?15: 12,
                                                                              fontWeight:
                                                                              ( snapshot
                                                                                  .data[
                                                                              0]
                                                                                  .itemsList[
                                                                              index].highLight=="1")?FontWeight.w800:FontWeight
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
                                                                      padding:
                                                                          EdgeInsets.only(
                                                                              top: 4,
                                                                              bottom: 4,
                                                                              left: 7,
                                                                              right: 7),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              borderRadius:
                                                                                  BorderRadius
                                                                                      .all(
                                                                                Radius
                                                                                    .circular(
                                                                                        4),
                                                                              ),
                                                                              gradient: LinearGradient(
                                                                                  colors: [
                                                                                    ColorConstant
                                                                                        .customBtnGradient1,
                                                                                    ColorConstant
                                                                                        .customBtnGradient2,
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
                                                                width:50,
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                  "",
                                                                  style: TextStyle(
                                                                      color: Colors.grey
                                                                          .withOpacity(
                                                                              0.6),
                                                                      fontSize: 10.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ):Container(
                                  height: 100 +
                                      (snapshot.data[0].itemsList.length * MediaQuery.of(context).size.height*0.16),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      /* Container(
                                          margin: EdgeInsets.all(20),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            snapshot.data[0].itemsList[0]
                                                .scopeTitleOrDateString,
                                            style: TextStyle(
                                                color: ColorConstant.soDateColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                          )),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 20, right: 20),
                                        child: DottedLine(
                                          lineThickness: 0.5,
                                          dashColor: Colors.grey,
                                        ),
                                      ),*/

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
                                        height: 20,
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
                                                    final destination = (context) => ViewImagePage(
                                                      url:  snapshot.data[0].itemsList[index].fileLink,
                                                    );
                                                    final adaptiveRoute = AdaptiveRoute(
                                                        context: context, destination: destination);
                                                    Navigator.push(
                                                        context, adaptiveRoute.getRoute());
                                                  },
                                                  child: Container(
                                                    height:100+setHeightYellowCard( snapshot  .data[0]
                                                        .itemsList[index]
                                                        .description),
                                                    margin: EdgeInsets.only(top: 10,bottom: 10),
                                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(18),
                                                          topRight: Radius.circular(18),
                                                          bottomLeft: Radius.circular(18),
                                                          bottomRight: Radius.circular(18),
                                                        ),
                                                        border: Border.all(color:Colors.yellow,width: 1.2)
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              /*Container(
                                                                child: SvgPicture.asset(
                                                                    ImageConstant
                                                                        .truckIcon),
                                                                height: 40,
                                                                width: 40,
                                                              ),*/
                                                              SizedBox(
                                                                width: 10,
                                                              ),
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
                                                                      margin:
                                                                      EdgeInsets.only(
                                                                          top: 10),
                                                                      child: Text(
                                                                        snapshot
                                                                            .data[0]
                                                                            .itemsList[
                                                                        index]
                                                                            .itemTitle,
                                                                        style: TextStyle(
                                                                            color:
                                                                            ColorConstant
                                                                                .black,
                                                                            fontSize: 15,
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
                                                                              fontSize: 13,
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
                                                                      padding:
                                                                      EdgeInsets.only(
                                                                          top: 4,
                                                                          bottom: 4,
                                                                          left: 7,
                                                                          right: 7),
                                                                      decoration:
                                                                      BoxDecoration(
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                            Radius
                                                                                .circular(
                                                                                4),
                                                                          ),
                                                                          gradient: LinearGradient(
                                                                              colors: [
                                                                                ColorConstant
                                                                                    .customBtnGradient1,
                                                                                ColorConstant
                                                                                    .customBtnGradient2,
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
                                                                width:50,
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                 "",
                                                                  style: TextStyle(
                                                                      color: Colors.grey
                                                                          .withOpacity(
                                                                          0.6),
                                                                      fontSize: 10.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
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
                            ],
                          ),
                        );
                      } else
                        return Container(
                          alignment: Alignment.center,
                            child: CircularProgressIndicator());
                    }),
              ),
            ),
          ],
        ),
      ),
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
  setHeight(description) {
    if (description.length < 100) {
      return 80.0;
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
      return 40.0;
    } else if (description.length < 300) {
      return 50.0;
    } else if (description.length < 400) {
      return 70.0;
    }
    return 90.0;
  }
  getApiResponseData() async {
    http.Response res = await ApiRoute.callRouteAPI(
        url: widget.url,
        body: "",
        callMethod: GET,
        isWithToken: false,
        context: context);
    print(res.body);
    final response = json.decode(res.body);
    List<ScopeModel> scopeModelData = [];
    final overViewList = response['data'];
    List<ItemsViewList> itemList = [];
    for (var data in overViewList) {
      itemList.add(ItemsViewList(
        scopeTitleOrDateString: data['project'],
        itemTitle: data['text'],
        date: data['date'],
        highLight: data['highlight'],
        description: data['description']??"Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like",
        fileLink: data['file'],
      ));
    }
    scopeModelData.add(
        ScopeModel(scopeOverollTitle: "Site Overview", itemsList: itemList));

    return scopeModelData;
  }

  String getTitle() {
    return widget.flag==0?StringConstant.siteOverview:widget.flag==1?"Expected to Arrive":widget.flag==2?"Progress/Checks":
    widget.flag==3?"Site Agenda":widget.flag==4?"End of Day":widget.flag==5?"Milestones":"";
  }
}
