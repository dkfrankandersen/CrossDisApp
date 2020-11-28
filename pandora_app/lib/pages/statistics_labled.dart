import 'package:flutter/material.dart';
import 'package:pandora_app/controllers/chartbarsStepData.dart';
import 'package:pandora_app/controllers/database.dart';
import 'package:pandora_app/models/label.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/views/menu.dart';

class StatisticsLabledPage extends StatefulWidget {
  @override
  _MyStatisticsPage createState() => _MyStatisticsPage();
}

class _MyStatisticsPage extends State<StatisticsLabledPage> {
  Database db = Database.instance();
  List<StepData> lst = [];
  List<Widget> labelWidgets = [];

  _MyStatisticsPage();

  List<Widget> labelWidgetsList(List<StepData> lst) {
    List<Widget> labelWidgets = [];
    for (StepData sd in lst) {
      Label label = new Label(sd.datetime, sd.steps);
      int s = sd.steps;
      if (s == 0) {
        label.description = 'Nothing going on here';
      } else if (s > 0 && s <= 30) {
        label.description = 'slow moment';
      } else if (s > 30 && s <= 200) {
        label.description = 'At least your are moving';
      } else if (s > 200 && s <= 500) {
        label.description = 'Hop Hop';
      } else if (s > 500 && s <= 1000) {
        label.description = 'Going fast there!';
      } else if (s > 1000) {
        label.description = 'Holy shit superman';
      }
      labelWidgets.add(new LabelWidget(label));
    }
    print("labelWidgets ${labelWidgets.length}");
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
                          labelWidgets = labelWidgetsList(snapshot.data);
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
                    Divider(color: Colors.black),
                    Text('Your labels', style: TextStyle(fontSize: 26)),
                    Column(
                      children: labelWidgets,
                    ),
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
            child: Text('DateTime: ' + label.getDateTime().toString())),
        Align(
            alignment: Alignment.topLeft,
            child: Text('Steps: ' + label.getSteps().toString())),
        Align(
            alignment: Alignment.topLeft,
            child: Text('Description: ' + label.description)),
      ]),
    );
  }
}
