import 'dart:developer';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:training_helper_app/models/count_type.dart';


void main() {

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  
  test('Testing CountType model functions', () async {

    var cType1 = CountType('Время');
    var cType2 = CountType('Количество');

    await CountType.truncate();

    await CountType.insert(cType1);
    await CountType.insert(cType2);

    var cTList = await CountType.getList();
    
    log('Before changes');
    for (int i = 0; i < cTList.length; i++) {
      log('${cTList[i].id}, ${cTList[i].name}');
    }

    cTList[0].name = 'Новое имя';
    await CountType.update(cTList[0]);
    log('Changed');

    log('After changes');
    cTList = await CountType.getList();
    for (int i = 0; i < cTList.length; i++) {
      log('${cTList[i].id}, ${cTList[i].name}');
    }

    await CountType.delete(cTList[1]);
    log('Deleted');
    
    log('After deletion');
    cTList = await CountType.getList();
    for (int i = 0; i < cTList.length; i++) {
      log('${cTList[i].id}, ${cTList[i].name}');
    }
  });
}