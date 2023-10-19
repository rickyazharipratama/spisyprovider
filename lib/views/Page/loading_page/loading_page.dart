import 'package:flutter/material.dart';

class LoadingPage<T> extends Page<T>{

  final BuildContext context;
  final WidgetBuilder builder;
  final CapturedThemes? themes;
  final Color barrierColor;
  final bool isBarrierDismissable;
  final String? barrierLabel;
  final bool userSafeArea;
  final Offset? anchorPoint;

  const LoadingPage({
    required this.context,
    required this.builder,
    this.themes,
    this.barrierColor= Colors.black87,
    this.isBarrierDismissable = true,
    this.barrierLabel,
    this.userSafeArea = true,
    this.anchorPoint

  });

  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute(
      context: context, 
      builder: (context) => Dialog(
        child: builder(context),
      ),
      anchorPoint: anchorPoint,
      themes: themes,
      barrierColor: barrierColor,
      barrierDismissible: isBarrierDismissable,
      barrierLabel: barrierLabel,
      useSafeArea: userSafeArea,
      settings: this,
    );
  }

}