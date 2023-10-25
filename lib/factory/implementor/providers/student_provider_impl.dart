import 'package:flutter/foundation.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/Utils/log_util.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';
import 'package:spisyprovider/warehouse/repository_collection.dart';

class StudentProviderImpl with ChangeNotifier implements StudentProvider{

  List<StudentModel> _students = [];
  StudentEventResult _state = StudentEventResult.studentPrepareToFetch;



  @override
  fetchStudent() async{
    try{
      var fetch = await RepositoryCollection.repository.student.students;
      if(fetch != null){
        _students = fetch;
      }
      _state = StudentEventResult.studentPrepared;
      notifyListeners();
    }catch(e){
      if (kDebugMode) {
        LogUtil.log.write(e);
      }
    }
  }

  @override
  Future<void> insertStudent({required StudentModel student}) async{
    try{
      LogUtil.log.write("inserting data");
      await RepositoryCollection.repository.student.insertStudent(student: student);
      _state = StudentEventResult.studentInserted;
    }catch(e){
      if (kDebugMode) {
        LogUtil.log.write(e);
      }
    }
  }

  @override
  Future<void> deleteStudent({required int id}) async{
    try{
      await RepositoryCollection.repository.student.deleteStudent(id: id);
      setState(state: StudentEventResult.studentDeleted);
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
  
  @override
  void setState({required StudentEventResult state}) {
    _state = state;
    notifyListeners();
  }
  
  @override
  StudentEventResult get state => _state;
  
  @override
  List<StudentModel> get students => _students;

  @override
  void dispose() {
    LogUtil.log.write("student provider disposing");
    super.dispose();
  }
}