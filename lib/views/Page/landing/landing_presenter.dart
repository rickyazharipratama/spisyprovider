import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';

abstract class LandingPresenter{

  LandingPageProvider get currentProvider;
  BuildContext get currentContext;
  void onBottomNavigationTapped(int index);
}