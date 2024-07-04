import 'package:flutter/material.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:training_helper_app/screens/admin/tables_choice_screen.dart';
import 'package:training_helper_app/screens/admin/count_type_records.dart';


void main() {

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const TableChoice(),
        '/count_type_records': (context) => const CountTypeRecords(),
      },
    )
  );
}

