import 'dart:developer';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:training_helper_app/models/excercise_type.dart';


void main() {

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  
  test('Testing functions of ExcerciseType model', () async {
    // ExcerciseType newType = ExcerciseType('Pulling', 'amount', 1);

    var exList = [
      ExcerciseType('Pulling', 'times', 2),
      ExcerciseType('Pushing', 'times', 2),
      ExcerciseType('Holding', 's', 1),
    ];

    await ExcerciseType.truncate();

    await getRecordsWithTitle('Before insert');

    for (int i = 0; i < exList.length; i++) {
      await ExcerciseType.insert(exList[i]);
    }

    await getRecordsWithTitle('\nAfter insert');

    
    var exListfromDb = await ExcerciseType.getList();
    exListfromDb[0].name = 'New name';
    await ExcerciseType.update(exListfromDb[0]);

    await getRecordsWithTitle('\nAfter udate');

    await ExcerciseType.delete(exListfromDb[1]);

    await getRecordsWithTitle('\nAfter delete');
  });
}

Future<void> getRecordsWithTitle(String title) async {
  log(title);
  var records = await ExcerciseType.getList();
  for (int i = 0; i < records.length; i++) {
    log('${records[i].id}: ${records[i].name} ${records[i].postfix} ${records[i].count_type_id}');
  }
}