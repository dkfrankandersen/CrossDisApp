import 'package:flutter/material.dart';
import 'package:pandora_app/models/label.dart';

class LabelWidget extends StatelessWidget {
  final Label label;

  LabelWidget(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(children: [
        Align(
            alignment: Alignment.topLeft,
            child: Text(
                'DateTime: ' + label.getDateTime().toString().substring(0, 16),
                style: TextStyle(fontSize: 22))),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Steps: ' + label.getSteps().toString(),
              style: TextStyle(fontSize: 22),
            )),
        Align(
            alignment: Alignment.topLeft,
            child: Text('Description: ' + label.description,
                style: TextStyle(fontSize: 22))),
      ]),
    );
  }
}
