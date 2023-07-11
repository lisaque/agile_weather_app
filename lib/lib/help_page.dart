import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

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
                    "-For any further inquiries please contact the email addresses listed below:",
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
              "amal.moallahyiddi@ue-germany.de",
            style: TextStyle(
            fontSize: 16,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
          ),
                  Text(
                    "cherry.garcia@ue-germany.de",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "valeriaebere.oguguo@ue-germany.de",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),

                  Text(
                    "sadiya.mohammed@ue-germany.de",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "lincoln.isaque@ue-germany.de",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),

                  Text(
                    "chinecherem.okolionumazi@ue-germany.de",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "abubakar.umar@ue-germany.de",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "abubakar.garba@ue-germany.de",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "bensonmuchoki.nyaga@ue-germany.de",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    "dailin.sun@ue-germany.de",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24),
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
