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
          child: Text('Menu',
              style: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold)),
          decoration: BoxDecoration(color: Color.fromARGB(255, 245, 216, 223)),
        ),
        ListTile(
            title: Text('My Profile',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }),
        ListTile(
            title: Text('My Statistics',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatisticsPage()),
              );
            }),
        ListTile(
            title: Text('My Devices',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DevicesPage()),
              );
            }),
        ListTile(
            title: Text('My Jewellery',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JewelleryPage()),
              );
            }),
        ListTile(
            title: Text('Shop',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => shopPage()),
              );
            }),
        ListTile(
            title: Text('Logout',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogoutPage()),
              );
            }),
      ],
    ));
  }
}
