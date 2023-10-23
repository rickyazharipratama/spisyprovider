import 'package:spisyprovider/factory/provider/detail_student_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';

abstract class StudentCardPresenter{
  StudentProvider get provider;
  DetailStudentProvider get currentStudentProvider;
  set currentStudentProvider(DetailStudentProvider dsp);
  onDeleteCard(int id){ 
  }
}
