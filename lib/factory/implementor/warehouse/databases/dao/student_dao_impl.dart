import 'package:spisyprovider/warehouse/databases/dao/base_dao.dart';
import 'package:spisyprovider/warehouse/databases/dao/student_dao.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

class StudentDAOimpl extends BaseDAO implements StudentDAO{

  StudentDAOimpl({required super.table});

  @override
  Future<int?> deleteStudent({required int id}) async =>
    await connector.then((value) => value!.delete(table,where: "id= ?",whereArgs: [id]));

  @override
  Future<StudentModel?> getStudent({required int id}) async{
    List<Map<String,dynamic>>? res = await connector.then((value) => 
      value!.query(table,
        where: "id= ?",
        whereArgs: [id]
      )
    );
    if(res != null){
      return StudentModel.fromJson(res[0]);
    }
    return null;
  }
    

  @override
  Future<List<StudentModel>?> getStudents() async{
    List<Map<String,dynamic>> result = await connector.then((value) => value!.query(table));
    return result.map((e) => StudentModel.fromJson(e)).toList(); 
  }

  @override
  Future<int?> insertStudent({required StudentModel student}) =>
    connector.then((value)=>
      value!.insert(table, student.toJson));

  @override
  Future<int?> updateStudent({required StudentModel student}) =>
    connector.then((value) => value!.update(table, student.toJson,where: "id= ?",whereArgs: [student.id]));
}