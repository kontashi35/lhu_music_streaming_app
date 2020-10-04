import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:lhu/page/home_page.dart';
import 'package:lhu/shared/color_page.dart';
import 'package:lhu/widget/bottom_navigation.dart';
import 'package:lhu/widget/progressbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(

      ),
      home: Scaffold(
          body: BottomNavigationPage()
      ),
    );
  }
}

