import 'package:flutter/material.dart';
import 'package:pandora_app/menu.dart';
import 'package:pandora_app/chartbarsdemo.dart';
import 'package:pandora_app/chartpointsdemo.dart';
import 'package:pandora_app/database.dart';



class StatisticsPage extends StatelessWidget {
  List<StepData> stepDataLst = [];

  // void sdsds() {
  //     getAllStepCount().then(stepDataLst) => {
  //       this.setState(() {
  //           this.stepDataLst = stepDataLst;
  //       })
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    getAllStepCount();
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar: AppBar(
                title: MenuTextFormat.getAppBarTitleText('My Statistics')),
            drawer: MainMenuDrawer(),
            body: Container(
                height: 750,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text('Enjoy all your data at one place!',
                        style: TextStyle(fontSize: 26)),
                    Divider(color: Colors.black),
                    Text('Steps', style: TextStyle(fontSize: 24)),
                    Expanded(child: new TimeSeriesBar.withSampleData()),
                    Divider(color: Colors.black),
                    Text("Puls", style: TextStyle(fontSize: 24)),
                    Expanded(child: new PointsLineChart.withSampleData()),
                    Divider(color: Colors.black),
                    Text("Distance", style: TextStyle(fontSize: 24)),
                    Expanded(child: new PointsLineChart.withSampleData()),
                    Divider(color: Colors.black),
                  ],
                ))));
  }
}
