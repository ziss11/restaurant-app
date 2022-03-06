import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/main_page.dart';
import 'package:restaurant_app/common/style.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainPage.routeName,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'images/splash_img.png',
            height: 200,
          ),
        ),
      ),
    );
  }
}
