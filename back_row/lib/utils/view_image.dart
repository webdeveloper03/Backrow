

import 'dart:convert';
import 'dart:ffi';

import 'package:back_row/api/api_route.dart';
import 'package:back_row/api/api_url.dart';
import 'package:back_row/api/preference.dart';
import 'package:back_row/ui/home/bottom_nav_control_page.dart';
import 'package:back_row/ui/home/scope_model.dart';
import 'package:back_row/utils/color.dart';
import 'package:back_row/utils/image.dart';
import 'package:back_row/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class ViewImagePage extends StatefulWidget {
  final String url;

  ViewImagePage({this.url});

  @override
  _ViewImagePageState createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  VideoPlayerController _controller;
  bool isLoadingV=true;
  @override
  void initState() {
    isHide=true;
    loadStream.add("");
    if(widget.url.contains(".mp4")){
      _controller = VideoPlayerController.network(
          'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            isLoadingV=false;
            _controller.play();
          });
        });
    }
    else{
      isLoadingV=false;
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                ColorConstant.white,
                ColorConstant.white,
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
                            isHide=false;
                            loadStream.add("");
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ))),
                  Text(
                    "View Source",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.black),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: (isLoadingV)?Center(child: CircularProgressIndicator(),):(widget.url.contains(".mp4"))?
            Scaffold(
              body: Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                    : Container(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            )
                :Image.network(widget.url,fit: BoxFit.contain,),
          )
        ],
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


