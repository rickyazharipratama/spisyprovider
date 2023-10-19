import 'package:flutter/material.dart';

abstract class LandingPageProvider with ChangeNotifier{
  
  setActivePage(int index){}
  int get active;
}
