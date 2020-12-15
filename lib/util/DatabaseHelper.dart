import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _instancia;
  static Database _database;

  DatabaseHelper._criarInstancia();

  factory DatabaseHelper() {
    if (_instancia == null) {
      _instancia = DatabaseHelper._criarInstancia();
    }

    return _instancia;
  }

  Future<Database> inicializarDatabase() async {
    Directory diretorio = await getApplicationDocumentsDirectory();
    String caminho = diretorio.path + "banco.db";

    return await openDatabase(caminho, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute("Create table cliente(cd_cliente integer primary key autoincrement, nm_cliente text)");
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await inicializarDatabase();
    }

    return _database;
  }

  Future<List<Map<String, dynamic>>> getSQLSelect(String sql, [List<dynamic> parametros]) async {
    Database db = await this.database;
    return await db.rawQuery(sql, parametros);
  }

  Future<int> insertSQL(String sql, [List<dynamic> parametros]) async {
    Database db = await this.database;
    return await db.rawInsert(sql, parametros);
  }

  Future<int> updateSQL(String sql, [List<dynamic> parametros]) async {
    Database db = await this.database;
    return await db.rawUpdate(sql, parametros);
  }

  Future<int> deleteSQL(String sql) async {
    Database db = await this.database;
    return await db.rawDelete(sql);
  }
}
