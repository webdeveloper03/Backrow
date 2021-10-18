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

class MilestoneDataPage extends StatefulWidget {

  @override
  _MilestoneDataPageState createState() => _MilestoneDataPageState();
}

class _MilestoneDataPageState extends State<MilestoneDataPage> {
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
  num getHeight(itemTitle) {
    if(itemTitle.length<70)
    {
      return 0.0;
    }
    else if(itemTitle.length<100){
      return 30.0;

    }
    else if(itemTitle.length<150){
      return 50.0;

    }
    return 60.0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:_refreshLocalGallery ,
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
                      "Milestones",
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
                  future: siteAgenda(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data is List<ScopeModel>) {
                      return    Container(
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
                          child:  Container(
                            height: 20 +
                                (snapshot.data[0].itemsList.length *
                                    130.0),
                            child: Stack(
                              children: [
                                backgroundEffect(),
                                backgroundEffectWithColor(),
                                titleView(),
                                loadList(snapshot.data[0].itemsList)
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    else if(snapshot.hasData && snapshot.data is String){
                      return Expanded(child: Center(child: Text(snapshot.data,style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),)));
                    }
                    else
                      return Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
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
                    final adaptiveRoute =
                    AdaptiveRoute(context: context, destination: destination);
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
                                border: Border.all(color: data[index]
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
                                    : ColorConstant.red,width: 1.2)
                            ),
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
                            child: SvgPicture.asset(ImageConstant.dot,color: Colors.yellow,)),
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
                                  height: 80+getHeight(data[index].itemTitle),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20, top: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index].scopeTitleOrDateString,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: ColorConstant.black.withOpacity(0.8),
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
                                                    fontSize: 12,
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

  siteAgenda() async {
    http.Response res = await ApiRoute.callRouteAPI(
        url: MILESTONE_URL,
        body: "",
        callMethod: GET,
        isWithToken: false,
        context: context);
    print(res.body);
    final response = json.decode(res.body);
    List<ScopeModel> scopeModelData = [];
    final arriveList = response['data'];
    final resBody = json.decode(res.body);
    if (resBody['success'] == false) {
      return resBody['data']['error'];
    }
    else {
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
      scopeModelData
          .add(
          ScopeModel(scopeOverollTitle: "Milestones", itemsList: itemList2));
      return scopeModelData;
    }
  }

}
