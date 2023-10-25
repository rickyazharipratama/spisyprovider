import 'package:flutter/material.dart';
import 'package:pratama_form_field_factory/builders/form_builder/pratama_form_builder_presenter.dart';
import 'package:pratama_form_field_factory/text_field/pratama_text_field_presenter.dart';
import 'package:spisyprovider/factory/Utils/enum_collections.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';
import 'package:spisyprovider/factory/raw_material/widget_context.dart';

abstract class LoginPresenter extends WidgetContext{

  UserProvider get currentProvider;
  ScrollController get currentScroolController;
  PratamaTextFieldPresenter get currentUsernameTextPresenter;
  PratamaTextFieldPresenter get currentPasswordTextPresenter;
  PratamaFormBuilderPresenter get currentFormBuilderPresenter;
  Future<LoginState> authenticatiog();
}
