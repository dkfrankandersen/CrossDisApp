import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/models/user.dart';
import 'package:intl/intl.dart';

class HealtDatabase {
  DatabaseReference _dbRef;
  User _user;
  String _userId;
  String _refUserSteps;
  List<StepData> sdLst = [];

  HealtDatabase(DatabaseReference dbRef, User user) {
    this._dbRef = dbRef;
    this._user = user;
    this._userId = user.userId;
    this._refUserSteps = 'users/' + this._userId + '/steps/';
  }

  String _minutInterVal(int minVal) {
    if (minVal >= 45 && minVal <= 60) {
      return '45';
    } else if (minVal >= 30) {
      return '30';
    } else if (minVal >= 15) {
      return '15';
    } else if (minVal >= 0) {
      return '0';
    } else {
      throw new FormatException('Wrong format, minut interval should be 0..60');
    }
  }

  Future<void> updateStepCount(StepData sd) async {
    String dtChild = DateFormat('yyyy/MM/dd/HH').format(sd.datetime);
    String minIntVal = _minutInterVal(sd.datetime.minute);
    String refPath =
        'users/' + this._userId + '/steps/' + dtChild + '/' + minIntVal;
    StepData sddb = await getStepDataInterval(sd.datetime);
    if (sddb != null) {
      sd.steps = sd.steps + sddb.steps;
    }
    this._dbRef.child(refPath).set(sd.toJson());
  }

  StepData _createStepData(Map<dynamic, dynamic> record) {
    DateTime dt = DateTime.parse(record['datetime']);
    StepData sd = new StepData(this._userId, dt, int.tryParse(record['steps']));
    return sd;
  }

  Future<StepData> getStepDataInterval(DateTime dt) async {
    String dtChild = DateFormat('yyyy/MM/dd/HH').format(dt);
    String minIntVal = _minutInterVal(dt.minute);
    String refPath =
        'users/' + this._userId + '/steps/' + dtChild + '/' + minIntVal;
    DataSnapshot snapshot = await this._dbRef.child(refPath).once();
    if (snapshot.value != null) {
      return _createStepData(snapshot.value);
    } else {
      return null;
    }
  }

  Future<List<StepData>> getStepDataPerDay(DateTime dt) async {
    String dtChild = DateFormat('yyyy/MM/dd').format(dt);
    String path = _refUserSteps + dtChild;
    DataSnapshot snapshot = await this._dbRef.child(path).once();
    List<StepData> lst = [];
    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((k1, v1) {
        if (v1 is List) {
          lst.add(_createStepData(v1[0]));
        } else {
          v1.forEach((k2, v2) {
            lst.add(_createStepData(v2));
          });
        }
      });
    }
    return lst;
  }
}
