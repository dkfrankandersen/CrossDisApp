import 'package:flutter/material.dart';
import 'package:pandora_app/menu.dart';

class JewelleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar: AppBar(title: Text('My Jewellery')),
            drawer: MainMenuDrawer(),
            body: Center(
              child: Text('JewelleryPage'),
            )));
  }
}
