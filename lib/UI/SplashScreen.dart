import 'package:flutter/material.dart';
import 'package:singleton/UI/Homepagenew.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (mounted) call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Text(
        "Horror Creepy Scary Stories!",
        style: TextStyle(
            color: Colors.white, fontSize: 18, decoration: TextDecoration.none),
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
