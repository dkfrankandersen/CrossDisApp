import 'package:flutter/material.dart';
import 'package:pandora_app/profile.dart';
import 'package:pandora_app/logout.dart';
import 'package:pandora_app/shop.dart';
import 'package:pandora_app/statistics.dart';
import 'package:pandora_app/devices.dart';
import 'package:pandora_app/jewellery.dart';

class MainMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Column(
            children: [
              // Image.asset('assets/images/logo001.png'),
              Text('Menu',
                  style:
                      TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold)),
            ],
          ),
          decoration: BoxDecoration(color: Color.fromARGB(255, 245, 216, 223)),
        ),
        MenuListTile('My Profile', 'profile'),
        MenuListTile('My Statistics', 'statistics'),
        MenuListTile('My Devices', 'devices'),
        MenuListTile('My Jewellery', 'jewellery'),
        MenuListTile('My Shopping', 'shopping'),
        MenuListTile('Logout', 'logout'),
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
      default:
        return ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.normal)),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => getPage(page)),
          );
        });
  }
}
