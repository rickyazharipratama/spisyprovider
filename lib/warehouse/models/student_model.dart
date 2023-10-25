import 'package:spisyprovider/factory/Utils/log_util.dart';

class StudentModel{

  int? id;
  String? name;
  DateTime? birth;
  int? age;
  bool? gender;
  String? address;

  StudentModel({
    this.id,
    this.name,
    this.birth,
    this.age,
    this.gender,
    this.address
  });

  factory StudentModel.fromJson(Map<String,dynamic> json) {
    LogUtil.log.write("student from database");
    LogUtil.log.write(json);
    return StudentModel(
      id: json['id'],
      name: json['name'],
      birth: DateTime.tryParse(json['birth']),
      age: json['age'],
      gender: json['gender']  != null ? json['gender'] == 1 ? true : json['gender'] == 0 ? false : null : null,
      address: json['address'] 
    );
  }

  Map<String,dynamic> get toJson =>{
    'id' : id,
    'name': name,
    'birth': birth!.toIso8601String(),
    'age':age,
    'gender': gender! ? 1 :0,
    'address': address
  };
}