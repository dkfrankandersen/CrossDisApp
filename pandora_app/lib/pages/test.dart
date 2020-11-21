import 'package:flutter/material.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/views/menu.dart';
import 'package:pandora_app/controllers/database.dart';

class TestPage extends StatelessWidget {
  int _testingSteps = 0;
  Database db = new Database();

  void _updateSteps() {
    DateTime dt = new DateTime.now();
    _testingSteps = _testingSteps + dt.second;
    StepData sd = new StepData(db.user.userId, dt, _testingSteps.toString());
    db.healt.saveStepCount(sd);
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
                _updateSteps();
              },
              child: Text(
                "Flat Button",
              ),
            ))));
  }
}
