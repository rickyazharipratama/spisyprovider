import 'package:flutter/material.dart';
import 'package:pratama_form_field_factory/buttons/pratama_icon_buttons.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/provider/landing_page_provider.dart';

class AppBarButton extends StatelessWidget {

  final VoidCallback? onTap;
  const AppBarButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    int active = context.select<LandingPageProvider,int>((value) => value.active);
    if(active == 0){
      return PratamaIconButton(
        icon: Icons.add,
        onTap: onTap
      );
    }
    return Container();
  }
}