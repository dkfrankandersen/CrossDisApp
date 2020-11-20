import 'package:firebase_database/firebase_database.dart';

class StepData {
  DateTime datetime;
  String userid;
  String steps;
  DatabaseReference _id;

  StepData(this.userid, this.datetime, this.steps);

  setId(DatabaseReference id) {
    this._id = id;
  }

  getDBIdKey() {
    return this._id.key;
  }

  Map<String, dynamic> toJSON() {
    return {'datetime': this.datetime.toString(), 'steps': this.steps};
  }

  @override
  String toString() =>
      this.datetime.toString() + " " + this.userid + " " + this.steps;
}
