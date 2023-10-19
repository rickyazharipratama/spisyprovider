import 'package:flutter/material.dart';

class TransitionUtil{

  static final TransitionUtil transition = TransitionUtil();


  sliding({
    required Widget child,
    required Animation<double> inAnim,
    required Animation<double> outAnim,
    required BuildContext context,
    bool isLeft = false}){

    return FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
          curve: const Interval(0.1, 0.4,
            curve: Curves.easeOut
          ),
          parent: outAnim
        )
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.0,0.0), end: Offset(isLeft ?-0.3 : 0.3,0)).animate(
          CurvedAnimation(
            curve: Curves.easeOut,
            parent: outAnim
          )
        ),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: inAnim, 
              curve: const Interval(0.5, 1,
                curve: Curves.easeIn
              )
            )
          ),
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(isLeft? -0.5 : 0.5, 0), end: const Offset(0,0)).animate(
              CurvedAnimation(
                parent: inAnim,
                curve: Curves.easeIn)
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  simpleSliding({
    required Widget child,
    required Animation<double> inAnim,
    required Animation<double> outAnim,
    required BuildContext context,
    bool isLeft = false
  }){
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0.0,0.0), end: Offset(isLeft ?-0.5 : 0.5,0)).animate(
        CurvedAnimation(
          curve: Curves.easeOut,
          parent: outAnim
        )
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: Offset(isLeft? -0.5 : 0.5, 0), end: const Offset(0,0)).animate(
          CurvedAnimation(
            parent: inAnim,
            curve: Curves.easeIn)
        ),
        child: child
      )
    );
  }

  slideUp({
    required Widget child,
    required Animation<double> inAnim,
    required Animation<double> outAnim,
    required BuildContext context,
  }){
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          curve: const Interval(0.4, 1,
            curve: Curves.easeIn
          ),
          parent: inAnim
        )
      ),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0,0.1), end: const Offset(0,0)).animate(
          CurvedAnimation(
            curve: Curves.easeIn,
            parent: inAnim
          )
        ),
        child: child,
      ),
    );
  }

  fading({
    required Widget child,
    required Animation<double> inAnim,
    required Animation<double> outAnim,
    required BuildContext context,
  }){
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: inAnim,
            curve: Curves.easeOut
        )
      ),
      child: child
    );
  }
}