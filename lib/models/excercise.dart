import 'dart:developer';
import 'package:sqflite/sqflite.dart';

import 'package:training_helper_app/utils/helper_exception.dart';
import 'package:training_helper_app/utils/singleton_db.dart';

import 'package:training_helper_app/models/excercise_type.dart';
import 'package:training_helper_app/models/base_model.dart';


class Excercise extends BaseModel {
  late String _name;
  late int _excercise_type_id;
  late String _comment;

  static const String tableName = 'Excercise';
  static const String colId = 'id';
  static const String colName = 'name';
  static const String colExcerciseTypeId = 'excercise_type_id';
  static const String colComment = 'comment';

  Excercise.query() : super();

  Excercise(this._name, this._excercise_type_id, this._comment) : super();

  @override
  String get tableNameBase => tableName;

  @override
  String get idColumnName => colId;

  String get name => _name;
  int get excerciseTypeId => _excercise_type_id;
  String get comment => _comment;

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

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map[colId] = id;
    map[colName] = _name;
    map[colExcerciseTypeId] = _excercise_type_id;
    map[colComment] = _comment;

    return map;
  }

  Excercise.fromMapObject(super.map)
  : _name = map[colName],
    _excercise_type_id = map[colExcerciseTypeId],
    _comment = map[colComment],
    super.fromMapObject();

  @override
  BaseModel fromMapObject(Map<String, dynamic> map) {
    return Excercise.fromMapObject(map);
  }

  // --- QUERY METHODS --- //

  static void createTable(Database db) async {
    await db.execute('''
      CREATE TABLE Excercise (
        $colId INTEGER PRIMARY KEY,
        $colName VARCHAR NOT NULL,
        $colExcerciseTypeId INTEGER NOT NULL,
        $colComment TEXT,
        FOREIGN KEY ($colExcerciseTypeId) REFERENCES ExcerciseType(${ExcerciseType.colId}) ON DELETE CASCADE ON UPDATE CASCADE
      );''');
      log('$tableName created');
  }
}