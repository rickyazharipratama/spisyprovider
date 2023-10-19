import 'package:flutter/material.dart';

abstract class BirthFormProvider with ChangeNotifier{
  int get age;
  setAge(int val);
}
