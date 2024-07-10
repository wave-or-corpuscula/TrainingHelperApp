import 'dart:developer';
import 'package:sqflite/sqflite.dart';

import 'package:training_helper_app/models/excercise_type.dart';
import 'package:training_helper_app/models/base_model.dart';

import 'package:training_helper_app/utils/helper_exception.dart';
import 'package:training_helper_app/utils/singleton_db.dart';


class CountType extends BaseModel {
  late String _name;

  static const String tableName = "CountType";
  static const String colId = "id";
  static const String colName = "name";

  CountType.query() : super();
  
  CountType(this._name) : super();

  @override
  String get tableNameBase => tableName;

  @override
  String get idColumnName => colId;

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

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map[colId] = id;
    }
    map[colName] = _name;
    return map;
  }

  CountType.fromMapObject(super.map)
  : _name = map[colName],
    super.fromMapObject();

  @override
  BaseModel fromMapObject(Map<String, dynamic> map) {
    return CountType.fromMapObject(map);
  }

  // --- QUERY METHODS --- //

  static void createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName VARCHAR NOT NULL UNIQUE
      );''');
    log('$tableName created');
  }

  @override
  Future<int> delete() async {
    Database db = await SingletonDatabase.database;


    int result = await ExcerciseType.cascadeCountTypeDeleted(id!);
    result = await db.delete(tableName, where: '$colId = ?', whereArgs: [id]);

    return result;
  }
}