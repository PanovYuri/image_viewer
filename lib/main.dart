import 'package:flutter/material.dart';
import 'image_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App for view Image",
      home: ImageList(),
    );
  }
}