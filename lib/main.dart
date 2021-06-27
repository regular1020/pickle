import 'package:flutter/material.dart';
import 'package:pickle/src/home.dart';
import 'package:pickle/src/provider/post_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pickle',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.grey,
      ),
      home: ChangeNotifierProvider<PostProvider>(
        child: Home(),
        create: (context) => PostProvider(),
      )
    );
  }
}
