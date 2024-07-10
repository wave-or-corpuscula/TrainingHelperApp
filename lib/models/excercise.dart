import 'dart:developer';
import 'package:sqflite/sqflite.dart';

import 'package:training_helper_app/utils/helper_exception.dart';
import 'package:training_helper_app/utils/singleton_db.dart';
import 'package:training_helper_app/models/excercise_type.dart';


class Excercise {
  int? _id;
  String _name;
  int _excercise_type_id;
  String _comment;

  static const String tableExcersice = 'Excercise';
  static const String colId = 'id';
  static const String colName = 'name';
  static const String colExcerciseTypeId = 'excercise_type_id';
  static const String colComment = 'comment';

  Excercise(this._name, this._excercise_type_id, this._comment);

  int? get id => _id;
  String get name => _name;
  int get excerciseTypeId => _excercise_type_id;
  String get comment => _comment;

  set id (int? newId) {
    _id = newId;
  }

  set name(String newName) {
    if (newName.isEmpty) {
      throw HelperException('Name can\'t be empty'); // TODO: Make localization
    }
    _name = newName;
  }

  set excerciseTypeId(int newExTypeId) {
    _excercise_type_id = newExTypeId;
  }

  set comment(String newComment) {
    _comment = newComment;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map[colId] = _id;
    map[colName] = _name;
    map[colExcerciseTypeId] = _excercise_type_id;
    map[colComment] = _comment;

    return map;
  }

  Excercise.fromMapObject(Map<String, dynamic> map)
  : _id = map[colId],
    _name = map[colName],
    _excercise_type_id = map[colExcerciseTypeId],
    _comment = map[colComment];

  static void createTable(Database db) async {
    await db.execute('''
      CREATE TABLE Excercise (
        $colId INTEGER PRIMARY KEY,
        $colName VARCHAR NOT NULL,
        $colExcerciseTypeId INTEGER NOT NULL,
        $colComment TEXT,
        FOREIGN KEY ($colExcerciseTypeId) REFERENCES ExcerciseType(${ExcerciseType.colId}) ON DELETE CASCADE ON UPDATE CASCADE
      );''');
      log('$tableExcersice created');
  }

  // Query methods

  // static Future<List<Map<String, dynamic>>> getMapList() async {
  //   Database db = await SingletonDatabase.database;

  //   var mapList = await db.query(table)
  // }

}