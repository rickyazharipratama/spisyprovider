import 'package:spisyprovider/factory/provider/student_provider.dart';

abstract class StudentCardPresenter{
  StudentProvider get provider;
  onDeleteCard(int id){ 
  }
}
