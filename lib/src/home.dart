import 'package:flutter/material.dart';
import 'package:pickle/src/data.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatelessWidget {

  List<Widget> makeImageList(int index){
    List<Widget> imageList = [];
    if (datas[index]["images"].length < 5){
      for(int i = 0; i < datas[index]["images"].length; i++){
        imageList.add(
          ClipRRect(
            child: Image.asset(datas[index]["images"][i], width: 75, height: 75, fit: BoxFit.fill,),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )
          
        );
        imageList.add(Container(width: 10,));
      }
    }else{
      for(int i = 0; i < 3; i++){
        imageList.add(Image.asset(datas[index]["images"][i], width: 75, height: 75, fit: BoxFit.fill,));
      }
    }
    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        SlidingUpPanel(
          minHeight: MediaQuery.of(context).size.height * 0.2,
          maxHeight: MediaQuery.of(context).size.height,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          body : Scaffold(
            appBar: AppBar(
              title: Text("Pickle"),
              actions: <Widget>[
                new IconButton(
                  onPressed: (){
                    //검색화면 이동
                  },
                  icon: Icon(Icons.search)
                ),
                new IconButton(
                  onPressed: (){
                    //친구초대화면 이동
                  },
                  icon: Icon(Icons.mail)
                ),
                new IconButton(
                  onPressed: (){
                    //알람확인화면 이동
                  },
                  icon: Icon(Icons.add_alert)
                ),
              ],
              elevation: 0,
            ),
            body : ListView.separated(
              itemBuilder: (BuildContext _context, int index){
                return GestureDetector(
                  child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            child: Image.asset(datas[index]["icon"], height: 50, width: 50,),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          Container(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(datas[index]["name"], style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),),
                              Container(height: 5,),
                              Row(
                                  children: makeImageList(index)
                              ),
                              Container(height: 5,),
                              Text(datas[index]["text"], style: TextStyle(color: Colors.indigo,),),
                              Container(height: 5,),
                              Text("외 n명")
                            ],
                          ),
                        ],
                      )
                  ),
                  onTap: () {

                  },
                );
                },
                separatorBuilder: (context, index) {
                  return Container(height: 15,);
                },
                itemCount: datas.length,
              ),
            ),
          panelBuilder: (controller) =>SlidePanelWidget(controller: controller,),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width*0.05,
          bottom: MediaQuery.of(context).size.height*0.05,
          child : FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: (){

            },
            child: Icon(Icons.person),
          )
        ),
        Positioned(
            right: MediaQuery.of(context).size.width*0.33,
            bottom: MediaQuery.of(context).size.height*0.05,
            child : Container(
              width: MediaQuery.of(context).size.width*0.34,
              height: 50,
              child: new RawMaterialButton(
                fillColor: Colors.blue,
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                onPressed: (){

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text("방 만들기")
                  ],
                ),
              ),
            )
        ),
      ],
    );
  }
}

class SlidePanelWidget extends StatelessWidget {
  final ScrollController controller;

  const SlidePanelWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15,),
          Center(
            child: Container(
              width : 30,
              height : 5,
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
          ),
          Text(
            "결과보기",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
            textAlign: TextAlign.start,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: controller,
              padding: EdgeInsets.zero,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(12),
                  child: Text("$index",),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

