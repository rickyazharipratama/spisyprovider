import 'package:spisyprovider/factory/provider/detail_student_provider.dart';
import 'package:spisyprovider/factory/raw_material/student_material.dart';

abstract class DetailStudentMaterial extends StudentMaterial{
  DetailStudentProvider get currentStudentProvider;
  set currentStudentProvider(DetailStudentProvider dsp);
}