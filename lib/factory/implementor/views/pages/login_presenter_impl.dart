import 'package:flutter/material.dart';
import 'package:pratama_form_field_factory/text_field/pratama_text_field_presenter.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';
import 'package:spisyprovider/views/Page/login/login_presenter.dart';
import 'package:spisyprovider/warehouse/models/user_login.dart';

class LoginPresenterImpl implements LoginPresenter{

  final UserProvider provider;
  final BuildContext context;
  late PratamaTextFieldPresenter usernameTextPresenter;
  late PratamaTextFieldPresenter passwordTextPresenter;


  LoginPresenterImpl({required this.provider, required this.context}){
    usernameTextPresenter = PratamaTextFieldPresenter(
      keyboardType: TextInputType.name,
      label: "Nama Pengguna",
      validator: onUsernameValidation
    );

    passwordTextPresenter = PratamaTextFieldPresenter(
      label: "Kata Sandi",
      keyboardType: TextInputType.name,
      isObscured: true,
      validator: onPasswordValidation
    );

  }

  @override
  PratamaTextFieldPresenter get currentPasswordTextPresenter => passwordTextPresenter;

  @override
  PratamaTextFieldPresenter get currentUsernameTextPresenter => usernameTextPresenter;

  @override
  Future<LoginState> authenticatiog() async{
    UserLogin login = UserLogin(
      username: usernameTextPresenter.textController.value.text,
      password: passwordTextPresenter.textController.value.text
    );
    return await provider.userLogIn(login);
  }

  String? onUsernameValidation(String? val){
    if(val != null){
        if(val.isEmpty){
          return "Silakan masukkan nama pengguna.";
        }
    }
    return null;
  }

  String? onPasswordValidation(String? val){
    if(val != null){
      if(val.isEmpty){
        return "Silakan masukkan kata sandi.";
      }
    }
    return null;
  }

  @override
  BuildContext get currentContext => context;

  @override
  UserProvider get currentProvider => provider;

}
