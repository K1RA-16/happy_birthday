import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_birthday/startingScreen.dart';
import 'package:happy_birthday/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyThemes.lightTheme(context),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => startingScreen(),
      },
    );
  }
}
