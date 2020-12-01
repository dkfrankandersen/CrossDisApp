import 'package:flutter/material.dart';
import 'package:pandora_app/controllers/chartbarsStepData.dart';
import 'package:pandora_app/controllers/database.dart';
import 'package:pandora_app/models/label.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/views/menu.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _MyStatisticsPage createState() => _MyStatisticsPage();
}

class _MyStatisticsPage extends State<StatisticsPage> {
  Database db = Database.instance();

  List<Widget> labelWidgetsList() {
    List<Widget> labelWidgets = [];
    for (Label label in db.healt.labels) {
      labelWidgets.add(new LabelWidget(label));
    }
    return labelWidgets;
  }

  @override
  void initState() {
    super.initState();
  }

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
                    Text('Steps Yesterday', style: TextStyle(fontSize: 24)),
                    FutureBuilder<List<StepData>>(
                      future: db.healt.getStepDataPerDay(new DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              0,
                              0,
                              0,
                              0)
                          .subtract(Duration(days: 1))),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          StepDataBar sdb = new StepDataBar(
                              StepDataBar.createTimeSeries(snapshot.data));
                          return Expanded(
                            child: sdb,
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    Text('Click on bar to create event'),
                    Divider(color: Colors.black),
                    Text('Your labels', style: TextStyle(fontSize: 26)),
                    Column(
                      children: labelWidgetsList(),
                    )
                  ],
                ))));
  }
}

class LabelWidget extends StatelessWidget {
  final Label label;

  LabelWidget(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Column(children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
                'DateTime: ' + label.getDateTime().toString().substring(0, 16),
                style: TextStyle(fontSize: 18))),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Steps: ' + label.getSteps().toString(),
              style: TextStyle(fontSize: 18),
            )),
        Align(
            alignment: Alignment.topLeft,
            child: Text('Description: ' + label.description,
                style: TextStyle(fontSize: 14))),
      ]),
    );
  }
}
