import 'package:pratama_form_field_factory/pickers/pratama_date_time_picker/pratama_date_time_picker_presenter.dart';
import 'package:pratama_form_field_factory/radios/pratama_radio_presenter.dart';
import 'package:pratama_form_field_factory/text_field/pratama_text_field_presenter.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

abstract class FormPresenter{

  StudentProvider get provider;
  StudentModel? get existingStudent;
  PratamaTextFieldPresenter get nameTextPresenter;
  PratamaTextFieldPresenter get alamatTextPresenter;
  PratamaTextFieldPresenter get umurPresenter;
  PratamaDateTimePickerPresenter get birthPresenter;
  PratamaRadioPresenter get genderPresenter;
  onInsertStudent();
  onUpdateStudent();
}
