import 'package:firebase_database/firebase_database.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/models/user.dart';
import 'package:intl/intl.dart';

class HealtDatabase {
  DatabaseReference _dbRef;
  String userId;

  HealtDatabase(DatabaseReference dbRef, User user) {
    this._dbRef = dbRef;
    this.userId = user.userId;
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

  Future<DatabaseReference> saveStepCount(StepData sd) async {
    String dtChild = DateFormat('yyyy/MM/dd/kk').format(sd.datetime);
    String minIntVal = _minutInterVal(sd.datetime.minute);
    String refPath =
        'users/' + this.userId + '/steps/' + dtChild + '/' + minIntVal;

    // DataSnapshot snapshot = await this._dbRef.child(refPath).once();
    // if (snapshot.value == null) {
    //   var id = this._dbRef.child(refPath).push();
    //   id.set(sd.toJSON());
    //   return id;
    // } else {
    this._dbRef.child(refPath).set(sd.toJson());
    // }
  }

  StepData _createStepData(Map<dynamic, dynamic> record) {
    DateTime dt = DateTime.parse(record['datetime']);
    StepData sd = new StepData(this.userId, dt, record['steps']);
    return sd;
  }

  Future<List<StepData>> getAllStepCount() async {
    DataSnapshot snapshot =
        await this._dbRef.child('users/' + this.userId + '/steps').once();
    List<StepData> stepDataLst = [];
    if (snapshot.value != null) {
      for (var key in snapshot.value.keys) {
        StepData sd = _createStepData(snapshot.value[key]);
        sd.setId(this._dbRef.child('users/' + this.userId + '/steps/' + key));
        stepDataLst.add(sd);
      }
      stepDataLst.sort((a, b) => a.datetime.compareTo(b.datetime));
    } else {
      print("No stepdata for user...");
    }
    return stepDataLst;
  }
}
