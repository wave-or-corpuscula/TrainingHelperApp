import 'dart:developer';
import 'package:sqflite/sqflite.dart';

import 'package:training_helper_app/utils/helper_exception.dart';
import 'package:training_helper_app/utils/singleton_db.dart';

import 'package:training_helper_app/models/count_type.dart';
import 'package:training_helper_app/models/base_model.dart';


class ExcerciseType extends BaseModel {
  late String _name;
  late String _postfix;
  late int _count_type_id;

  static const String tableName = 'ExcerciseType';
  static const String colId = 'id';
  static const String colName = 'name';
  static const String colPostfix = 'postfix';
  static const String colCountTypeId = 'count_type_id';

  ExcerciseType.query() : super();

  ExcerciseType(this._name, this._postfix, this._count_type_id) : super();

  @override
  String get tableNameBase => tableName;

  @override
  String get idColumnName => colId;

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

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map[colId] = id;
    map[colName] = _name;
    map[colPostfix] = _postfix;
    map[colCountTypeId] = _count_type_id;
    return map;
  }

  ExcerciseType.fromMapObject(super.map)
  : _name = map[colName],
    _postfix = map[colPostfix],
    _count_type_id = map[colCountTypeId],
    super.fromMapObject();

  @override
  BaseModel fromMapObject(Map<String, dynamic> map) {
    return ExcerciseType.fromMapObject(map);
  }

  // --- QUERY METHODS --- //

  static void createTable(Database db) async {
    await db.execute('''
      CREATE TABLE ExcerciseType (
        $colId INTEGER PRIMARY KEY,
        $colName VARCHAR NOT NULL,
        $colPostfix VARCHAR NOT NULL,
        $colCountTypeId INTEGER,
        FOREIGN KEY ($colCountTypeId) REFERENCES ${CountType.tableName}(${CountType.colId}) ON DELETE SET NULL ON UPDATE CASCADE
      );''');
      log('$tableName created');
  }

  Future<int> cascadeCountTypeDeleted(int countTypeId) async {
    Database db = await SingletonDatabase.database;

    int result = await db.delete(tableName, where: '$colCountTypeId = ?', whereArgs: [countTypeId]);
    return result;
  }
}