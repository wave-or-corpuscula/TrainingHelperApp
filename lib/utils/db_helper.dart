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

  
}