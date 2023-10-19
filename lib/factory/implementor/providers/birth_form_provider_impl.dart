import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/provider/birth_form_provider.dart';

class BirthFormProviderImpl with ChangeNotifier implements BirthFormProvider{
  
  int _age = 0;


  @override
  setAge(int val) {
    _age = val;
    notifyListeners();
  }
  
  @override
  int get age => _age;
}