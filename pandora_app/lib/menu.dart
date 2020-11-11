import 'package:flutter/material.dart';
import 'package:pandora_app/profile.dart';
import 'package:pandora_app/logout.dart';
import 'package:pandora_app/shop.dart';
import 'package:pandora_app/statistics.dart';
import 'package:pandora_app/devices.dart';
import 'package:pandora_app/jewellery.dart';
import 'package:pandora_app/Healt/pedometer.dart';

class MainMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
            height: 120,
            child: DrawerHeader(
              child: Column(
                children: [
                  Text('Menu',
                      style: TextStyle(
                          fontSize: 42.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto')),
                ],
              ),
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 245, 216, 223)),
            )),
        Container(
          height: 100,
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/images/logo001.png',
            scale: 0.1,
          ),
        ),
        MenuListTile('My Profile', 'profile'),
        MenuListTile('My Statistics', 'statistics'),
        MenuListTile('My Devices', 'devices'),
        MenuListTile('My Jewellery', 'jewellery'),
        MenuListTile('My Shopping', 'shop'),
        MenuListTile('Logout', 'logout'),
        MenuListTile('Steps', 'steps'),
      ],
    ));
  }
}

class MenuListTile extends StatelessWidget {
  final String title;
  final String page;

  MenuListTile(this.title, this.page);

  getPage(page) {
    switch (page) {
      case 'profile':
        return ProfilePage();
        break;
      case 'statistics':
        return StatisticsPage();
        break;
      case 'devices':
        return DevicesPage();
        break;
      case 'jewellery':
        return JewelleryPage();
        break;
      case 'shop':
        return ShopPage();
        break;
      case 'logout':
        return LogoutPage();
        break;
      case 'steps':
        return StepPage();
        break;
      default:
        return ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 65,
        child: ListTile(
            title: Text(title,
                style:
                    TextStyle(fontSize: 28.0, fontWeight: FontWeight.normal)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => getPage(page)),
              );
            }));
  }
}

class MenuTextFormat {
  static getAppBarTitleText(String str) {
    return Text(
      str,
      style: TextStyle(fontSize: 28),
    );
  }

  static getTempPageText(String str) {
    return Text(
      str,
      style: TextStyle(fontSize: 28),
    );
  }
}
