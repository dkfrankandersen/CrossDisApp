import 'package:firebase_database/firebase_database.dart';
import 'package:pandora_app/controllers/item_db.dart';
import 'package:pandora_app/controllers/healt_db.dart';
import 'package:pandora_app/models/user.dart';

final Database appDB = new Database();

class Database {
  ItemDatabase items;
  HealtDatabase healt;
  DatabaseReference _dbRef;
  User user;

  Database() {
    this._dbRef = FirebaseDatabase.instance.reference();
    this.user = new User('demoUser');

    this.items = new ItemDatabase();
    this.healt = new HealtDatabase(this._dbRef, user);
  }
}
