import 'package:flutter/material.dart';
import 'package:pandora_app/views/menu.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar: AppBar(
                title: MenuTextFormat.getAppBarTitleText('Logging out...')),
            drawer: MainMenuDrawer(),
            body: Center(
              child: MenuTextFormat.getTempPageText('You have been logged out'),
            )));
  }
}
