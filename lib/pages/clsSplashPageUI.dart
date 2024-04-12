// ignore_for_file: file_names, camel_case_types, prefer_const_constructors

import 'dart:async';
import 'package:ecommerce/pages/clsHomePageUI.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class clsSplashPageUI extends StatefulWidget {
  const clsSplashPageUI({Key? key}) : super(key: key);

  @override
  State<clsSplashPageUI> createState() => _clsSplashPageUIState();
}

class _clsSplashPageUIState extends State<clsSplashPageUI> {
  @override
  void initState() {
    // Go to Page2 after 5s.
    Timer(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => clsHomePageUI()),
          (Route<dynamic> route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      body: Container(
        color: Color(0XFFfe7d08),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          "assets/images/Splash.jpeg",
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
