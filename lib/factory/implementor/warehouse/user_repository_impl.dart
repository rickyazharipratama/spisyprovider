import 'package:spisyprovider/factory/implementor/warehouse/databases/dao/user_dao_impl.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';
import 'package:spisyprovider/warehouse/databases/dao/user_dao.dart';
import 'package:spisyprovider/warehouse/models/user_authentication.dart';
import 'package:spisyprovider/warehouse/repository_collection.dart';

class UserRepositoryImpl implements UserRepository{
 
  final UserDAO _dao = UserDAOImpl(table: ConstantCollection.repository.database.tableUser);

  @override
  Future<UserAuthentication?> get activeUser =>
    _dao.activeUSer;

  @override
  Future<int?> createUser(UserAuthentication user) =>
    _dao.insertUsername(user);

  @override
  Future<int?> deleteUser() =>
    _dao.deleteUser();
}
