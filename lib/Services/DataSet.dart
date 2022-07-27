import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class Weather {
  final int? feelLike;
  final int? current;
  final String? name;
  final String? day;
  final int? wind;
  final int? humidity;
  final int? pressure;
  final String? image;
  final String? time;
  final String? location;

  Weather(
      {this.feelLike,
        this.name,
        this.day,
        this.wind,
        this.humidity,
        this.pressure,
        this.image,
        this.current,
        this.time,
        this.location});

  @override
  String toString() {
    return 'Weather{feelLike: $feelLike, current: $current, name: $name, day: $day, wind: $wind, humidity: $humidity, pressure: $pressure, image: $image, time: $time, location: $location}';
  }
}

String appId = "fe217bbfa078e82cf05ce08196642b9d";


Future<List> fetchData(String? lat, String? lon, String? city) async {
  var url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$appId";
  var response = await http.get(Uri.parse(url));
  DateTime date = DateTime.now();
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    //current
    var current = res["current"];
    var month = DateFormat("MMMM").format(date);
    var year = DateFormat("y").format(date);
    var day = DateFormat("d").format(date);
    switch (month) {
      case "January":
        month = "Января";
        break;
      case "February":
        month = "Февраля";
        break;
      case "March":
        month = "Марта";
        break;
      case "April":
        month = "Апреля";
        break;
      case "May":
        month = "Мая";
        break;
      case "June":
        month = "Июня";
        break;
      case "July":
        month = "Июля";
        break;
      case "August":
        month = "Августа";
        break;
      case "September":
        month = "Сентября";
        break;
      case "October":
        month = "Октября";
        break;
      case "November":
        month = "Ноября";
        break;
      case "December":
        month = "Декабря";
        break;
      default:
        month = month;
    }

    Weather currentTemp = Weather(
        current: current["temp"]?.round() ?? 0,
        name: current["weather"][0]["main"].toString(),
        day: day + " " + month + " " + year + " г.",
        feelLike: current["feels_like"]?.round() ?? 0,
        wind: current["wind_speed"]?.round() ?? 0,
        humidity: current["humidity"]?.round() ?? 0,
        pressure: current["pressure"]?.round() ?? 0,
        location: city,
        image: findIcon(current["weather"][0]["main"].toString(), true));

    //today
    List<Weather> todayWeather = [];
    int hour = int.parse(DateFormat("H").format(date));
    if (hour + 1 == 24) {
      hour = 0;
    }
    for (var i = 0; i < 4; i++) {
      var temp = res["hourly"];
      var hourly = Weather(
          current: temp[i]["temp"]?.round() ?? 0,
          image: findIcon(temp[i]["weather"][0]["main"].toString(), false),
          time: Duration(hours: hour + i + 1).toString().split(":")[0] + ":00");

      todayWeather.add(hourly);
    }

    //Tomorrow
    var daily = res["daily"][0];
    Weather tomorrowTemp = Weather(
        feelLike: daily["feels_like"]["day"]?.round() ?? 0,
        image: findIcon(daily["weather"][0]["main"].toString(), true),
        name: daily["weather"][0]["main"].toString(),
        wind: daily["wind_speed"]?.round() ?? 0,
        pressure: daily["pressure"]?.round() ?? 0);

    //Seven Day
    List<Weather> sevenDay = [];
    for (var i = 1; i < 4; i++) {
      String day = DateFormat('EEEE')
          .format(DateTime(date.year, date.month, date.day + i + 1))
          .substring(0, 3);

      switch (day) {
        case "Mon":
          day = "Пн";
          break;
        case "Tue":
          day = "Вт";
          break;
        case "Wed":
          day = "Ср";
          break;
        case "Thu":
          day = "Чт";
          break;
        case "Fri":
          day = "Пт";
          break;
        case "Sat":
          day = "Сб";
          break;
        case "Sun":
          day = "Вс";
          break;
        default:
          day = day;
      }
      var temp = res["daily"][i];
      var hourly = Weather(
          feelLike: temp["temp"]["day"]?.round() ?? 0,
          wind: temp["wind_speed"]?.round() ?? 0,
          humidity: temp["humidity"] ?? 0,
          pressure: temp["pressure"]?.round() ?? 0,
          image: findIcon(temp["weather"][0]["main"].toString(), false),
          name: temp["weather"][0]["main"].toString(),
          day: day);
      sevenDay.add(hourly);
    }
    return [currentTemp, todayWeather, tomorrowTemp, sevenDay];
  }
  return [null, null, null, null];
}


String findIcon(String name, bool type) {
  if (type) {
    switch (name) {
      case "Clouds":
        return "assets/images/sunny.png";
      case "Rain":
        return "assets/images/rainy.png";
      case "Drizzle":
        return "assets/images/rainy.png";
      case "Thunderstorm":
        return "assets/images/thunder.png";
      case "Snow":
        return "assets/images/snow.png";
      default:
        return "assets/images/sunny.png";
    }
  } else {
    switch (name) {
      case "Clouds":
        return "assets/images/sunny_2d.png";
      case "Rain":
        return "assets/images/rainy_2d.png";
      case "Drizzle":
        return "assets/images/rainy_2d.png";
      case "Thunderstorm":
        return "assets/images/thunder_2d.png";
      case "Snow":
        return "assets/images/snow_2d.png";
      default:
        return "assets/images/sunny_2d.png";
    }
  }
}

class CityModel {
  final String? name;
  final String? lat;
  final String? lon;
  CityModel({this.name, this.lat, this.lon});

  @override
  String toString() {
    return 'CityModel{name: $name, lat: $lat, lon: $lon}';
  }
}

// ignore: prefer_typing_uninitialized_variables
var cityJSON;

Future<CityModel?> fetchCity(String cityName) async {
  String link =
      "http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=5&units=metric&appid=$appId";
  var response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    cityJSON = json.decode(response.body);
  }

  for (var i = 0; i < cityJSON.length; i++) {
    if (cityJSON[i]["local_names"]["ru"].toString().toLowerCase() ==
        cityName.toLowerCase()) {
      return CityModel(
          name: cityJSON[i]["local_names"]["ru"].toString(),
          lat: cityJSON[i]["lat"].toString(),
          lon: cityJSON[i]["lon"].toString());
    }
  }
  return null;
}





