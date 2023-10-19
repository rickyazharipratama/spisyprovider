import 'package:flutter/foundation.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

abstract class StudentProvider with ChangeNotifier{

  Future<void> fetchStudent();
  Future<void> insertStudent({required StudentModel student});
  Future<void> updateStudent({required StudentModel student});
  Future<void> deleteStudent({required int id});
  void setState({required StudentEventResult state});
  List<StudentModel> get students;
  StudentEventResult get state;
}