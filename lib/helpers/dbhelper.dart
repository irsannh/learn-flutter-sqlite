import 'dart:io'; // Importing dart:io for Directory

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:learn_sqlite/models/absensi.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database; // Static member

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'absensi.db';

    var todoDatabase = await openDatabase(path, version: 1, onCreate: _createDb); // await openDatabase

    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE absensi (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        status_hadir TEXT
      )
    '''
    );
  }

  // Getter for accessing the database instance
  static Future<Database> get database async {
    if (_database == null) {
      _database = await _dbHelper!.initDb();
    }
    return _database!;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await DbHelper.database;
    var mapList = await db.query('absensi', orderBy: 'nama');
    return mapList;
  }

  Future<int> create(Absensi object) async {
    Database db = await DbHelper.database;
    int count = await db.insert('absensi', object.toMap());
    return count;
  }

  Future<int> update(Absensi object) async {
    Database db = await DbHelper.database;
    int count = await db.update('absensi', object.toMap(),
      where: 'id=?',
      whereArgs: [object.id]
    );
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await DbHelper.database;
    int count = await db.delete('absensi',
        where: 'id=?',
        whereArgs: [id]
    );
    return count;
  }

  Future<List<Absensi>> getAbsensiList() async {
    var absensiMapList = await select();
    int count = absensiMapList.length;
    List<Absensi> absensiList = <Absensi>[];
    for (int i = 0; i < count; i++) {
      absensiList.add(Absensi.fromMap(absensiMapList[i]));
    }
    return absensiList;
  }

}
