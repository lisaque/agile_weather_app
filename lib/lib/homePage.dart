import 'package:agile_weather_app/lib/datasetB.dart';
import 'package:agile_weather_app/lib/help_page.dart';
import 'package:agile_weather_app/lib/homePageB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:agile_weather_app/lib/dataset.dart';
import 'package:agile_weather_app/lib/detailPage.dart';
import 'package:agile_weather_app/lib/extraWeather.dart';
import 'package:agile_weather_app/lib/seven_days.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

Weather currentTemp;
Weather tomorrowTemp;
List<Weather> todayWeather;
List<Weather> sevenDay;
String lat = "";
String lon = "";
String city = "";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getData() async {
    fetchData().then((value) {
      currentTemp = value[0];
      todayWeather = value[1];
      tomorrowTemp = value[2];
      sevenDay = value[3];
      setState(() {});
    });
  }

  updateWeatherData(String cityName) async {
    CityModel temp = await fetchCity(cityName);
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
      return;
    }
    setState(() {
      city = temp.name;
      lat = temp.lat;
      lon = temp.lon;
      getData();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
//Loading Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: currentTemp == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: CurrentWeather(getData, updateWeatherData),
          ),
        ],
      ),
    );
  }
}

class CurrentWeather extends StatefulWidget {
  final Function getData;
  final Function(String) updateWeatherData;

  CurrentWeather(this.getData, this.updateWeatherData);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  bool searchBar = false;
  bool updating = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchBar) {
          setState(() {
            searchBar = false;
          });
        }
      },
      child: Container(
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        color: Colors.indigoAccent,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: searchBar
                    ? TextField(
                  focusNode: focusNode,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Color(0xff030317),
                      filled: true,
                      hintText: "Enter a city Name"),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) => widget.updateWeatherData(value),
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                HomePage(),
                          ),
                          );
                               },
                  child:
                    Icon(
                        CupertinoIcons.map_pin_ellipse,
                        color: Colors.white),

                      ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  HomePageB(),
                            ),
                            );
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
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
                                builder: (context) =>
                                    DetailPage(sevenDay),
                              ),
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
                                )),
                          ],
                        ),
                      ),
                    ),
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
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Help()),
                      );
                    },
                    child: Icon(
                      Icons.help_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 14),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  WeatherWidget(todayWeather[0]),
                                  WeatherWidget(todayWeather[1]),
                                  WeatherWidget(todayWeather[2]),
                                  WeatherWidget(todayWeather[3]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
