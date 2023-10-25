import 'package:pratama_form_field_factory/builders/form_builder/pratama_form_builder_presenter.dart';
import 'package:pratama_form_field_factory/pickers/pratama_date_time_picker/pratama_date_time_picker_presenter.dart';
import 'package:pratama_form_field_factory/radios/pratama_radio_presenter.dart';
import 'package:pratama_form_field_factory/text_field/pratama_text_field_presenter.dart';
import 'package:spisyprovider/factory/raw_material/student_material.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

abstract class FormPresenter extends StudentMaterial{

  
  StudentModel? get existingStudent;
  PratamaTextFieldPresenter get nameTextPresenter;
  PratamaTextFieldPresenter get alamatTextPresenter;
  PratamaTextFieldPresenter get umurPresenter;
  PratamaDateTimePickerPresenter get birthPresenter;
  PratamaRadioPresenter get genderPresenter;
  PratamaFormBuilderPresenter get currentFormPresenter;
  onInsertStudent();
  StudentModel onUpdateStudent();
  bool isStudentNeedUpdate();
}
