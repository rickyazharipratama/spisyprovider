import 'package:flutter/foundation.dart';

class LogUtil{
  static final LogUtil log = LogUtil();
  void write(Object val){
    if (kDebugMode) {
      print(val);
    }
  }
}