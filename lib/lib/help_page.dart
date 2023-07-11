import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 30, left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BOSS WEATHER - help & instructions",
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "*All temperatures are written in units of Celsius.",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "*To navigate to your weather location, press on the location icon on the top left of the home screen",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "*To search for another City's weather and to view the forecasts, "
                        "press on the search icon on the top of the home screen and input the city name.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "*To view the weather forecast for the next 7 days, click on the " +
                        "calendar icon located on the top right of the home screen.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "-For any further inquiries or feedback, contact us below:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                   GestureDetector(
                    onTap: () {
                      const url = 'https://nyagajr.github.io/weather_app/contact2.html'; // Replace with your desired web URL
                      launch(url);
                    },
                    child: Icon(
                      Icons.question_answer,
                      color: Colors.white,

                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),

                  Divider(
                    color: Colors.white60,
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Think Campus, Konrad-Zuse-Ring 11, 14469 Potsdam",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white60,
                      height: 1.5,
                    ),
                  ),

                ],
              ),
              ),
            ),
          ),
        );
      },
    );
  }
}
