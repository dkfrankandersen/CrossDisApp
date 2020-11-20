import 'package:flutter/material.dart';
import 'package:pandora_app/views/menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar: AppBar(
                title: MenuTextFormat.getAppBarTitleText('Pandora Universe')),
            drawer: MainMenuDrawer(),
            body: Center(
              child: Image.asset('assets/images/logo001.png'),
            )));
  }
}
