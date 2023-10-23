import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/provider/detail_student_provider.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';
import 'package:spisyprovider/warehouse/repository_collection.dart';

class DetailStudentProviderImpl with ChangeNotifier implements DetailStudentProvider{

  StudentModel student;
  DetailStudentEvent state = DetailStudentEvent.studentLoaded;
  DetailStudentProviderImpl({required this.student});


  @override
  StudentModel get currentStudent => student;

  @override
  DetailStudentEvent get currentState => state;

  @override
  set currentState(DetailStudentEvent newState) => state = newState;

  @override
  Future<void> updatingStudent({StudentModel? updatedStudent}) async{

    if(updatedStudent != null){
      if(updatedStudent.name!.trim() != student.name){
        student.name = updatedStudent.name!.trim();
      }
      if(updatedStudent.birth != student.birth){
        student.birth = updatedStudent.birth;
      }
      if(updatedStudent.age != student.age){
        student.age = updatedStudent.age;
      }
      if(updatedStudent.gender != student.gender){
        student.gender = updatedStudent.gender;
      }
      if(updatedStudent.address!.trim() != student.address){
        student.address = updatedStudent.address!.trim();
      }
    }
    state = DetailStudentEvent.studentLoaded;
    await RepositoryCollection.repository.student.updateStudent(student: student);
    notifyListeners();
  }
  
  @override
  void preUpdateStudent({required StudentModel updatedStudent}){
    
    if(updatedStudent.name!.trim() != student.name){
      student.name = null;
    }
    if(updatedStudent.birth != student.birth){
      student.birth = null;
    }
    if(updatedStudent.age != student.age){
      student.age = null;
    }
    if(updatedStudent.gender != student.gender){
      student.gender = null;
    }
    if(updatedStudent.address!.trim() != student.address){
      student.address = null;
    }
    state = DetailStudentEvent.studentPreparing;
    notifyListeners();
  }
}