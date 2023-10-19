import 'package:sqflite/sqflite.dart';

abstract class DBProvider{
  Future<Database?> get connector;
}
