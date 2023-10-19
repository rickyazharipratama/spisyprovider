import 'package:flutter/material.dart';
import 'package:pratama_form_field_factory/pickers/pratama_date_time_picker/pratama_date_time_picker_presenter.dart';
import 'package:pratama_form_field_factory/radios/models/pratama_radio_model.dart';
import 'package:pratama_form_field_factory/radios/pratama_radio_presenter.dart';
import 'package:pratama_form_field_factory/text_field/pratama_text_field_presenter.dart';
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

  FormPresenterImpl({ required StudentProvider provider, StudentModel? existingStudent}){
    _provider = provider;
    _existingStudent = existingStudent ?? StudentModel();

    _nameTextPresenter = PratamaTextFieldPresenter(
      keyboardType: TextInputType.name,
      label: "Nama",
      val: existingStudent?.name,
      validator: onNameValidation
    );

    _alamatTextPresenter = PratamaTextFieldPresenter(
      keyboardType: TextInputType.streetAddress,
      label: "Alamat",
      maxLine: 3,
      val: existingStudent?.address,
      validator: onAddressValidation
    );

    _umurPresenter = PratamaTextFieldPresenter(
      isReadOnly: true,
      label: "Umur",
      val: existingStudent?.age != null ? existingStudent?.age.toString() : "",
      controller: TextEditingController(text: existingStudent?.age != null ? "${existingStudent?.age} Tahun" : "")
    );

    _birthPresenter = PratamaDateTimePickerPresenter(
      label: "Tanggal Lahir",
      initialDate: existingStudent?.birth,
      maxDateTime: DateTime.now(),
      validator: onBirthValidation,
      onSelectedDate: onSelectedBirth
    );

    _genderPresenter = PratamaRadioPresenter(
      groups: [
        PratamaRadioModel(value: true, title: "Pria"),
        PratamaRadioModel(value: false, title: "Wanita")
      ],
      label: "Jenis Kelamin",
      validator: onGenderValidation,
      selectedValue: existingStudent != null ? existingStudent!.gender : null
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
  }

  
  @override
  onInsertStudent() async{
    StudentModel student = StudentModel(
      name: _nameTextPresenter.textController.value.text,
      birth: _birthPresenter.selectedDate,
      age: int.tryParse(_umurPresenter.val!),
      gender: _genderPresenter.selectedValue,
      address: _alamatTextPresenter.textController.value.text
    );
    print("insert from form call");
    await _provider.insertStudent(student: student);
  }


  @override
  onUpdateStudent() async{
    StudentModel student = StudentModel(
      id: _existingStudent?.id,
      name: _nameTextPresenter.textController.value.text,
      birth: _birthPresenter.selectedDate,
      age: int.tryParse(_umurPresenter.val!),
      gender: _genderPresenter.selectedValue,
      address: _alamatTextPresenter.textController.value.text
    );
    await _provider.updateStudent(student: student);
  }
}