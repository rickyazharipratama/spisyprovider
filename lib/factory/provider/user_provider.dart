import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/warehouse/models/user_login.dart';
import 'package:spisyprovider/warehouse/models/user_authentication.dart';

abstract class UserProvider with ChangeNotifier{


  UserProvider({UserAuthentication? user});
  UserAuthentication? get user;
  UserAuthenticationState get state;
  LoginState get loginState;
  Future<void> retrieveActiveUser();
  Future<LoginState> userLogIn(UserLogin user);
  Future<void> userLogOut();
  setUserState(UserAuthenticationState state);
}
