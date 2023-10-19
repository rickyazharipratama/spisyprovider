import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';
import 'package:spisyprovider/warehouse/databases/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProviderImpl implements DBProvider{
  
  Database? _connector;

  Future<Database>? _createDatabse() async{
    Directory dir = await getApplicationDocumentsDirectory();
    return await openDatabase(
      join(dir.path,"students.db"),
      version: 1,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
  }

  @override
  Future<Database?> get connector async{
    _connector ??= await _createDatabse();
    return _connector;
  }

  void initDB(Database database, int version) async{
    await database.execute(
      "CREATE TABLE ${ConstantCollection.repository.database.tableStudent} ("
        "id INTEGER PRIMARY KEY, "
        "name TEXT, "
        "birth TEXT, "
        "age int, "
        "gender int,"
        "address TEXT"
      ")"
    );
    await database.execute(
      "CREATE TABLE ${ConstantCollection.repository.database.tableUser} ("
        "id INTEGER PRIMARY KEY, "
        "username TEXT, "
        "valid  TEXT"
      ")"
    );
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

}