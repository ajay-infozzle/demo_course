import 'package:flutter/material.dart';

class DeviceDimens {
  static final DeviceDimens _instance = DeviceDimens._internal();
  static late bool isLargeScreen;
  static late double width ;
  static late double height ;

  DeviceDimens._internal();

  factory DeviceDimens(BuildContext context) {
    if (_instance._isFirstRun) {
      width = MediaQuery.of(context).size.width;
      height = MediaQuery.of(context).size.height;
      isLargeScreen = width > 550;
      _instance._isFirstRun = false;
    }
    return _instance;
  }

  bool _isFirstRun = true;
}