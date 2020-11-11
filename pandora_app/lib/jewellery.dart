import 'package:flutter/material.dart';
import 'package:pandora_app/menu.dart';
import 'package:pandora_app/Models/jewellery.dart';
import 'package:pandora_app/database.dart';

class JewelleryPage extends StatelessWidget {
  final List<Widget> deviceWidgets = [];
  final Database db = new Database();

  JewelleryPage() {
    // add all to container
    for (JewelleryPiece jp in db.jewelleryPieces) {
      deviceWidgets.add(new JewelleryContainer(jp));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 245, 216, 223)),
        home: Scaffold(
            appBar: AppBar(
                title: MenuTextFormat.getAppBarTitleText('My Jewellery')),
            drawer: MainMenuDrawer(),
            body: ListView(
                padding: const EdgeInsets.all(20), children: deviceWidgets)));
  }
}

class JewelleryContainer extends StatelessWidget {
  final JewelleryPiece jewellery;

  JewelleryContainer(this.jewellery);

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
              child: jewellery.getImage(),
            )),
            Expanded(
              flex: 7,
              child: Container(
                  child: Column(children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      jewellery.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      jewellery.description,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ))
              ])),
            ),
            Expanded(
                flex: 2,
                child: Text(
                  'Owns',
                  style: TextStyle(fontSize: 18),
                ))
          ],
        ),
        onTap: () {
          print("tapped on " + jewellery.name);
          // Navigator.pop(context);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => new JewellerAccessoryPage(jewellery)),
          // );
        },
      ),
    );
  }
}
