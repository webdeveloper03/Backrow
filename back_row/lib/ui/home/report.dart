import 'dart:convert';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/utils/adaptive_route.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:back_row/utils/view_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Report> sizePlotList = [];
  List<Report> originalList = [];
  int subTotal;
  String searchText;
  int selectedFileIndex = 0;

  Future<Null> _refreshLocalGallery() async {
    Future.delayed(Duration(seconds: 2), () async {
      setState(() {});
      print('refreshing stocks...');
    });
  }

  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 40),
          child: Text(
            StringConstant.report,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: ColorConstant.black),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              originalList.clear();
              setState(() {});
            },
            child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.refresh,
                  color: Colors.black,
                  size: 30,
                )),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshLocalGallery,
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 30,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black, spreadRadius: 0.4),
                        ],
                      ),
                      child: TextFormField(
                        onChanged: (searchText){
                          print(searchText);
                          this.searchText=searchText;
                          loadSearchContent(searchText);
                        },
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            prefixIcon: Container(
                              child: Icon(Icons.search,color: Colors.black.withOpacity(0.6),),),
                            contentPadding:
                            EdgeInsets.only(left: 15, bottom: 13, right: 15),
                            hintText: "Search"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      _printScreen();
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.file_download,
                        size: 26.0,
                      ),
                    ),
                  )
                ],
              ),
              (originalList.length==0)? FutureBuilder(
                  future: getData(),
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
                      return Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    }
                  }):loadBuildView(context, sizePlotList),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadBuildView(BuildContext context, data) {
    return Expanded(
      child: RepaintBoundary(
        key: _printKey,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  selectedFileIndex = index;
                  setState(() {});
                  final destination = (context) => ViewImagePage(
                        url: data[index].url,
                      );
                  final adaptiveRoute =
                      AdaptiveRoute(context: context, destination: destination);
                  Navigator.push(context, adaptiveRoute.getRoute());
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    color: (selectedFileIndex == index)
                        ? Colors.black
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 0,
                      ),
                      (data[index].type.toString().toLowerCase() == "mp4")
                          ? Container(
                              height: 43,
                              width: 43,
                              child: Image.asset("assets/images/mp4.png",
                                  color: (selectedFileIndex != index)
                                      ? Colors.black
                                      : Colors.yellow))
                          :  (data[index].type.toString().toLowerCase() == "pdf")?Container(
                              height: 43,
                              width: 43,
                              child: SvgPicture.asset(
                                (selectedFileIndex == index)
                                    ? ImageConstant.selected_pdf
                                    : ImageConstant.unselected_pdf,
                              ),
                            ):
                      Container(
                          height: 43,
                          width: 43,
                          child: Image.asset("assets/images/mp4.png",
                              color: (selectedFileIndex != index)
                                  ? Colors.black
                                  : Colors.yellow)),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data[index].name.toString(),
                            style: TextStyle(
                                color: (selectedFileIndex == index)
                                    ? ColorConstant.yellow
                                    : ColorConstant.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            data[index].date,
                            style: TextStyle(
                                color: (selectedFileIndex == index)
                                    ? ColorConstant.yellow
                                    : Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              child: Text(
                                data[index].size,
                                style: TextStyle(
                                    color: (selectedFileIndex == index)
                                        ? ColorConstant.yellow
                                        : Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
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
        url: REPORT_URL,
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
      for (var data in response) {
        sizePlotList.add(Report(
            name: data["name"],
            url: data['url'],
            size: data['size'].toString(),
            date: data['date'],
            type: data['type'].toString()));
      }
      originalList.clear();
      originalList.addAll(sizePlotList);
      return sizePlotList;
      // name = response['data']['client']['name'].toString();
    }
  }

  void loadSearchContent(String searchText) {
    sizePlotList= originalList.where((element) => element.name.contains(searchText)).toList();
    if(sizePlotList.length==0&&searchText.isEmpty)
    sizePlotList=originalList;
    setState(() {

    });
  }
}

class Report {
  String name, url, size, type, date;

  Report({this.name, this.url, this.size, this.type, this.date});
}
