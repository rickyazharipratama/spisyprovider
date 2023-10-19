import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';
import 'package:spisyprovider/views/Page/landing/landing_presenter.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';

class LandingPresenterImpl implements LandingPresenter{
  
  final LandingPageProvider provider;
  late BuildContext context;

  LandingPresenterImpl({required this.provider, required this.context});

  @override
  BuildContext get currentContext => context;

  @override
  void onBottomNavigationTapped(int index) {
    if(provider.active != index){
      print("nav button tapped");
      switch (index) {
        case 0:
          context.push(ConstantCollection.repository.routers.location.listStudent);       
          break;
        case 1 :
          context.push(ConstantCollection.repository.routers.location.logout);
          break;
        default:
      };
      provider.setActivePage(index);
    }
  }

  @override
  LandingPageProvider get currentProvider => provider;

}