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
            appBar:
                AppBar(title: MenuTextFormat.getAppBarTitleText('My Devices')),
            drawer: MainMenuDrawer(),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                Divider(color: Colors.black),
                new BaseDeviceContainer(new BaseDevice(
                    1,
                    'Moments Ring',
                    'Capture the happiness',
                    'assets/images/basering001.png',
                    98)),
                Divider(color: Colors.black),
                new BaseDeviceContainer(new BaseDevice(
                    2,
                    'Contact Ring',
                    'Feeling safe is all that matters',
                    'assets/images/basering002.png',
                    19)),
                Divider(color: Colors.black),
                new BaseDeviceContainer(new BaseDevice(
                    3,
                    'Puls Ring',
                    'Keeping the workout cool',
                    'assets/images/basering003.png',
                    70)),
                Divider(color: Colors.black),
                new BaseDeviceContainer(new BaseDevice(4, 'My First Ring',
                    'Making memorys', 'assets/images/basering004.png', -1)),
                Divider(color: Colors.black),
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
                      baseDevice.getName(),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      baseDevice.getDescription(),
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
          print("tapped on " + baseDevice.getName());
        },
      ),
    );
  }
}
