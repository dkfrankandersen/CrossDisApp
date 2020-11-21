import 'package:firebase_database/firebase_database.dart';

class StepData {
  DateTime datetime;
  String userid;
  int steps;
  DatabaseReference _id;

  StepData(this.userid, this.datetime, this.steps);

  setId(DatabaseReference id) {
    this._id = id;
  }

  getDBIdKey() {
    return this._id.key;
  }

  String formatDate(DateTime d) {
    return d.toString().substring(0, 19);
  }

  Map<String, dynamic> toJson() {
    return {
      'datetime': formatDate(this.datetime),
      'steps': this.steps.toString()
    };
  }

  @override
  String toString() =>
      this.datetime.toString() +
      " " +
      this.userid +
      " " +
      this.steps.toString();
}
