import 'package:spisyprovider/factory/implementor/warehouse/databases/db_provider_impl.dart';
import 'package:spisyprovider/warehouse/databases/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class BaseDAO{

  final DBProvider db = DBProviderImpl();
  final String table;

  BaseDAO({required this.table});
  Future<Database?> get connector async{
    return await db.connector;
  }
}