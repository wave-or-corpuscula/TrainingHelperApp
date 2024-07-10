import 'package:sqflite/sqflite.dart';
import 'package:training_helper_app/utils/singleton_db.dart';

abstract class BaseModel {
  int? _id;

  int? get id => _id;

  set id(int? newId) {
    _id = newId;
  }

  // Абстрактные методы, которые должны быть реализованы в дочерних классах
  String get tableNameBase;
  String get idColumnName;
  Map<String, dynamic> toMap();
  BaseModel();
  BaseModel.fromMapObject(Map<String, dynamic> map) {
    _id = map[idColumnName];
  }

  // Общие методы запросов

  Future<List<Map<String, dynamic>>> getMapList() async {
    Database db = await SingletonDatabase.database;
    var mapList = await db.query(tableNameBase);
    return mapList;
  }

  Future<List<BaseModel>> getList() async {
    var mapList = await getMapList();
    return mapList.map((map) => fromMapObject(map)).toList();
  }

  Future<int> truncate() async {
    Database db = await SingletonDatabase.database;
    int result = await db.rawDelete('DELETE FROM $tableNameBase');
    return result;
  }

  Future<int> insert() async {
    Database db = await SingletonDatabase.database;
    int result = await db.insert(tableNameBase, toMap());
    return result;
  }

  Future<int> update() async {
    Database db = await SingletonDatabase.database;
    int result = await db.update(tableNameBase, toMap(), where: '$idColumnName = ?', whereArgs: [id]);
    return result;
  }

  Future<int> delete() async {
    Database db = await SingletonDatabase.database;
    int result = await db.delete(tableNameBase, where: '$idColumnName = ?', whereArgs: [id]);
    return result;
  }

  Future<BaseModel> get(int id) async {
    Database db = await SingletonDatabase.database;
    var mapList = await db.query(tableNameBase, where: '$idColumnName = ?', whereArgs: [id]);
    return fromMapObject(mapList[0]);
  }

  // Фабричный метод для создания экземпляра из Map
  BaseModel fromMapObject(Map<String, dynamic> map);
}