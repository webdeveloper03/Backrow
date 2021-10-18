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


class MaterialsDetailsPage extends StatefulWidget {
  final String url;
  final int flag;

  MaterialsDetailsPage({this.flag, this.url});

  @override
  _MaterialsDetailsPageState createState() => _MaterialsDetailsPageState();
}

class _MaterialsDetailsPageState extends State<MaterialsDetailsPage> {
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
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:_refreshLocalGallery,
        child: Column(
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
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
              child: FutureBuilder(
                  future: material(widget.url),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data is List<ScopeModel>) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 70),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Container(
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
                                  height: 50 +
                                      (snapshot.data[0].itemsList.length * MediaQuery.of(context).size.height*0.1),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        /*  Container(
                                              margin: EdgeInsets.all(20),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                snapshot.data[0].itemsList[0]
                                                    .scopeTitleOrDateString,
                                                style: TextStyle(
                                                    color: ColorConstant.soDateColor,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.normal),
                                              )),*/
                                        /*  Container(
                                              margin: EdgeInsets.all(20),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                (widget.url.contains("contract"))?"": snapshot.data[0].count,
                                                style: TextStyle(
                                                    color: ColorConstant.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500),
                                              )),*/

                                        ],
                                      ),
                                    /*  Container(
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
                                             /* Container(
                                                child: SvgPicture.asset(
                                                    ImageConstant.truckIcon),
                                                height: 40,
                                                width: 40,
                                              ),*/
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
                                                  onTap:(widget.url.contains("contract"))?null: () {
                                                    final destination = (context) => ViewImagePage(
                                                      url:  snapshot.data[0].itemsList[index].fileLink,
                                                    );
                                                    final adaptiveRoute = AdaptiveRoute(
                                                        context: context, destination: destination);
                                                    Navigator.push(
                                                        context, adaptiveRoute.getRoute());
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
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                      /*  Container(
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
                                                                    maxLines: 3,
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
                                                          width: 50,
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Text(
                                                            snapshot
                                                                .data[0]
                                                                .itemsList[index]
                                                                .availableCount,
                                                            style: TextStyle(
                                                                color: Colors.black
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
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }
  Future<Null> _refreshLocalGallery() async{

    Future.delayed(Duration(seconds: 2), () async {
      setState(() {

      });
      print('refreshing stocks...');
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



  String getTitle() {
    return widget.flag==0?"Material":widget.flag==1?"Equipment":widget.flag==2?"Vehicle":
    widget.flag==3?"Contractor":"";
  }



  material(String url) async {
    http.Response res = await ApiRoute.callRouteAPI(
        url: url,
        body: "",
        callMethod: GET,
        isWithToken: false,
        context: context);
    print(res.body);
    final response = json.decode(res.body);
    List<ScopeModel> scopeModelData = [];

    final contractor = response['data'];

    List<ItemsViewList> itemList3 = [];
    int qty3=0;

    for (Map<String,dynamic> data in contractor) {
      qty3+=int.parse(data.containsKey('quantity ')?data['quantity ']:"0");
      itemList3.add(ItemsViewList(
        scopeTitleOrDateString: data['project'],
        itemTitle: data['name'],
        description: data['description'],
        date: data['created_date'].toString(),
        fileLink:  data.containsKey('file')?data['file']:"",
        availableCount: data.containsKey('available')?data['available']:"",
        scopeCount:data.containsKey('quantity ')?data['quantity ']:"0",
        location: data.containsKey('location')?data['location']:"0",
        onsite: data.containsKey('onsite')?data['onsite']:"",
      ));
    }
    scopeModelData
        .add(ScopeModel(scopeOverollTitle: "Contractor", itemsList: itemList3,count: qty3.toString()));
    return scopeModelData;
  }
}


