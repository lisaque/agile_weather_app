import 'package:agile_weather_app/lib/homePageB.dart';
import 'package:flutter/material.dart';
import 'package:agile_weather_app/lib/homePage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boss Weather',
      theme: ThemeData(
          textTheme: Theme.of(context)
              .textTheme
              .apply(bodyColor: Colors.white, displayColor: Colors.blue)),
      debugShowCheckedModeBanner: false,
      home: HomePageB(),
    );
  }
}
