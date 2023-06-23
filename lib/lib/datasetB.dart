import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherB {
  final int max;
  final int min;
  final int current;
  final String name;
  final String day;
  final int wind;
  final int humidity;
  final int chanceRain;
  final String image;
  final String time;
  final String location;
  final String city;

  WeatherB(
      {this.max,
        this.min,
        this.name,
        this.day,
        this.wind,
        this.humidity,
        this.chanceRain,
        this.image,
        this.current,
        this.time,
        this.location,
        this.city});
}

//from http://openweathermap.org
//https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$appId
//https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json



Future<List> fetchDataB(String lat,String lon,String city) async{
  var url = "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=57ef44ab48d72208ac00792eb55b8cee";
  var response = await http.get(Uri.parse(url));
  DateTime date = DateTime.now();
  if(response.statusCode==200){
    var res = json.decode(response.body);
    //current Temp
    var current = res["current"];
    WeatherB currentTempB = WeatherB(
        current: current["temp"]?.round()??3,
        name: current["weather"][0]["main"].toString(),
        day: DateFormat("EEEE dd MMMM").format(date),
        wind: current["wind_speed"]?.round()??3,
        humidity: current["humidity"]?.round()??3,
        chanceRain: current["uvi"]?.round()??3,
        location: city,
        image: findIconB(current["weather"][0]["main"].toString(), true)
    );

    //today weather
    List<WeatherB> todayWeatherB = [];
    int hour = int.parse(DateFormat("hh").format(date));
    for (var i = 0; i < 4; i++) {
      var temp = res["hourly"];
      var hourly = WeatherB(
        current: temp[i]["temp"]?.round() ?? 3,
        image: findIconB(temp[i]["weather"][0]["main"].toString(), false),
        time: DateFormat("hh:00 a").format(date.add(Duration(hours: hour + i + 1))),
      );
      todayWeatherB.add(hourly);
    }


    //Tomorrow Weather
    var daily = res["daily"][0];
    WeatherB tomorrowTempB = WeatherB(
        max: daily["temp"]["max"]?.round()??0,
        min:daily["temp"]["min"]?.round()??0,
        image: findIconB(daily["weather"][0]["main"].toString(), true),
        name:daily["weather"][0]["main"].toString(),
        wind: daily["wind_speed"]?.round()??0,
        humidity: daily["rain"]?.round()??0,
        chanceRain: daily["uvi"]?.round()??0
    );

    //Seven Day Weather
    List<WeatherB> sevenDayB = [];
    for(var i=0;i<7;i++){
      String day = DateFormat("EEEE").format(DateTime(date.year,date.month,date.day+i+1)).substring(0,3);
      var temp = res["daily"][i];
      var hourly = WeatherB(
          max:temp["temp"]["max"]?.round()??5,
          min:temp["temp"]["min"]?.round()??5,
          image:findIconB(temp["weather"][0]["main"].toString(), false),
          name:temp["weather"][0]["main"].toString(),
          day: day
      );
      sevenDayB.add(hourly);
    }
    return [currentTempB,todayWeatherB,tomorrowTempB,sevenDayB];
  }
  return [null,null,null,null];
}

//findIcon
String findIconB(String name,bool type){
  if(type){
    switch(name){
      case "Clouds":
        return "assets/sunny.png";
        break;
      case "Rain":
        return "assets/rainy.png";
        break;
      case "Drizzle":
        return "assets/rainy.png";
        break;
      case "Thunderstorm":
        return "assets/thunder.png";
        break;
      case "Snow":
        return "assets/snow.png";
        break;
      default:
        return "assets/sunny.png";
    }
  }else{
    switch(name){
      case "Clouds":
        return "assets/sunny_2d.png";
        break;
      case "Rain":
        return "assets/rainy_2d.png";
        break;
      case "Drizzle":
        return "assets/rainy_2d.png";
        break;
      case "Thunderstorm":
        return "assets/thunder_2d.png";
        break;
      case "Snow":
        return "assets/snow_2d.png";
        break;
      default:
        return "assets/sunny_2d.png";
    }
  }
}

class CityModelB{
  final String name;
  final String lat;
  final String lon;
  CityModelB({this.name,this.lat,this.lon});
}

var cityJSON;

Future<CityModelB> fetchCityB(String cityName) async{
  if(cityJSON==null){
    String link = "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json";
    var response = await http.get(Uri.parse(link));
    if(response.statusCode==200){
      cityJSON = json.decode(response.body);
    }
  }
  for(var i=0;i<cityJSON.length;i++){
    if(cityJSON[i]["name"].toString().toLowerCase() == cityName.toLowerCase()){
      return CityModelB(
          name:cityJSON[i]["name"].toString(),
          lat: cityJSON[i]["latitude"].toString(),
          lon: cityJSON[i]["longitude"].toString()
      );
    }
  }
  return null;
}
