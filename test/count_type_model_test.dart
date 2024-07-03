import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:training_helper_app/utils/db_helper.dart';
import 'package:training_helper_app/models/count_type.dart';


void main() {

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  
  test('Testing CountType model functions', () async {
    DatabaseHelper helper = DatabaseHelper();

    var cType1 = CountType('Время');
    var cType2 = CountType('Количество');

    await helper.truncateCountType();

    await helper.insertCountType(cType1);
    await helper.insertCountType(cType2);

    var cTList = await helper.getCountTypeList();
    
    log('Before changes');
    for (int i = 0; i < cTList.length; i++) {
      log('${cTList[i].id}, ${cTList[i].name}');
    }

    cTList[0].name = 'Новое имя';
    await helper.updateCountType(cTList[0]);
    log('Changed');

    log('After changes');
    cTList = await helper.getCountTypeList();
    for (int i = 0; i < cTList.length; i++) {
      log('${cTList[i].id}, ${cTList[i].name}');
    }

    await helper.deleteCountType(cTList[1]);
    log('Deleted');
    
    log('After deletion');
    cTList = await helper.getCountTypeList();
    for (int i = 0; i < cTList.length; i++) {
      log('${cTList[i].id}, ${cTList[i].name}');
    }
  });
}