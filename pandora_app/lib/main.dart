import 'package:flutter/material.dart';
import 'package:pandora_app/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar: AppBar(title: Text('Pandora Universe')),
            drawer: MainMenuDrawer(),
            body: Center(
              child: Image.asset('assets/images/logo001.png'),
            )));
  }
}
