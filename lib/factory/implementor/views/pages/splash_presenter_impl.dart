import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';
import 'package:spisyprovider/views/Page/splash/splash_presenter.dart';
import 'package:spisyprovider/warehouse/constant_collection.dart';

class SplashPresenterImpl implements SplashPresenter{

  final UserProvider provider;

  SplashPresenterImpl({required this.provider});

  @override
  UserProvider get currentProvider => provider;

  @override
  retrievingUser(BuildContext context) async{
    await Future.delayed(
      const Duration(seconds: 2),
      (){}
    ).whenComplete(() async{
      if(provider.state == UserAuthenticationState.userValidating){
        await provider.retrieveActiveUser().whenComplete((){
          if(provider.state == UserAuthenticationState.userLoggedOut){
            context.go(ConstantCollection.repository.routers.location.login);
          }else if(provider.state == UserAuthenticationState.userLoggedIn){
            context.go(ConstantCollection.repository.routers.location.listStudent);
          }
        });
      }
    });
  }

  @override
  Future<void> validatingUser() async{
    await Future.delayed(
      const Duration(milliseconds: 500),
      (){}
    ).whenComplete(() => provider.setUserState(UserAuthenticationState.userValidating));
  }
}