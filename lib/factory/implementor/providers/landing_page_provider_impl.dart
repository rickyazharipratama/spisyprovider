import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';

class LandingPageProviderImpl with ChangeNotifier implements LandingPageProvider{
  int _active = 0;
  
  @override
  setActivePage(int index) {
    _active = index;
    notifyListeners();
  }
  
  @override
  int get active => _active;
}