import 'package:flutter/material.dart';
import 'package:friflexapp/Services/DataSet.dart';
import 'package:friflexapp/Widgets/ExtraWeather.dart';



Weather? currentTemp;
Weather? tomorrowTemp;
List<Weather>? todayWeather;
List<Weather>? sevenDay;

class TwoPage extends StatefulWidget {
  TwoPage({required this.cityList});
  Set<String> cityList;
  @override
  State<TwoPage> createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  Future<List<dynamic>> getData(CityModel city) async {
    return fetchData(city.lat, city.lon, city.name);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as CityModel;
    return SafeArea(
     child: Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.deepOrangeAccent,
         actions: [
           IconButton(
               onPressed: () {
                 Navigator.pushNamed(context, '/ThreePage', arguments: sevenDay);
               },
               icon: Icon(Icons.wysiwyg)),
         ],
       ),
       body: FutureBuilder<List<dynamic>>(
         future: getData(args),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             currentTemp = snapshot.data![0];
             todayWeather = snapshot.data![1];
             tomorrowTemp = snapshot.data![2];
             sevenDay = snapshot.data![3];
             if (widget.cityList.contains(args.name))
               Future.delayed(Duration.zero, () {
                 setState(() {
                   widget.cityList.add(args.name!);
                 });
               });
             return Container(
               child: CurrentWeather(
                 city: args,
               ),
             );
           }
           return Center(
             child: CircularProgressIndicator(),
           );
         },
       ),
     ),
    );
  }
}

class CurrentWeather extends StatefulWidget {
  CurrentWeather({required this.city});
  final CityModel city;

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " " + widget.city.name!,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentTemp!.current.toString() + "\u00B0C",
                  style: TextStyle(
                      color: Colors.black,
                      height: 1,
                      fontSize: 60,
                      fontWeight: FontWeight.bold),
                ),
                Image(
                  image: AssetImage(currentTemp!.image!),
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            Text(
              currentTemp!.day!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            ExtraWeather(currentTemp!),
          ],
        )
    );
  }
}

