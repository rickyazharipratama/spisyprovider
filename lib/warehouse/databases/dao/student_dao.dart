import 'package:spisyprovider/warehouse/databases/dao/base_dao.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

abstract class StudentDAO extends BaseDAO{
  
  StudentDAO({required super.table});
  Future<List<StudentModel>?> getStudents();
  Future<StudentModel?> getStudent({required int id});
  Future<int?> insertStudent({required StudentModel student});
  Future<int?> deleteStudent({required int id});
  Future<int?> updateStudent({required StudentModel student});
}
