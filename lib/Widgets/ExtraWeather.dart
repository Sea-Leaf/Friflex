import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Services/DataSet.dart';

class ExtraWeather extends StatelessWidget {
  final Weather temp;
  ExtraWeather(this.temp);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 80,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              border: Border.all(width: 0.6, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            children: [
              SizedBox(
                height: 23,
              ),
              Icon(
                CupertinoIcons.thermometer,
                size: 25,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                temp.feelLike.toString() + "\u00B0C",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          height: 120,
          width: 80,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              border: Border.all(width: 0.6, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Icon(
                CupertinoIcons.wind,
                size: 25,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                temp.wind.toString() + " Км/ч",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          height: 120,
          width: 80,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              border: Border.all(width: 0.6, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Icon(
                CupertinoIcons.drop,
                size: 25,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                temp.humidity.toString() + " %",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          height: 120,
          width: 80,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              border: Border.all(width: 0.6, color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Icon(
                CupertinoIcons.speedometer,
                size: 25,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                temp.pressure.toString(),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Text(
                "мм",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ],
          ),
        )
      ],
    );
  }
}
