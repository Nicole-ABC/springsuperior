import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructo();

  static final DatabaseHelper instance = DatabaseHelper. _privateConstructo();

  final _dbName = "memberDetails.db";
  final _dbVersion = 1;

  static final columnId = '_id';
  static final columnSurname = 'surname';
  static final columnFirstName = 'name';
  static final columnDate = 'date';
  static final columnActive = 'active';

  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }
    else{
      _database = await _initDatabase();
    }
  }

  _initDatabase() async{
    Directory documents = await getApplicationDocumentsDirectory();
    String path = join(documents.path+_dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: await _onCreate);
  }

  Future _onCreate(Database db, int version) async{
    await db.execute(
        '''
      CREATE TABLE memberInfoTable (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnSurname TEXT NOT NULL, 
      $columnFirstName TEXT NOT NULL,
      $columnDate TEXT NOT NULL, 
      $columnActive TEXT NOT NULL)
      '''
    );
  }
}