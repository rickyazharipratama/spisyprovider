import 'package:flutter/material.dart';

abstract class LogoutPresenter{

  BuildContext get currentContext;
  Future<void >onLogoutTapped();
}
