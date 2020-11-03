import 'package:flutter/material.dart';
import 'package:pandora_app/menu.dart';
import 'package:pandora_app/chartbarsdemo.dart';
import 'package:pandora_app/chartpointsdemo.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar: AppBar(title: Text('My Statistics')),
            drawer: MainMenuDrawer(),
            body: Container(
                height: 400,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text('Steps'),
                    Expanded(child: new TimeSeriesBar.withSampleData()),
                    Text("Puls"),
                    Expanded(child: new PointsLineChart.withSampleData())
                  ],
                ))));
  }
}
