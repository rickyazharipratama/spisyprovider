import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/provider/list_card_provider.dart';

class ListCatdProviderImpl with ChangeNotifier implements ListCardProvider{

  int _activePage = 0;

  @override
  int get activePage => _activePage;

  @override
  setActivePage(int index) {
    _activePage = index;
    notifyListeners();
  }
  
  @override
  silentActivePage(int index) {
    _activePage = index;
  }

}