import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'package:training_helper_app/models/count_type.dart';
import 'package:training_helper_app/models/excercise_type.dart';


class SingletonDatabase {

  static final SingletonDatabase _databaseHelper = SingletonDatabase._createInstance();
  static Database? _database;

  SingletonDatabase._createInstance();

  factory SingletonDatabase() {
    return _databaseHelper;
  }

  static Future<Database> get database async {

		_database ??= await initializeDatabase();

		return _database!;
	}

  static Future<Database> initializeDatabase() async {
		String path = 'appDb.db';

		var notesDatabase = await openDatabase(
      path, 
      version: 1, 
      onCreate: _createDb, 
      onConfigure: _onConfigure,
    );
		return notesDatabase;
	}

  static Future<void> _createDb(Database db, int newVersion) async {
    CountType.createTable(db);
    ExcerciseType.createTable(db);
  }

  static Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}