import 'package:flutter/material.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/views/menu.dart';
import 'package:pandora_app/controllers/database.dart';

class TestPage extends StatelessWidget {
  Database db = new Database();

  void _updateSteps() {
    DateTime dt = new DateTime.now();
    int _testingSteps = 10;
    StepData sd = new StepData(db.user.userId, dt, _testingSteps);
    db.healt.updateStepCount(sd);
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
