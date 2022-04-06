import 'package:flutter/material.dart';
import 'imageCropperPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageCropper',
      theme: ThemeData.light().copyWith(primaryColor: Colors.deepOrange),
      home: CropperPage(),
    );
  }
}
