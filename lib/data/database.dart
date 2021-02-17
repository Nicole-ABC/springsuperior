import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  final _dbName = "memberDetails.db";
  final _dbVersion = 1;

  static final memberColumnId = '_id';
  static final memberColumnSurname = 'surname';
  static final memberColumnFirstName = 'name';
  static final memberColumnDate = 'date';
  static final memberColumnActive = 'active';
  static final attendanceColumnId = 'attendanceId';
  static final attendanceColumnDate = 'attendanceDate';
  static final foreignKey = 'FK_memberInfoTable_memberAttendance';

  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    else{
      return _database = await _initDatabase();
    }
  }

  _initDatabase() async{
    Directory documents = await getApplicationDocumentsDirectory();
    String path = join(documents.path+_dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE memberInfoTable (
      $memberColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $memberColumnSurname TEXT NOT NULL, 
      $memberColumnFirstName TEXT NOT NULL,
      $memberColumnDate TEXT NOT NULL, 
      $memberColumnActive TEXT NOT NULL
      )
      ''');

    await db.execute('''
      CREATE TABLE memberAttendance (
      $attendanceColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $attendanceColumnDate STRING NOT NULL,
      $foreignKey INTEGER NOT NULL,
      FOREIGN KEY ($foreignKey) REFERENCES memberAttendance ($memberColumnId)
      )
      ''');
  }
}