import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pickle"),
        backgroundColor: Colors.white,
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
      ),
      body: Container(),
    );
  }
}
