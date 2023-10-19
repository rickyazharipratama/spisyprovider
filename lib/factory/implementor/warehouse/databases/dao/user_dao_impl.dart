import 'package:spisyprovider/warehouse/databases/dao/base_dao.dart';
import 'package:spisyprovider/warehouse/databases/dao/user_dao.dart';
import 'package:spisyprovider/warehouse/models/user_authentication.dart';

class UserDAOImpl extends BaseDAO implements UserDAO{
  
  UserDAOImpl({required super.table});

  @override
  Future<UserAuthentication?> get activeUSer async{
    var result = await connector.then((value) => value!.query(table));
    List<UserAuthentication> user = result.isNotEmpty ? result.map((e) => UserAuthentication.fromJson(e)).toList():[];
    return user.isEmpty? null : user[0];
  }

  @override
  Future<int> deleteUser() =>
    connector.then((value) => value!.delete(table));

  @override
  Future<int> insertUsername(UserAuthentication user) =>
    connector.then((value) => value!.insert(table, user.toJson()));

}