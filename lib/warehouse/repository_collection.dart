import 'package:spisyprovider/factory/implementor/warehouse/student_repository_impl.dart';
import 'package:spisyprovider/factory/implementor/warehouse/user_repository_impl.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';
import 'package:spisyprovider/warehouse/models/user_authentication.dart';

class RepositoryCollection{

  static final RepositoryCollection repository = RepositoryCollection();

  final UserRepository user = UserRepositoryImpl();
  final StudentRepository student = StudentRepositoryImpl();

}

abstract class UserRepository{
  Future<UserAuthentication?> get activeUser;
  Future<int?> createUser(UserAuthentication user);
  Future<int?> deleteUser();
}

abstract class StudentRepository{
  

  Future<List<StudentModel>?> get students;
  Future<StudentModel?> student({required int id}); 
  Future<int?> insertStudent({required StudentModel student});
  Future<int?> updateStudent({required StudentModel student});
  Future<int?> deleteStudent({required int id});
}
