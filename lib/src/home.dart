import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pickle/src/data.dart';
import 'package:pickle/src/provider/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
class Home extends StatelessWidget {
  late PostProvider _postProvider;
  final panelControler = PanelController();

  List<Widget> _makeImageList(BuildContext context, int index){
    // values for images
    double _postedImageSize = MediaQuery.of(context).size.width*0.19;
    const double _imageRadiusVal = 15.0;
    // values for interval
    double _intervalWidth = MediaQuery.of(context).size.width*0.0155;

    List<Widget> imageList = [];
    if (datas[index]["images"].length < 5){
      for(int i = 0; i < datas[index]["images"].length; i++){
        imageList.add(
            ClipRRect(
              child: Image.asset(datas[index]["images"][i], width: _postedImageSize, height: _postedImageSize, fit: BoxFit.fill,),
              borderRadius: BorderRadius.all(Radius.circular(_imageRadiusVal)),
            )
        );
        imageList.add(
          Container(width: _intervalWidth,)
        );
      }
    }else{
      for(int i = 0; i < 3; i++){
        imageList.add(
            ClipRRect(
              child: Image.asset(datas[index]["images"][i], width: _postedImageSize, height: _postedImageSize, fit: BoxFit.fill,),
              borderRadius: BorderRadius.all(Radius.circular(_imageRadiusVal)),
            )
        );
        imageList.add(
            Container(width: _intervalWidth,)
        );
      }
      imageList.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_imageRadiusVal)),
            image: DecorationImage(image: AssetImage(datas[index]["images"][3],), fit: BoxFit.fill,),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(_imageRadiusVal)),
                color: Colors.black.withOpacity(0.3),
              ),
              width: _postedImageSize,
              height: _postedImageSize,
              child: Icon(Icons.more_horiz, color: Colors.white,),
            )
          ),
          width: _postedImageSize,
          height: _postedImageSize,
        )
      );
    }
    return imageList;
  }

  Widget _makePickPeople(int index){
    if (datas[index]["picks"].length > 0){
      return Text(datas[index]["picks"][0] + "님 외 " + (datas[index]["picks"].length-1).toString() + "명");
    }else{
      return Text("아직 아무도 참여하지 않았습니다");
    }
  }

  Widget _makePostList(List<Map<String, dynamic>> postData){
    // values for writer's icon
    const double _writerIconSize = 50.0;
    const double _writerIconRadiusVal = 20.0;
    // values for status icon
    const double _statusIconSize = 15.0;
    // values for comment
    const double _commentIconSize = 17.0;
    const double _commentCountFontSize = 20.0;

    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, int index){
                if (index >= postData.length){
                  return Container(
                    height: MediaQuery.of(context).size.height*0.2,
                  );
                }else{
                  return GestureDetector(
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 3),
                            child: ClipRRect(
                              child: Image.asset(postData[index]["icon"], height: _writerIconSize, width: _writerIconSize,),
                              borderRadius: BorderRadius.all(Radius.circular(_writerIconRadiusVal)),
                            ),
                          ),
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Text(postData[index]["writer"], style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),),
                                          Expanded(child: Container(),),
                                          Row(children: [Icon(Icons.lock_open_rounded, size: _statusIconSize,), Text(postData[index]["status"], style: TextStyle(color: Colors.indigo),),],)
                                        ],
                                      )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: _makeImageList(context, index),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(postData[index]["text"], style: TextStyle(color: Colors.indigo),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        _makePickPeople(index),
                                        Expanded(child: Container(),),
                                        Icon(Icons.speaker_notes, size: _commentIconSize,),
                                        Text(postData[index]["comments"].length.toString(), style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: _commentCountFontSize),),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                    },
                  );
                }
              },
              separatorBuilder: (context, index){
                return Container(height: 10,);
              },
              itemCount: postData.length+1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _postProvider = Provider.of<PostProvider>(context, listen: false);
    // values for pannel
    double _pannelMinHeight = MediaQuery.of(context).size.height * 0.2;
    double _pannelMaxHeight = MediaQuery.of(context).size.height;
    const double _pannelBorderRadiusVal = 20.0;
    // values for profile button
    double _profileButtonPosition = MediaQuery.of(context).size.width*0.05;
    const double _profileButtonWidth = 60.0;
    const double _profileButtonHeight = 50.0;
    const double _profileIconBorderRadiusVal = 20.0;
    // values for make_room button
    double _makeRoomButtonPositionRight = MediaQuery.of(context).size.width*0.30;
    double _makeRoomButtonPositionBottom = MediaQuery.of(context).size.height*0.05;
    double _makeRoomButtonWidth = MediaQuery.of(context).size.width*0.40;
    const double _makeRoomButtonHeight = 50.0;
    const double _makeRoomButtonBorderRadiusVal = 50.0;
    const double _makeRoomButtonFontSize = 18.0;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SlidingUpPanel(
          controller: panelControler,
          minHeight: _pannelMinHeight,
          maxHeight: _pannelMaxHeight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(_pannelBorderRadiusVal)),
          body : Scaffold(
              appBar: AppBar(
                title: Text("Pickle"),
                actions: [
                  new IconButton(
                    onPressed: (){
                      //검색화면 이동
                    },
                    icon: Icon(Icons.search),
                  ),
                  new IconButton(
                    onPressed: (){
                      //친구초대화면 이동
                    },
                    icon: Icon(Icons.mail),
                  ),
                  new IconButton(
                    onPressed: (){
                      //알람확인화면 이동
                    },
                    icon: Icon(Icons.add_alert),
                  ),
                ],
                elevation: 0,
              ),
              body: Consumer<PostProvider>(
                builder: (context, provider, widget){
                  return _makePostList(provider.getPostData);
                },
              )
          ),
          panelBuilder: (controller) => SlidePanelWidget(controller: controller, panelController: panelControler,),
        ),
        Positioned(
            right: _profileButtonPosition,
            bottom: _profileButtonPosition,
            child: Container(
              width: _profileButtonWidth,
              height: _profileButtonHeight,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_profileIconBorderRadiusVal))),
                backgroundColor: Colors.white,
                onPressed: (){

                },
                child: Icon(Icons.person),
              ),
            )
        ),
        Positioned(
            right: _makeRoomButtonPositionRight,
            bottom: _makeRoomButtonPositionBottom,
            child: Container(
              width: _makeRoomButtonWidth,
              height: _makeRoomButtonHeight,
              child: new RawMaterialButton(
                fillColor: Colors.indigo,
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(_makeRoomButtonBorderRadiusVal))),
                onPressed: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white,),
                    Text("방 만들기", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: _makeRoomButtonFontSize),)
                  ],
                ),
              ),
            )
        )
      ],
    );
  }
}

class SlidePanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  const SlidePanelWidget({
    Key? key,
    required this.panelController,
    required this.controller,
  }) : super(key: key);

  // Widget _makeResultList(){
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlueAccent,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15,),
          Center(
            child: Container(
              width : 45,
              height : 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child:  Text(
              "결과보기",
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemBuilder: (context, int index){
                return GestureDetector(
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.grey,
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
