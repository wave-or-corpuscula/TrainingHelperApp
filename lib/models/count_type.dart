import 'dart:developer';
import 'package:sqflite/sqflite.dart';

import 'package:training_helper_app/utils/helper_exception.dart';
import 'package:training_helper_app/utils/singleton_db.dart';


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

  // Query methods

  static Future<List<Map<String, dynamic>>> getMapList() async {
    Database db = await SingletonDatabase.database;

    var cTypeList = await db.query(CountType.countTypeTable);
    return cTypeList;
  }

  static Future<List<CountType>> getList() async {
    var mapList = await getMapList();
    int count = mapList.length;

    List<CountType> cTypeList = [];

    for (int i = 0; i < count; i++) {
      cTypeList.add(CountType.fromMapObject(mapList[i]));
    }

    return cTypeList;
  }

  static Future<int> truncate() async {
    Database db = await SingletonDatabase.database;

    int result = await db.rawDelete('DELETE FROM ${CountType.countTypeTable};');
    return result;
  }

  static Future<int> insert(CountType newRecord) async {
    Database db = await SingletonDatabase.database;

    int result = await db.insert(CountType.countTypeTable, newRecord.toMap());
    return result;
  }

  static Future<int> update(CountType changedRecord) async {
    Database db = await SingletonDatabase.database;

    int result = await db.update(CountType.countTypeTable, changedRecord.toMap(), where: '${CountType.colId} = ?', whereArgs: [changedRecord.id]);
    return result;
  }

  static Future<int> delete(CountType deleteRecord) async {
    Database db = await SingletonDatabase.database;

    int result = await db.delete(CountType.countTypeTable, where: '${CountType.colId} = ?', whereArgs: [deleteRecord.id]);
    return result;
  }
}