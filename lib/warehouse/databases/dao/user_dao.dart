import 'package:spisyprovider/warehouse/databases/dao/base_dao.dart';
import 'package:spisyprovider/warehouse/models/user_authentication.dart';

abstract class UserDAO extends BaseDAO{
  UserDAO({required super.table});

  Future<UserAuthentication?> get activeUSer;
  Future<int> insertUsername(UserAuthentication user);
  Future<int> deleteUser();
}
