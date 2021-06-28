import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickle/src/provider/post_provider.dart';
import 'package:pickle/src/provider/result_provider.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'model/post.dart';
import 'model/result.dart';
class Home extends StatelessWidget {
  final panelControler = PanelController();

  List<Widget> _makeImageList(BuildContext context, int index, List<Post> postData){
    // values for images
    double _postedImageSize = MediaQuery.of(context).size.width*0.19;
    const double _imageRadiusVal = 15.0;
    // values for interval
    double _intervalWidth = MediaQuery.of(context).size.width*0.0155;

    List<Widget> imageList = [];
    if (postData[index].images.length < 5){
      for(int i = 0; i < postData[index].images.length; i++){
        imageList.add(
            ClipRRect(
              child: Image.asset(postData[index].images[i], width: _postedImageSize, height: _postedImageSize, fit: BoxFit.fill,),
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
              child: Image.asset(postData[index].images[i], width: _postedImageSize, height: _postedImageSize, fit: BoxFit.fill,),
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
            image: DecorationImage(image: AssetImage(postData[index].images[3],), fit: BoxFit.fill,),
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

  Widget _makePickPeople(int index, List<Post> postData){
    if (postData[index].picks.length > 0){
      return Text(postData[index].picks[0] + "님 외 " + (postData[index].picks.length-1).toString() + "명");
    }else{
      return Text("아직 아무도 참여하지 않았습니다");
    }
  }

  Widget _makePostList(List<Post> postData){
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
                            child: GestureDetector(
                              child: ClipRRect(
                                child: Image.asset(postData[index].icon, height: _writerIconSize, width: _writerIconSize,),
                                borderRadius: BorderRadius.all(Radius.circular(_writerIconRadiusVal)),
                              ),
                              onTap: (){

                              },
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
                                          Text(postData[index].writer, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),),
                                          Expanded(child: Container(),),
                                          Row(children: [Icon(Icons.lock_open_rounded, size: _statusIconSize,), Text(postData[index].status, style: TextStyle(color: Colors.indigo),),],)
                                        ],
                                      )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: _makeImageList(context, index, postData),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(postData[index].text, style: TextStyle(color: Colors.indigo),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        _makePickPeople(index, postData),
                                        Expanded(child: Container(),),
                                        Icon(Icons.speaker_notes, size: _commentIconSize,),
                                        Text(postData[index].comments.length.toString(), style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: _commentCountFontSize),),
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
    PostProvider _postProvider = Provider.of<PostProvider>(context, listen: false);
    // values for panel
    double _panelMinHeight = MediaQuery.of(context).size.height * 0.2;
    double _panelMaxHeight = MediaQuery.of(context).size.height;
    const double _panelBorderRadiusVal = 20.0;
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
          minHeight: _panelMinHeight,
          maxHeight: _panelMaxHeight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(_panelBorderRadiusVal)),
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

  Widget _makeResultBox(BuildContext context ,int index, List<Result> resultData){
    double _resultImageSize = MediaQuery.of(context).size.width*0.44;
    DateTime nowDate = DateTime.now();

    if (resultData.length != 0){
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(resultData[index].image, width: _resultImageSize, height: _resultImageSize, fit: BoxFit.fill,)
              ),
            ),
            Text(
              resultData[index].text,
            ),
            Row(
              children: [
                Text(
                  resultData[index].writer,
                ),
                Expanded(child: Container()),
                Icon(Icons.timer, size: 15,),
                Text(
                  nowDate.difference(DateTime.parse(resultData[index].finishedDate)).toString().split(":")[0] + ":" + nowDate.difference(DateTime.parse(resultData[index].finishedDate)).toString().split(":")[1]
                ),
              ],
            ),
          ],
        ),
      );
    }else{
      return Center(
        child: Text("종료된 방이 없습니다."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ResultProvider _resultProvider = Provider.of<ResultProvider>(context, listen: false);

    return Material(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            padding: EdgeInsets.only(left: 15),
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
          Consumer<ResultProvider>(
            builder: (context, provider, widget){
              List<Result> resultData = provider.getResult;
              return Expanded(
                child: GridView.builder(
                  itemBuilder: (context, int index){
                    return GestureDetector(
                      child: _makeResultBox(context, index, resultData),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: resultData.length,
                ),
              );
            },

          )
        ],
      ),
    );
  }
}
