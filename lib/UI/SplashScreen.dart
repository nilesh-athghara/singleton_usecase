import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:singleton/UI/Homepagenew.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    if (mounted) {
      call();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Text(
        " Horror Creepy Scary Stories",
        style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'StrangerCreature',
            decoration: TextDecoration.none),
      ),
    );
  }

  call() async {
    Future.delayed((Duration(seconds: 5))).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (buildContext) => HomePageNew()));
    });
  }
}
