import 'dart:developer';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:training_helper_app/models/excercise_type.dart';


void main() {

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  
  test('Testing functions of ExcerciseType model', () async {
    ExcerciseType newType = ExcerciseType('Pulling', 'amount', 1);

    await ExcerciseType.insert(newType);

    // TODO: Write tests for all methods
  });
}