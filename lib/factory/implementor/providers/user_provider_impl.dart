import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/Utils/log_util.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';
import 'package:spisyprovider/warehouse/models/user_authentication.dart';
import 'package:spisyprovider/warehouse/models/user_login.dart';
import 'package:spisyprovider/warehouse/repository_collection.dart';

class UserProviderImpl with ChangeNotifier implements UserProvider{
  UserAuthentication? _user;
  UserAuthenticationState _state = UserAuthenticationState.userPreparing;
  LoginState _loginState = LoginState.prepareLogin;
  final String _loginKey = "spisy10mobile";

  
  UserProviderImpl({UserAuthentication? user}){
    _user = user;
  }

  String get loginKey => _loginKey;
  
  @override
  Future<void> retrieveActiveUser() async{
     _user = await RepositoryCollection.repository.user.activeUser;
    if(user == null){
      _state = UserAuthenticationState.userLoggedOut;
    }else{
      _state = UserAuthenticationState.userLoggedIn;
    }
    notifyListeners();
  }
  
  @override
  setUserState(UserAuthenticationState state) {
    ("change user state");
    _state = state;
    notifyListeners();
  }
  
  @override
  UserAuthentication? get user => _user;
  
  @override
  Future<LoginState> userLogIn(UserLogin user) async{
    try{
      if(user.username == loginKey && user.password == loginKey){
        UserAuthentication auth = UserAuthentication(
          username: user.username,
          valid: DateTime.now()
        );
        await RepositoryCollection.repository.user.createUser(auth);
        _user = auth;
        _state = UserAuthenticationState.userLoggedIn;
        _loginState = LoginState.loginSuccess;
      }else{
        _loginState = LoginState.loginfailed;
        notifyListeners();
      }
    }catch (e){
      _loginState = LoginState.loginfailed;
      notifyListeners();
      LogUtil.log.write(e);
    }
    return _loginState;
  }
  
  @override
  Future<void> userLogOut() async{
    try{
      await RepositoryCollection.repository.user.deleteUser();
      _state = UserAuthenticationState.userLoggedOut;
      _user = null;
    }catch(e){
      LogUtil.log.write(e);
    }
  }
  
  @override
  LoginState get loginState => _loginState;
  
  @override
  UserAuthenticationState get state => _state;
  
}