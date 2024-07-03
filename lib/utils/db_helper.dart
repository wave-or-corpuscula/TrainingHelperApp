import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'package:training_helper_app/models/count_type.dart';


class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._createInstance();
  static Database? _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<Database> get database async {

		_database ??= await initializeDatabase();

		return _database!;
	}

  Future<Database> initializeDatabase() async {
		String path = 'appDb.db';

		var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return notesDatabase;
	}

  void _createDb(Database db, int newVersion) async {
    CountType.createTable(db);
  }

  // CountType queryes //

  Future<List<Map<String, dynamic>>> getCountTypeMapList() async {
    Database db = await database;

    var cTypeList = await db.query(CountType.countTypeTable);
    return cTypeList;
  }

  Future<List<CountType>> getCountTypeList() async {
    var mapList = await getCountTypeMapList();
    int count = mapList.length;

    List<CountType> cTypeList = [];

    for (int i = 0; i < count; i++) {
      cTypeList.add(CountType.fromMapObject(mapList[i]));
    }

    return cTypeList;
  }

  Future<int> truncateCountType() async {
    Database db = await database;

    int result = await db.rawDelete('DELETE FROM ${CountType.countTypeTable};');
    return result;
  }

  Future<int> insertCountType(CountType newRecord) async {
    Database db = await database;

    int result = await db.insert(CountType.countTypeTable, newRecord.toMap());
    return result;
  }

  Future<int> updateCountType(CountType changedRecord) async {
    Database db = await database;

    int result = await db.update(CountType.countTypeTable, changedRecord.toMap(), where: '${CountType.colId} = ?', whereArgs: [changedRecord.id]);
    return result;
  }

  Future<int> deleteCountType(CountType deleteRecord) async {
    Database db = await database;

    int result = await db.delete(CountType.countTypeTable, where: '${CountType.colId} = ?', whereArgs: [deleteRecord.id]);
    return result;
  }

  // CountType queryes //

}