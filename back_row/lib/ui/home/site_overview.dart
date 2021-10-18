import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/ui/agenta/site_agenta.dart';
import 'package:back_row/ui/bookings/bookings.dart';
import 'package:back_row/ui/home/home_page.dart';
import 'package:back_row/ui/home/scope_model.dart';
import 'package:back_row/ui/materials/Material.dart';
import 'package:back_row/ui/milestones/Milestone.dart';
import 'package:back_row/ui/milestones/mileStone_data_details_page.dart';
import 'package:back_row/ui/report/report.dart';
import 'package:back_row/ui/site_overview_details/site_overview.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SiteOverviewPage extends StatefulWidget {
  @override
  _SiteOverviewPageState createState() => _SiteOverviewPageState();
}

class _SiteOverviewPageState extends State<SiteOverviewPage> {
  ScopeModel scopeModel = ScopeModel();
  int clickedItemPosition = 1;
  int homePageSelectedIndex = 0;
  ScrollController _scrollController;
  ScreenshotController screenshotController = ScreenshotController();
  int _counter = 0;
  Uint8List _imageFile;

  @override
  void initState() {
    homePageSelectedIndex = MyHomePage.getCardIndex();
    //  scopeModel =setDummyData();
    _scrollController = new ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
    homePageSelectedIndex = MyHomePage.getCardIndex();
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.animateTo(homePageSelectedIndex * 150.0,
          duration: new Duration(milliseconds: 500), curve: Curves.ease);
    });
    return Scaffold(
      appBar: AppBar(
        leading: null,
        elevation: 0,
        centerTitle: true,
        title: Text(
          StringConstant.liveSite,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorConstant.black),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  /* screenshotController.capture().then((Uint8List image) {
                    //Capture Done
                    setState(() {
                      _imageFile = image;
                    });
                  }).catchError((onError) {
                    print(onError);
                  });*/
                  /* await screenshotController.capture(delay: const Duration(milliseconds: 10)).then((Uint8List image) async {
                    if (image != null) {
                      final directory = await getApplicationDocumentsDirectory();
                      final imagePath = await File('${directory.path}/image.png').create();
                      await imagePath.writeAsBytes(image);

                      /// Share Plugin
                      await Share.shareFiles([imagePath.path]);
                    }
                  });*/
                  _printScreen();
                },
                child: Icon(
                  Icons.file_download,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshLocalGallery,
        child: RepaintBoundary(
          key: _printKey,
          child: Screenshot(
            controller: screenshotController,
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  height: 100,
                  child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            MyHomePage.setCardIndex(index);
                            setState(() {});
                          },
                          child: Container(
                            width: 150,
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                    color: (index == homePageSelectedIndex)
                                        ? Colors.black
                                        : Colors.white),
                                child: Center(
                                    child: Text(
                                  getAssetItemName(index),
                                  style: TextStyle(
                                      color: (index != homePageSelectedIndex)
                                          ? Colors.grey.withOpacity(0.6)
                                          : ColorConstant.yellowGradient2,
                                      fontSize: 16.0,
                                      fontWeight:
                                          (index != homePageSelectedIndex)
                                              ? FontWeight.w400
                                              : FontWeight.w400),
                                )),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                (homePageSelectedIndex == 2)
                    ? MaterialDataPage(selectedIndex: homePageSelectedIndex)
                    : (homePageSelectedIndex == 3)
                        ? MilestoneDetailsPage()
                        : (homePageSelectedIndex == 4)
                            ? ReportDetailsPage(url: REPORT_URL)
                            : (homePageSelectedIndex == 5)
                                ? BookingsPage(url: BOOKING_URL)
                                : (homePageSelectedIndex == 0)
                                    ? SiteOverviewDataPage(
                                        selectedIndex: homePageSelectedIndex)
                                    : SiteAgentaDataPage(
                                        selectedIndex: homePageSelectedIndex),
                // MaterialDataPage(siteOverViewScopeModel: siteOverViewScopeModel),
                //  MileStoneDataPage(siteOverViewScopeModel: siteOverViewScopeModel,),
              ],
            ),
          ),
        ),
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
}
