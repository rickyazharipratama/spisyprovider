import 'package:flutter/material.dart';

abstract class ButtonFormBehaviourProvider with ChangeNotifier{

  void enablingButton(bool value);
  bool? get isButtonEnabled;
}
