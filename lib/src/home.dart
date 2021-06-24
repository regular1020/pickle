import 'package:flutter/material.dart';
import 'package:pickle/src/data.dart';

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

  Widget _makePickPeople(int index){
    if (datas[index]["picks"].length > 0){
      return Text(datas[index]["picks"][0] + "님 외 " + (datas[index]["picks"].length-1).toString() + "명");
    }else{
      return Text("아직 아무도 참여하지 않았습니다");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, int index){
                    return GestureDetector(
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                child: Image.asset(datas[index]["icon"], height: 50, width: 50,),
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(datas[index]["writer"], style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),),
                                        Text(datas[index]["status"], style: TextStyle(color: Colors.indigo, fontSize: 10),)
                                      ],
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    children: makeImageList(index),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(datas[index]["text"], style: TextStyle(color: Colors.indigo),),
                                ),
                                _makePickPeople(index),
                              ],
                            )
                          ],
                        ),
                      ),
                      onTap: (){

                        },
                    );
                    },
                  separatorBuilder: (context, index){
                    return Divider(height: 10,);
                    },
                  itemCount: datas.length,
                ),
              ),
            ],
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.2,
          maxChildSize: 0.9,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
                controller: scrollController,
                child: Card(
                  elevation: 12.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  margin: const EdgeInsets.all(0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: ResultList()
                  ),
                )
            );
          }
        ),
      ],
    );
  }
}

class ResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Center(
            child: Container(
              height: 5,
              width: 20,
              color: Colors.grey,
            ),
          )
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text("결과 보기", style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),)
        ),
        Container(
          height: MediaQuery.of(context).size.height*0.90,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Text("Item $index",),
                color: Colors.blue,
              );
            },
          )
        ),
      ],
    );
  }
}


// class SlidePanelWidget extends StatelessWidget {
//   final ScrollController controller;
//   final PanelController panelController;
//
//   const SlidePanelWidget({
//     Key? key,
//     required this.panelController,
//     required this.controller,
//   }) : super(key: key);
//
//   // Widget _makeResultList(){
//   //   return
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.all(Radius.circular(20)),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           SizedBox(height: 15,),
//           Center(
//             child: Container(
//               width : 30,
//               height : 5,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           Text(
//             "결과보기",
//             style: TextStyle(
//               color: Colors.blue,
//               fontSize: 20,
//             ),
//             textAlign: TextAlign.start,
//           ),
//           Expanded(
//             child: GridView.builder(
//              itemBuilder: (context, int index){
//                return GestureDetector(
//                  child: Container(
//                    height: 200,
//                    width: 200,
//                    color: Colors.blue,
//                  ),
//                );
//              },
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemCount: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
