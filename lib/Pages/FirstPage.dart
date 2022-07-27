import 'package:flutter/material.dart';

import '../Services/DataSet.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  CityModel? city;
  bool error = false;
  TextEditingController CityName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: CityName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Theme.of(context)
                        .drawerTheme
                        .backgroundColor,
                    filled: true,
                    hintText: "Введите название города"),
                textInputAction: TextInputAction.search,
              ),
              TextButton(
                  onPressed: () async{
                    city = await fetchCity(CityName.text).onError((e, stackTrace){
                      error = true;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Color(0xFFFFFFFF),
                              title: Text("Ошибка"),
                              content:
                              Text("Ошибка получения данных"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("ОК"))
                              ],
                            );
                          });
                    });
                    if(error == false){
                      if (city == null) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color(0xFFFFFFFF),
                                title: Text("Город не найден"),
                                content:
                                Text("Проверьте название города"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("ОК"))
                                ],
                              );
                            });
                        return;
                      }
                      else {Navigator.pushNamed(context, '/TwoPage', arguments: city);}
                    };
                    error = false;
                  },
                  child: Text("Подтвердить"))
            ],
          ) ,
        ));
  }
}
