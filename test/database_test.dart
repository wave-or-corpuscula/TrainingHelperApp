// import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:training_helper_app/utils/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  
  test('Testing database initialization', () {
    print("App started");
    DatabaseHelper helper = DatabaseHelper();
    helper.database.then((db) {
      print("Database initialized!");
      // runApp(const TestApp());
    });
    print("App finished");
  });
}


// class TestApp extends StatelessWidget {

//   const TestApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Training Helper',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const Scaffold(),
//     );
//   }
// }