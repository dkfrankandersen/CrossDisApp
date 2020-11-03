import 'package:flutter/material.dart';
import 'package:pandora_app/Models/BaseDevice.dart';
import 'package:pandora_app/menu.dart';

class DevicesPage extends StatelessWidget {
  // final _Devices = <Devices>[]

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar: AppBar(title: Text('My Devices')),
            drawer: MainMenuDrawer(),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                new BaseDeviceContainer(new BaseDevice(
                    'Moments Ring', '', 'assets/images/basering001.png', 98)),
                new BaseDeviceContainer(new BaseDevice(
                    'Contact Ring', '', 'assets/images/basering002.png', 19)),
                new BaseDeviceContainer(new BaseDevice(
                    'Puls Ring', '', 'assets/images/basering003.png', 70)),
                new BaseDeviceContainer(new BaseDevice(
                    'My First Ring', '', 'assets/images/basering004.png', -1)),
              ],
            )));
  }
}

class BaseDeviceContainer extends StatelessWidget {
  final BaseDevice baseDevice;

  BaseDeviceContainer(this.baseDevice);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        color: Colors.white30,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: baseDevice.getImage(),
            ),
            Expanded(
                flex: 8,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          baseDevice.getName(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        baseDevice.getBatteryIcon(50.0),
                        Text(
                          baseDevice.getBatteryStr(),
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
