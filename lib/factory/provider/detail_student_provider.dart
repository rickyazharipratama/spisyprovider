import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

abstract class DetailStudentProvider with ChangeNotifier{

  StudentModel get currentStudent;
  DetailStudentEvent get currentState;
  set currentState(DetailStudentEvent newState);
  Future<void> updatingStudent({StudentModel? updatedStudent});
  void preUpdateStudent({required StudentModel updatedStudent});
}