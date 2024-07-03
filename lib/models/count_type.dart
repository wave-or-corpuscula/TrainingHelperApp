import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:training_helper_app/utils/helper_exception.dart';


class CountType {
  int? _id;
  String _name;

  static String countTypeTable = "CountType";
  static String colId = "id";
  static String colName = "name";

  CountType(this._name);

  int? get id => _id;
  String get name => _name;

  set name (String newName) {
    if (newName.isEmpty) {
      throw HelperException("Name cannot be empty!"); // TODO: Make localization
    }
    if (newName.length > 255) {
      throw HelperException("Name must be < 255 characters!"); // TODO: Make localization
    }

    _name = newName;
  }

  set id (int? newId) { 
    _id = newId;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map[colId] = _id;
    }
    map[colName] = _name;
    return map;
  }

  CountType.fromMapObject(Map<String, dynamic> map)
  : _id = map[colId],
    _name = map[colName];

  static void createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $countTypeTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName VARCHAR NOT NULL UNIQUE
      );
    ''');
    log("$countTypeTable created");
  }
}