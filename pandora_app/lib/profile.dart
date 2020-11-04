import 'package:flutter/material.dart';
import 'package:pandora_app/menu.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar:
                AppBar(title: MenuTextFormat.getAppBarTitleText('My profile')),
            drawer: MainMenuDrawer(),
            body: Center(
              child: Text('ProfilePage'),
            )));
  }
}
