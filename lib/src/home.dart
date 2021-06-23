import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatelessWidget {
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

                  },
                  icon: Icon(Icons.search)
                ),
                new IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.mail)
                ),
                new IconButton(
                  onPressed: (){

                  },
                  icon: Icon(Icons.add_alert)
                ),
              ],
              elevation: 0,
            ),
            body : ListView.builder(
              itemBuilder: (BuildContext _context, int index){
                return Container(
                  child: Row(
                    children: [
                      Container(),
                      Column(
                        children: [
                          Text("이름")
                        ],
                      ),
                    ],
                  )
                );
              },
                itemCount: 7,
              ),
            ),
          panelBuilder: (controller) =>PanelWidget(controller: controller,),
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

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({
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
