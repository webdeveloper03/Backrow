import 'dart:ffi';

import 'package:back_row/ui/home/scope_model.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/custom_app_button.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_line/dotted_line.dart';

class MileStoneDataPage extends StatefulWidget {


  @override
  _MileStoneDataPageState createState() => _MileStoneDataPageState();
}

class _MileStoneDataPageState extends State<MileStoneDataPage> {
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
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
              margin: EdgeInsets.only(left: 5, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20, top: 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 20, top: 0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        StringConstant.viewMore,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.customBtnGradient2,
                            fontSize: 15),
                      )),
                ],
              )),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Container(
                height: 300 +0.0,
                   /* (widget.siteOverViewScopeModel.itemsList[0].subItemList
                            .length *
                        50.0)*/
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        margin: EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          /*widget.siteOverViewScopeModel.itemsList[0]
                              .scopeTitleOrDateString*/"",
                          style: TextStyle(
                              color: ColorConstant.soDateColor,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: DottedLine(
                        lineThickness: 0.5,
                        dashColor: Colors.grey,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Text(
                         /* widget.siteOverViewScopeModel.itemsList[0]
                              .firstViewItem.itemTitle*/"",
                          style: TextStyle(
                              color: ColorConstant.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: SvgPicture.asset(ImageConstant.truckIcon),
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                /*widget.siteOverViewScopeModel.itemsList[0]
                                    .firstViewItem.itemSubTitle*/"",
                                style: TextStyle(
                                    color: ColorConstant.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  /*widget.siteOverViewScopeModel.itemsList[0]
                                      .firstViewItem.description*/"",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.9),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: DottedLine(
                        lineThickness: 0.5,
                        dashColor: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            scrollDirection: Axis.vertical,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                         /* widget
                                              .siteOverViewScopeModel
                                              .itemsList[0]
                                              .subItemList[index]
                                              .itemTitle*/"",
                                          style: TextStyle(
                                              color: ColorConstant.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Container(
                                          width: 160,
                                          child: Text(
                                           /* widget
                                                .siteOverViewScopeModel
                                                .itemsList[0]
                                                .subItemList[index]
                                                .description*/"",
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: Colors.grey
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: (index == 0) ? true : false,
                                      child: Container(
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 4,
                                                bottom: 4,
                                                left: 7,
                                                right: 7),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      ColorConstant
                                                          .customBtnGradient1,
                                                      ColorConstant
                                                          .customBtnGradient2,
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment
                                                        .bottomCenter)),
                                            child: Center(
                                                child: Text(
                                              "View",
                                              style: TextStyle(
                                                  color: ColorConstant
                                                      .yellowGradient2,
                                                  fontSize: 11.0,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 30,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                         /* widget
                                              .siteOverViewScopeModel
                                              .itemsList[0]
                                              .subItemList[index]
                                              .subItemCountOrDateTimeString*/"",
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.6),
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 0),
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                          colors: [
                            ColorConstant.customBtnGradient1,
                            ColorConstant.customBtnGradient2,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstant.projectStatus,
                            style: TextStyle(
                                color: ColorConstant.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(StringConstant.milestones,
                              style: TextStyle(
                                  color: ColorConstant.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 30, bottom: 40),
                        child: SvgPicture.asset(ImageConstant.milestone))
                  ],
                )
              ],
            ),
          ),

          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Container(
                height: 300 +0.0,
                   /* (widget.siteOverViewScopeModel.itemsList[0].subItemList
                            .length *
                        65.0) -
                    10*/
                child: Stack(
                  children: [
                    backgroundEffect(),
                    backgroundEffectWithColor(),
                    titleView(),
                    loadList()
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 30,right: 30,bottom: 30,top: 15),
            child: Text("Site Live 13:57",style: TextStyle(color: ColorConstant.mileStoneTextColor,fontSize: 17,fontWeight: FontWeight.bold),),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    ColorConstant.liveCardColor.withOpacity(0.2),
                    ColorConstant.liveCardColor.withOpacity(0.2)
                  ],
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
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

  backgroundEffect() {
    return Row(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width / 3.5 +
              MediaQuery.of(context).size.width / 40),
          decoration: BoxDecoration(
            color: ColorConstant.milestonePageLineColor,
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

  loadList() {
    return Container(
      margin: EdgeInsets.only(top: 60),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 40, bottom: 40),
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: Text(
                          (index % 2 == 0)
                              ? StringConstant.completed
                              : StringConstant.pending,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: (index % 2 == 0)
                                  ? ColorConstant.green
                                  : ColorConstant.red,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 30,
                      child: SvgPicture.asset(ImageConstant.dot)),
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
                        alignment: Alignment.topCenter,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Plot 8 Build 9",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.mileStoneTextColor, fontSize: 12),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "Crack in cement of room 2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.black, fontSize: 15,fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            );
          }),
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
                    color:
                    ColorConstant.blueGrey.withOpacity(0.5),
                    fontWeight: FontWeight.normal))),
      ],
    );
  }
}
