import 'package:flutter/material.dart';
import 'package:pandora_app/models/basedevice.dart';
import 'package:pandora_app/models/step_data.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:pandora_app/views/menu.dart';
import 'package:pandora_app/controllers/database.dart';

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
  String _last = '?';
  List<String> _stepUpdated = [];
  Database db = Database.instance();
  BaseDevice baseDevice;

  _MyAppState() {
    List<BaseDevice> baseDevices = db.items.getBaseDevices();
    if (baseDevices.isNotEmpty) {
      this.baseDevice = baseDevices[0];
    }
  }

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
      if (_status == 'walking') {
        _last = _steps;
      }
      if (_status == 'stopped') {
        _updateSteps(_steps, _last);
      }
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

  void _updateSteps(String steps, String last) {
    int s = int.tryParse(steps);
    int l = int.tryParse(last);
    if (s == null) {
      _stepUpdated.add('s(${steps})');
    } else if (l == null) {
      _stepUpdated.add('l${last})');
    } else {
      DateTime dt = new DateTime.now();
      StepData sd = new StepData(db.user.userId, dt, (s - l));
      db.healt.updateStepCount(sd);
      _stepUpdated.add('OK(${(s - l).toString()})');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
      home: Scaffold(
        appBar: AppBar(
          title: MenuTextFormat.getAppBarTitleText('Steps'),
        ),
        drawer: MainMenuDrawer(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              baseDevice.getImage(),
              Divider(color: Colors.black),
              Text(
                'User: ' + db.user.userId,
                style: TextStyle(fontSize: 32),
              ),
              Text(
                'Total Steps Taken:',
                style: TextStyle(fontSize: 32),
              ),
              Text(
                _steps,
                style: TextStyle(fontSize: 40),
              ),
              Divider(
                height: 30,
                thickness: 0,
                color: Colors.white,
              ),
              Text(
                'Pedestrian status:',
                style: TextStyle(fontSize: 32),
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
              ),
              Center(
                child: Text(
                  _stepUpdated.toString(),
                  style: _stepUpdated.isNotEmpty
                      ? TextStyle(fontSize: 30)
                      : TextStyle(fontSize: 20, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
