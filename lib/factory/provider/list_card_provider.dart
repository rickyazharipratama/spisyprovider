import 'package:flutter/material.dart';

abstract class ListCardProvider with ChangeNotifier{

  int get activePage;

  setActivePage(int index);
  silentActivePage(int index);
}
