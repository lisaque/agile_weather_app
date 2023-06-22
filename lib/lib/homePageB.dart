import 'package:agile_weather_app/lib/datasetB.dart';
import 'package:agile_weather_app/lib/detailPageB.dart';
import 'package:agile_weather_app/lib/homePage.dart';
import 'package:agile_weather_app/lib/seven_daysB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:agile_weather_app/lib/extraWeatherB.dart';

WeatherB currentTemp;
WeatherB tomorrowTemp;
List<WeatherB> todayWeather;
List<WeatherB> sevenDay;
String lat = "52.5244";
String lon = "13.4105";
String city = "Berlin";

class HomePageB extends StatefulWidget {
  final String lat;
  final String lon;
  final String city;

  const HomePageB({Key key, this.lat, this.lon, this.city}) : super(key: key);

  @override
  _HomePageStateB createState() => _HomePageStateB();
}

class _HomePageStateB extends State<HomePageB> {
  getDataB() async {
    fetchDataB(lat, lon, city).then((value) {
      setState(() {
        currentTemp = value[0];
        todayWeather = value[1];
        tomorrowTemp = value[2];
        sevenDay = value[3];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: currentTemp == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: CurrentWeatherB(updateData: getDataB),
          ),
        ],
      ),
    );
  }
}

class CurrentWeatherB extends StatefulWidget {
  final Function() updateData;

  CurrentWeatherB({Key key, this.updateData}) : super(key: key);

  @override
  _CurrentWeatherStateB createState() => _CurrentWeatherStateB();
}

class _CurrentWeatherStateB extends State<CurrentWeatherB> {
  bool searchBar = false;
  bool updating = false;
  var focusNode = FocusNode();
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (searchBar)
            setState(() {
              searchBar = false;
            });
        },
        child: Container(
        margin: EdgeInsets.all(2),
    padding: EdgeInsets.only(top: 50, left: 30, right: 30),
    color: Colors.lightBlue,
    child: SingleChildScrollView(
    child: Column(
    children: [
    Container(
    child: searchBar
    ? TextField(
    controller: _searchController,
    focusNode: focusNode,
    decoration: InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    fillColor: Color(0xff030317),
    filled: true,
    hintText: "Enter a city Name",
    ),
    textInputAction: TextInputAction.search,
    onSubmitted: (value) async {
    CityModelB temp = await fetchCityB(value);
    if (temp == null) {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    backgroundColor: Color(0xff030317),
    title: Text("City not found"),
    content: Text("Please check the city name"),
    actions: [
    TextButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    child: Text("Ok"),
    )
    ],
    );
    },
    );
    searchBar = false;
    return;
    }
    city = temp.name;
    lat = temp.lat;
    lon = temp.lon;
    updating = true;
    setState(() {

    });
    widget.updateData();
    searchBar = false;
    updating = false;
    setState(() {

    });
    },
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
          child: Icon(
            CupertinoIcons.map_pin_ellipse,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Icon(CupertinoIcons.search, color: Colors.white),
            GestureDetector(
              onTap: () {
                setState(() {
                  searchBar = true;
                });
                focusNode.requestFocus();
              },
              child: Text(
                " " + city,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPageB(sevenDay)),
                );
              },
              child: Icon(
                CupertinoIcons.calendar_badge_plus,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
    ),

      Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(width: 0.2, color: Colors.white),
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          updating ? "Updating" : "Updated",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        height: 310,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Center(
                  child: Column(
                    children: [
                      GlowText(
                        currentTemp.current.toString(),
                        style: TextStyle(
                            height: 2,
                            fontSize: 66,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(currentTemp.name,
                          style: TextStyle(
                            fontSize: 16,
                            height: 5,

                          )),
                      Text(currentTemp.day,
                          style: TextStyle(
                            fontSize: 17,
                            height: 8,
                          ))
                    ],
                  )),
            )
          ],
        ),
      ),
      Divider(
        color: Colors.white,
      ),
      SizedBox(
        height: 10,
      ),
      ExtraWeather(currentTemp),
      Divider(
        color: Colors.white38,
      ),

      Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 14),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WeatherWidgetB(todayWeather[0]),
                      WeatherWidgetB(todayWeather[1]),
                      WeatherWidgetB(todayWeather[2]),
                      WeatherWidgetB(todayWeather[3]),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    ],

    ),
    ),
        ),
    );
  }
}