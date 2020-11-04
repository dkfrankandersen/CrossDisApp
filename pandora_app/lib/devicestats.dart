import 'package:flutter/material.dart';
import 'package:pandora_app/Models/basedevice.dart';
import 'package:pandora_app/menu.dart';
import 'package:pandora_app/chartbarsdemo.dart';
import 'package:pandora_app/chartpointsdemo.dart';

class DeviceStatsPage extends StatelessWidget {
  final BaseDevice baseDevice;

  DeviceStatsPage(this.baseDevice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                MenuTextFormat.getAppBarTitleText(baseDevice.name + " stats")),
        body: Container(
            height: 750,
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                baseDevice.getImage(),
                Divider(color: Colors.black),
                Text('Steps', style: TextStyle(fontSize: 24)),
                Expanded(child: new TimeSeriesBar.withSampleData()),
                Divider(color: Colors.black),
                Text("Puls", style: TextStyle(fontSize: 24)),
                Expanded(child: new PointsLineChart.withSampleData()),
                Divider(color: Colors.black),
                Text("Distance", style: TextStyle(fontSize: 24)),
                Expanded(child: new PointsLineChart.withSampleData()),
                Divider(color: Colors.black),
              ],
            )));
  }
}
