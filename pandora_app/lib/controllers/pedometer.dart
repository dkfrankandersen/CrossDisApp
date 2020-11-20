import 'package:flutter/material.dart';
import 'package:pandora_app/models/step_data.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:pandora_app/views/menu.dart';
import 'package:pandora_app/controllers/database.dart';
import 'package:workmanager/workmanager.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class StepPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<StepPage> {
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  String _lastStepsSaved = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  void saveUserStepsToDB() {
    if (int.tryParse(_steps) != null &&
        _lastStepsSaved != _steps &&
        _status == 'stopped') {
      StepData sd = new StepData(appDB.user.userId, new DateTime.now(), _steps);
      sd.setId(appDB.healt.saveStepCount(sd));
      _lastStepsSaved = _steps;
      print("Saved stepcount, db key: " + sd.getDBIdKey().toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
      home: Scaffold(
        appBar: AppBar(
          title: MenuTextFormat.getAppBarTitleText('My profile'),
        ),
        drawer: MainMenuDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'User: ' + appDB.user.userId,
                style: TextStyle(fontSize: 40),
              ),
              Text(
                'Steps taken:',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                _steps,
                style: TextStyle(fontSize: 60),
              ),
              FlatButton(
                textColor: Color(0xFF6200EE),
                onPressed: () {
                  // Respond to button press
                  saveUserStepsToDB();
                },
                child: Text("SAVE STEP COUNT"),
              ),
              Divider(
                height: 100,
                thickness: 0,
                color: Colors.white,
              ),
              Text(
                'Pedestrian status:',
                style: TextStyle(fontSize: 30),
              ),
              Icon(
                _status == 'walking'
                    ? Icons.directions_walk
                    : _status == 'stopped'
                        ? Icons.accessibility_new
                        : Icons.error,
                size: 100,
              ),
              Center(
                child: Text(
                  _status,
                  style: _status == 'walking' || _status == 'stopped'
                      ? TextStyle(fontSize: 30)
                      : TextStyle(fontSize: 20, color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
