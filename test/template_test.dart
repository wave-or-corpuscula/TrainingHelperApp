import 'dart:developer';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  
  test('New test', () async {
    
  });
}