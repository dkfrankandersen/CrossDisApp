import 'package:flutter/material.dart';
import 'package:pandora_app/controllers/chartbarsStepData.dart';
import 'package:pandora_app/controllers/database.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/views/menu.dart';
import 'package:pandora_app/controllers/chartpointsdemo.dart';

class StatisticsPage extends StatelessWidget {
  Database db = new Database();
  @override
  Widget build(BuildContext context) {
    print("StatisticsPage loading");
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
                    // Expanded(child: new TimeSeriesBar.withSampleData()),
                    FutureBuilder<List<StepData>>(
                      future: db
                          .healt
                          .getStepDataPrDay(new DateTime.now()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Expanded(
                              child: new StepDataBar(
                                  StepDataBar.createTimeSeries(snapshot.data)));
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    Divider(color: Colors.black),
                    // Text("Puls", style: TextStyle(fontSize: 24)),
                    // Expanded(child: new PointsLineChart.withSampleData()),
                    // Divider(color: Colors.black),
                    // Text("Distance", style: TextStyle(fontSize: 24)),
                    // Expanded(child: new PointsLineChart.withSampleData()),
                    // Divider(color: Colors.black),
                  ],
                ))));
  }
}
