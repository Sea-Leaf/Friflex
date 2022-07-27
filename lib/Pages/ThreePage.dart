import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Services/DataSet.dart';


class ThreePage extends StatefulWidget {

  @override
  State<ThreePage> createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<Weather>;
    return SafeArea(child:   Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        children: [
          SevenDays(args),
        ],
      ),
    ));
  }
}

class SevenDays extends StatelessWidget {
  final List<Weather> sevenDay;
  SevenDays(this.sevenDay);
  @override
  Widget build(BuildContext context) {
    sevenDay.sort((a,b)=> a.feelLike!.compareTo(b.feelLike!));
    return Expanded(
      child: ListView.builder(
          itemCount: sevenDay.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 25, top: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              sevenDay[index].day!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.thermometer,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  sevenDay[index].feelLike.toString() +
                                      "\u00B0",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(
                                  CupertinoIcons.wind,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  sevenDay[index].wind.toString() + " Км/ч",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  CupertinoIcons.drop,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  sevenDay[index].humidity.toString() + " %",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  CupertinoIcons.speedometer,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  sevenDay[index].pressure.toString() + " мм",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                image: AssetImage(sevenDay[index].image!),
                                width: 50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
