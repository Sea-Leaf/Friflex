import 'package:flutter/material.dart';
import 'package:friflexapp/Pages/ThreePage.dart';
import 'package:friflexapp/Pages/TwoPage.dart';

import 'Pages/FirstPage.dart';
import 'Services/DataSet.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(WeatherApp());
}


class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);


  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Set<String> cityList = {};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/TwoPage': (context) => TwoPage(cityList: cityList),
        '/ThreePage': (context) => ThreePage(),
      },
    );
  }
}
