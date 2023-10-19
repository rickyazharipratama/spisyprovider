import 'package:flutter/material.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';

abstract class SplashPresenter{

  UserProvider get currentProvider;
  Future<void> validatingUser();
  Future<void> retrievingUser(BuildContext context);
}
