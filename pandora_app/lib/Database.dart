import 'package:pandora_app/Models/jewellery.dart';
import 'package:pandora_app/Models/basedevice.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final userid = 'demoUser';

DatabaseReference saveStepCount(StepData stepData) {
  var id = databaseReference.child('users/' + userid + '/steps/').push();
  id.set(stepData.toJSON());
  return id;
}

StepData createStepData(Map<dynamic, dynamic>record) {
  DateTime dt = DateTime.parse(record['datetime']);
  StepData sd = new StepData(userid, dt, record['steps']);
  return sd;
}

Future<List<StepData>> getAllStepCount() async {
  print("Hello from getAllStepCount, user: " + userid);
  DataSnapshot snapshot = await databaseReference.child('users/' + userid + '/steps').once();
  List<StepData> stepDataLst = [];
  if (snapshot.value != null) {

    for (var key in snapshot.value.keys) {
      StepData sd = createStepData(snapshot.value[key]);
      sd.setId(databaseReference.child('users/' + userid + '/steps/' + key));
      stepDataLst.add(sd);
    } 
  } else {
    print("No stepdata for user...");
  }
  return stepDataLst;
}

class StepData {
  DateTime datetime;
  String userid;
  String steps;
  DatabaseReference _id;

  StepData(String this.userid, DateTime this.datetime, String this.steps);

  setId(DatabaseReference id) {
    this._id = id;
  }

  getDBIdKey() {
    return this._id.key;
  }

  Map<String, dynamic> toJSON() {
    return {'datetime': this.datetime.toString(), 'steps': this.steps};
  }
}

class Database {
  final List<JewelleryPiece> jewelleryPieces = [];
  final List<BaseDevice> baseDevices = [];

  Database() {
    jewelleryPieces.add(new JewelleryPiece(1, 'Kuglebesat Pavé Båndring',
        'Purely Pandora', 'assets/images/jewellery001.png'));
    jewelleryPieces.add(new JewelleryPiece(
      2,
      'Sparkling & Polished Lines Ring',
      'Pandora Timeless',
      'assets/images/jewellery002.png',
    ));
    jewelleryPieces.add(new JewelleryPiece(3, 'Mat Glans Ring',
        'Pandora Timeless', 'assets/images/jewellery003.png'));

    baseDevices.add(new BaseDevice(1, 'Moments Ring', 'Capture the happiness',
        'assets/images/basering001.png', 98));
    baseDevices.add(new BaseDevice(
        2,
        'Contact Ring',
        'Feeling safe is all that matters',
        'assets/images/basering002.png',
        19));
    baseDevices.add(new BaseDevice(3, 'Puls Ring', 'Keeping the workout cool',
        'assets/images/basering003.png', 70));
    baseDevices.add(new BaseDevice(4, 'My First Ring', 'Making memorys',
        'assets/images/basering004.png', -1));
  }
}
