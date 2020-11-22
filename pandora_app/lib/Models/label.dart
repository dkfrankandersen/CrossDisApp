class Label {
  DateTime _datetime;
  int _steps;
  String description;

  Label(this._datetime, this._steps);

  DateTime getDateTime() {
    return _datetime;
  }

  int getSteps() {
    return _steps;
  }
}
