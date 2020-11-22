import 'package:flutter/material.dart';
import 'package:pandora_app/controllers/database.dart';
import 'package:pandora_app/models/label.dart';
import 'package:pandora_app/models/step_data.dart';
import 'package:pandora_app/views/menu.dart';
import 'package:intl/intl.dart';

class LabelEventPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  Label label;
  final myController = TextEditingController();

  LabelEventPage(DateTime dateTime, int steps) {
    label = new Label(dateTime, steps);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: MenuTextFormat.getAppBarTitleText("Label Event")),
        body: Container(
            height: 750,
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Label event',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'DateTime: ' +
                          DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(label.getDateTime()),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Steps: ' + label.getSteps().toString(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: myController,
                        decoration: const InputDecoration(
                          hintText: 'Enter description',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              // Process data.
                              print("Event label saved");
                              label.description = myController.text;
                              Database db = Database.instance();
                              db.healt.labels.add(label);
                              print(db.healt.labels.length.toString());
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
