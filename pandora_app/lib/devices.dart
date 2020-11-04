import 'package:flutter/material.dart';
import 'package:pandora_app/Models/basedevice.dart';
import 'package:pandora_app/devicestats.dart';
import 'package:pandora_app/menu.dart';
import 'package:pandora_app/Database.dart';

class DevicesPage extends StatelessWidget {
  final List<Widget> deviceWidgets = [];
  final Database db = new Database();
  DevicesPage() {
    // add all to container
    for (BaseDevice bd in db.baseDevices) {
      deviceWidgets.add(new BaseDeviceContainer(bd));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar:
                AppBar(title: MenuTextFormat.getAppBarTitleText('My Devices')),
            drawer: MainMenuDrawer(),
            body: ListView(
                padding: const EdgeInsets.all(20), children: deviceWidgets)));
  }
}

class BaseDeviceContainer extends StatelessWidget {
  final BaseDevice baseDevice;

  BaseDeviceContainer(this.baseDevice);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: InkWell(
        child: Row(
          children: [
            Container(
                child: Expanded(
              flex: 4,
              child: baseDevice.getImage(),
            )),
            Expanded(
              flex: 7,
              child: Container(
                  child: Column(children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      baseDevice.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      baseDevice.description,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ])),
            ),
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        baseDevice.getBatteryIcon(50.0),
                        Text(
                          baseDevice.getBatteryStr(),
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    )),
                  ],
                ))
          ],
        ),
        onTap: () {
          print("tapped on " + baseDevice.name);
          // Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new DeviceStatsPage(baseDevice)),
          );
        },
      ),
    );
  }
}
