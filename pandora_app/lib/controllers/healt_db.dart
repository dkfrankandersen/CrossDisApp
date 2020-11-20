import 'package:firebase_database/firebase_database.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/models/user.dart';

class HealtDatabase {
  DatabaseReference _dbRef;
  String userId;

  HealtDatabase(DatabaseReference dbRef, User user) {
    this._dbRef = dbRef;
    userId = user.userId;
  }

  DatabaseReference saveStepCount(StepData stepData) {
    var id = this._dbRef.child('users/' + this.userId + '/steps/').push();
    id.set(stepData.toJSON());
    return id;
  }

  StepData _createStepData(Map<dynamic, dynamic> record) {
    DateTime dt = DateTime.parse(record['datetime']);
    StepData sd = new StepData(this.userId, dt, record['steps']);
    return sd;
  }

  Future<List<StepData>> getAllStepCount() async {
    print("Hello from getAllStepCount, user: " + this.userId);
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
