import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';
import 'package:spisyprovider/views/views/fragments/logout/logout_presenter.dart';

class LogoutPresenterImpl implements LogoutPresenter{

  final BuildContext context;
  LogoutPresenterImpl({required this.context});
  
  @override
  BuildContext get currentContext => context;
  
  @override
  Future<void> onLogoutTapped() async{
    if(context.mounted){
      UserProvider user = context.read<UserProvider>();
      await user.userLogOut();
    }
  }
}