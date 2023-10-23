import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/provider/button_form_behaviour_provider.dart';

class ButtonFormBehaviourProviderImpl with ChangeNotifier implements ButtonFormBehaviourProvider{

  bool? isEnabled  = false;

  ButtonFormBehaviourProviderImpl({this.isEnabled});

  @override
  void enablingButton(bool value) {
    if(isEnabled != value){
       isEnabled = value;
       notifyListeners();
    }
  }

  @override
  bool? get isButtonEnabled => isEnabled;
}