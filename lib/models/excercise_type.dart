import 'dart:developer';
import 'package:sqflite/sqflite.dart';

import 'package:training_helper_app/utils/helper_exception.dart';
import 'package:training_helper_app/utils/singleton_db.dart';
import 'package:training_helper_app/models/count_type.dart';


class ExcerciseType {
  int? _id;
  String _name;
  String _postfix;
  int _count_type_id;

  static String tableExcersiceType = 'ExcerciseType';
  static String colId = 'id';
  static String colName = 'name';
  static String colPostfix = 'postfix';
  static String colCountTypeId = 'count_type_id';

  ExcerciseType(this._name, this._postfix, this._count_type_id);

  int? get id => _id;
  String get name => _name; 
  String get postfix => _postfix;
  int get countTypeId => _count_type_id;

  set name(String newName) {
    if (newName.isEmpty) {
      throw HelperException('Name can\'t be empty'); // TODO: Make localization
    }
    _name = newName;
  }

  set postfix(String newPostfix) {
    if (postfix.isEmpty) {
      throw HelperException('Name can\'t be empty'); // TODO: Make localization
    }
    _postfix = newPostfix;
  }

  set countTypeId (int newCountTypeId) {
    
    // TODO: Implement check if `newCountTypeId` exists
    
    _count_type_id = newCountTypeId;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map[colId] = _id;
    map[colName] = _name;
    map[colPostfix] = _postfix;
    map[colCountTypeId] = _count_type_id;
    return map;
  }

  ExcerciseType.fromMapObject(Map<String, dynamic> map)
  : _id = map[colId],
    _name = map[colName],
    _postfix = map[colPostfix],
    _count_type_id = map[colCountTypeId];

  static void createTable(Database db) async {
    await db.execute('''
      CREATE TABLE ExcerciseType (
        $colId INTEGER PRIMARY KEY,
        $colName VARCHAR NOT NULL,
        $colPostfix VARCHAR NOT NULL,
        $colCountTypeId INTEGER,
        FOREIGN KEY ($colCountTypeId) REFERENCES ${CountType.tableCountType}(${CountType.colId}) ON DELETE SET NULL ON UPDATE CASCADE
      );''');
      log('$tableExcersiceType created');
  }

  // Query methods

  static Future<List<Map<String, dynamic>>> getMapList() async {
    Database db = await SingletonDatabase.database;

    var mapList = await db.query(tableExcersiceType);
    return mapList;
  }

  static Future<List<ExcerciseType>> getList() async {
    var mapList = await getMapList();

    List<ExcerciseType> exList = [];
    for (int i = 0; i < mapList.length; i++) {
      exList.add(ExcerciseType.fromMapObject(mapList[i]));
    }
    return exList;
  }

  static Future<int> truncate() async {
    Database db = await SingletonDatabase.database;

    int result = await db.rawDelete('DELETE FROM $tableExcersiceType');
    return result;
  }

  static Future<int> insert(ExcerciseType newRecord) async {
    Database db = await SingletonDatabase.database;

    int result = await db.insert(ExcerciseType.tableExcersiceType, newRecord.toMap());
    return result;
  }

  static Future<int> update(ExcerciseType changedRecord) async {
    Database db = await SingletonDatabase.database;

    int result = await db.update(tableExcersiceType, changedRecord.toMap(), where: '$colId = ?', whereArgs: [changedRecord.id]);
    return result;
  }

  static Future<int> delete(ExcerciseType deleteRecord) async {
    Database db = await SingletonDatabase.database;

    int result = await db.delete(tableExcersiceType, where: '$colId = ?', whereArgs: [deleteRecord.id]);
    return result;
  }
}