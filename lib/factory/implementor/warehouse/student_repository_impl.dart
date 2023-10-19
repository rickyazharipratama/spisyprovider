import 'package:spisyprovider/factory/implementor/warehouse/databases/dao/student_dao_impl.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';
import 'package:spisyprovider/warehouse/databases/dao/student_dao.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';
import 'package:spisyprovider/warehouse/repository_collection.dart';

class StudentRepositoryImpl implements StudentRepository{
  
  final StudentDAO _dao = StudentDAOimpl(table: ConstantCollection.repository.database.tableStudent);

  @override
  Future<int?> deleteStudent({required int id}) => _dao.deleteStudent(id: id);

  @override
  Future<int?> insertStudent({required StudentModel student}) => _dao.insertStudent(student: student);

  @override
  Future<StudentModel?> student({required int id}) => _dao.getStudent(id: id);

  @override
  Future<List<StudentModel>?> get students => _dao.getStudents();

  @override
  Future<int?> updateStudent({required StudentModel student}) => _dao.updateStudent(student: student);

}

