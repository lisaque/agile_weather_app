import 'detailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agile_weather_app/lib/dataset.dart';


Weather currentTemp;
Weather tomorrowTemp;
List<Weather> todayWeather;
List<Weather> sevenDay;

class TodayWeather extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(left: 30, right: 30, top: 10),
    child: Column(
    children: [
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    "Today",
    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    GestureDetector(
    onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (BuildContext context) {
    return DetailPage(sevenDay);
    }));
    },
    child: Row(
    children: [
    Text(
    "7 days ",
    style: TextStyle(fontSize: 18, color: Colors.black),
    ),
    Icon(
    Icons.arrow_forward_ios_outlined,
    color: Colors.black,
    size: 15,
    )
    ],
    ),
    )
    ],
    ),
    SizedBox(
    height: 15,
    ),
    Container(
    margin: EdgeInsets.only(
    bottom: 30,
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    WeatherWidget(todayWeather[0]),
    WeatherWidget(todayWeather[1]),
    WeatherWidget(todayWeather[2]),
    WeatherWidget(todayWeather[3])
    ]),
    )
    ],
    ),
    );
    }
    }

    class WeatherWidget extends StatelessWidget {
    final Weather weather;
    WeatherWidget(this.weather);
    @override
    Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: Colors.white),
            borderRadius: BorderRadius.circular(35)),
    child: Column(
    children: [
    Text(
    weather.current.toString() + "\u00B0",
    style: TextStyle(fontSize: 20),
    ),
    SizedBox(
    height: 5,
    ),
    Image(
    image: AssetImage(weather.image),
    width: 50,
    height: 50,
    ),
    SizedBox(
    height: 5,
    ),
    Text(
    weather.time,
    style: TextStyle(fontSize: 16, color: Colors.black),
    )
    ],
    ),
    );
    }
    }