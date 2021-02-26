import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:singleton/UI/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'BlackRose',
          textTheme: TextTheme(
              caption: TextStyle(color: Color.fromRGBO(155, 164, 200, 1)))),
      home: SplashScreen(),
    );
  }
}
