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

  int _minutInterVal(int minVal) {
    if (minVal >= 45 && minVal <= 60) {
      return 45;
    } else if (minVal >= 30) {
      return 30;
    } else if (minVal >= 15) {
      return 15;
    } else if (minVal >= 0) {
      return 0;
    } else {
      throw new FormatException('Wrong format, minut interval should be 0..60');
    }
  }

  DateTime dtAsInterval() {
    DateTime dt = new DateTime(datetime.year, datetime.month, datetime.day,
        datetime.hour, this._minutInterVal(datetime.minute), 0, 0);
    return dt;
  }

  @override
  String toString() =>
      this.datetime.toString() +
      " " +
      this.userid +
      " " +
      this.steps.toString();
}
