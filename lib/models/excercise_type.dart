import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:training_helper_app/utils/helper_exception.dart';


class ExcerciseType {
  int? _id;
  String _name;
  String _postfix;
  int _count_type_id;

  static String excerciseTypeTable = 'ExcerciseType';
  static String colId = 'id';
  static String colName = 'name';
  static String colPostfix = 'postfix';
  static String colCountTypeId = 'count_type_id';

  ExcerciseType(this._name, this._postfix, this._count_type_id);

  int? get id => _id;
  String get name => _name; 
  String get postfix => _postfix;
  int get count_type_id => _count_type_id;
  // String get count_type => 
}