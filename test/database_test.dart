import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';

import 'package:training_helper_app/utils/singleton_db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  
  test('Testing database initialization', () async {
    log('App started');
    Database db = await SingletonDatabase.database;
    log('App finished');
  });
}