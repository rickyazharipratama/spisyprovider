import 'package:flutter/material.dart';
import 'package:pratama_form_field_factory/builders/form_builder/pratama_form_builder_presenter.dart';
import 'package:pratama_form_field_factory/pickers/pratama_date_time_picker/pratama_date_time_picker_presenter.dart';
import 'package:pratama_form_field_factory/radios/models/pratama_radio_model.dart';
import 'package:pratama_form_field_factory/radios/pratama_radio_presenter.dart';
import 'package:pratama_form_field_factory/text_field/pratama_text_field_presenter.dart';
import 'package:spisyprovider/factory/Utils/log_util.dart';
import 'package:spisyprovider/factory/provider/button_form_behaviour_provider.dart';
import 'package:spisyprovider/factory/provider/student_provider.dart';
import 'package:spisyprovider/views/Page/form/form_presenter.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';
import 'package:spisyprovider/warehouse/models/student_model.dart';

class FormPresenterImpl implements FormPresenter{

  late StudentProvider _provider;
  late StudentModel _existingStudent;

  late PratamaTextFieldPresenter _nameTextPresenter;
  late PratamaTextFieldPresenter _alamatTextPresenter;
  late PratamaTextFieldPresenter _umurPresenter;

  late PratamaDateTimePickerPresenter  _birthPresenter;
  late PratamaRadioPresenter _genderPresenter;

  final ButtonFormBehaviourProvider? buttonProvider;
  final PratamaFormBuilderPresenter formPresenter = PratamaFormBuilderPresenter();

  FormPresenterImpl({ 
    required StudentProvider provider, 
    StudentModel? existingStudent,
    this.buttonProvider}){
    _provider = provider;
    _existingStudent = existingStudent ?? StudentModel();

    _nameTextPresenter = PratamaTextFieldPresenter(
      keyboardType: TextInputType.name,
      label: "Nama",
      val: existingStudent?.name,
      validator: onNameValidation,
      onChange: changeButtonBehaviour,
      onEditingComplete: (){
        birthPresenter.textPresenter.textNode.requestFocus();
        birthPresenter.textPresenter.onTap?.call();
      }
    );

    _alamatTextPresenter = PratamaTextFieldPresenter(
      keyboardType: TextInputType.streetAddress,
      label: "Alamat",
      maxLine: 3,
      val: existingStudent?.address,
      validator: onAddressValidation,
      onChange: changeButtonBehaviour,
      onEditingComplete: () => _alamatTextPresenter.textNode.unfocus(),
    );

    _umurPresenter = PratamaTextFieldPresenter(
      isReadOnly: true,
      label: "Umur",
      isEnabled: false,
      val: existingStudent?.age != null ? existingStudent?.age.toString() : "",
      controller: TextEditingController(text: existingStudent?.age != null ? "${existingStudent?.age} Tahun" : "")
    );

    _birthPresenter = PratamaDateTimePickerPresenter(
      label: "Tanggal Lahir",
      initialDate: existingStudent?.birth,
      maxDateTime: DateTime.now(),
      validator: onBirthValidation,
      onSelectedDate: onSelectedBirth,
    );

    _genderPresenter = PratamaRadioPresenter(
      groups: [
        PratamaRadioModel(value: true, title: "Pria"),
        PratamaRadioModel(value: false, title: "Wanita")
      ],
      label: "Jenis Kelamin",
      validator: onGenderValidation,
      selectedValue: existingStudent?.gender,
      onExtendedSelectedRadio: changeButtonBehaviour
    );
  }

  @override
  PratamaTextFieldPresenter get alamatTextPresenter => _alamatTextPresenter;

  @override
  PratamaDateTimePickerPresenter get birthPresenter => _birthPresenter;

  @override
  StudentModel? get existingStudent => _existingStudent;

  @override
  PratamaRadioPresenter get genderPresenter => _genderPresenter;

  @override
  PratamaTextFieldPresenter get nameTextPresenter => _nameTextPresenter;

  @override
  PratamaTextFieldPresenter get umurPresenter => _umurPresenter;

  @override
  StudentProvider get provider => _provider;

  String? onNameValidation(String? val){
    if(val!= null){
      if(val.isEmpty){
        return ConstantCollection.repository.errors.nameFormEmpty;
      }
    }
    return null;
  }

  void changeButtonBehaviour(dynamic val){
    if(buttonProvider != null){
      buttonProvider!.enablingButton(isStudentNeedUpdate());
    }
  }

  String? onAddressValidation(String? val){
    if(val != null){
      if(val.isEmpty){
        return ConstantCollection.repository.errors.addressFormEmpty;
      }
    }
    return null;
  }

  String? onBirthValidation(String? val){
    if(val != null){
      if(val.isEmpty){
        return ConstantCollection.repository.errors.birthFormEmpty;
      }
    }
    return null;
  }

  String? onGenderValidation(dynamic val){
    if(val == null){
      return ConstantCollection.repository.errors.genderUnselected;
    }
    return null;
  }

  onSelectedBirth(){
    int diff = _birthPresenter.diffYearDuration;
    _umurPresenter.val = diff.toString();
    _umurPresenter.textController.value = TextEditingValue(text: "$diff Tahun");
    changeButtonBehaviour(_umurPresenter.textController.value.text);
  }

  
  @override
  onInsertStudent() async{
    StudentModel student = StudentModel(
      name: _nameTextPresenter.textController.value.text.trim(),
      birth: _birthPresenter.selectedDate,
      age: int.tryParse(_umurPresenter.val!),
      gender: _genderPresenter.selectedValue,
      address: _alamatTextPresenter.textController.value.text.trim()
    );
    LogUtil.log.write("insert from form call");
    await _provider.insertStudent(student: student);
  }


  @override
  StudentModel onUpdateStudent(){
    StudentModel student = StudentModel(
      id: _existingStudent.id,
      name: _nameTextPresenter.textController.value.text.trim(),
      birth: _birthPresenter.selectedDate,
      age: int.tryParse(_umurPresenter.val!),
      gender: _genderPresenter.selectedValue,
      address: _alamatTextPresenter.textController.value.text.trim()
    );
    return student;
  }

  @override
  bool isStudentNeedUpdate(){
    return _existingStudent.name != _nameTextPresenter.textController.value.text.trim()
    || _existingStudent.birth != _birthPresenter.selectedDate
    || _existingStudent.age != int.tryParse(_umurPresenter.val!)
    || _existingStudent.gender != _genderPresenter.selectedValue
    || _existingStudent.address != _alamatTextPresenter.textController.value.text.trim();
  }
  
  @override
  PratamaFormBuilderPresenter get currentFormPresenter => formPresenter;
}