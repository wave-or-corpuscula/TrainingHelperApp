import 'package:flutter_test/flutter_test.dart';

import 'package:training_helper_app/utils/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  
  test('Testing database initialization', () async {
    print("App started");
    DatabaseHelper helper = DatabaseHelper();
    await helper.database;
    print("App finished");
  });
}