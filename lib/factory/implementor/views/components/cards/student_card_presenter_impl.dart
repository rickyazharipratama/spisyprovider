import 'package:spisyprovider/factory/provider/detail_student_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/views/components/cards/student_card/student_card_presenter.dart';

class StudentCardPresenterImpl implements StudentCardPresenter{
  late StudentProvider _provider;
  late DetailStudentProvider studentProvider;
  StudentCardPresenterImpl({required StudentProvider provider}){ 
    _provider = provider;
  }
  @override
  onDeleteCard(int id) {
    provider.deleteStudent(id: id);
  }

  @override
  StudentProvider get provider => _provider;

  @override
  DetailStudentProvider get currentStudentProvider => studentProvider;
  
  @override
  set currentStudentProvider(DetailStudentProvider dsp) {
    studentProvider = dsp;
  }
}