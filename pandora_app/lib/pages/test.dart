import 'package:flutter/material.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/views/menu.dart';
import 'package:pandora_app/controllers/database.dart';

class TestPage extends StatelessWidget {
  Database db = Database.instance();

  void _updateSteps() {
    DateTime dt = new DateTime.now();
    int _testingSteps = 10;
    StepData sd = new StepData(db.user.userId, dt, _testingSteps);
    db.healt.updateStepCount(sd);
  }

  int _minutInterVal(int minVal) {
    if (minVal >= 45 && minVal <= 60) {
      return 45;
    } else if (minVal >= 30) {
      return 30;
    } else if (minVal >= 15) {
      return 15;
    } else if (minVal >= 0) {
      return 0;
    } else {
      throw new FormatException('Wrong format, minut interval should be 0..60');
    }
  }

  void _createDemoData() {
    List<String> stepData = [
      "25 08 11",
      "694 9 16",
      "1172 10 14",
      "1068 10 37",
      "548 10 53",
      "11 10 53",
      "19 10 53",
      "263 10 57",
      "29 15 27",
      "20 18 04",
      "209 18 08",
      "83 18 22",
      "55 18 45",
      "466 22 43",
      "1017 22 53",
      "163 22 55",
      "196 23 18",
      "436 23 44",
      "19 23 44",
    ];
    Map<int, Map<int, List<int>>> mapData = {};
    for (String data in stepData) {
      print(data);
      List<String> lst = data.split(" ");
      List<int> ints = lst.map(int.parse).toList();
      int s = ints[0];
      int h = ints[1];
      int m = ints[2];
      int mi = _minutInterVal(m);
      mapData.putIfAbsent(
          h,
          () => {
                mi: [m, s]
              });

      if (mapData.containsKey(h)) {
        print("Found h: ${h}");
        if (mapData[h].containsKey(mi)) {
          print("Found mi: ${mi} s: ${s}");
          s = s + mapData[h][mi][1];
          print("New s: ${s}");
          mapData[h][mi] = [m, s];
        }
      }
    }
    print(mapData);
    for (var h = 0; h < 24; h++) {
      for (var mi = 0; mi < 60; mi += 15) {
        int m = mi;
        int s = 0;
        if (mapData.containsKey(h)) {
          if (mapData[h].containsKey(mi)) {
            m = mapData[h][mi][0];
            s = mapData[h][mi][1];
            DateTime dt = DateTime(2020, 12, 03, h, m, 0, 0);
            StepData sd = new StepData(db.user.userId, dt, s);
            db.healt.updateStepCount(sd);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar:
                AppBar(title: MenuTextFormat.getAppBarTitleText('Testpage')),
            drawer: MainMenuDrawer(),
            body: Center(
                child: FlatButton(
              onPressed: () {
                _createDemoData();
              },
              child: Text(
                "Create Demo Data",
              ),
            ))));
  }
}
