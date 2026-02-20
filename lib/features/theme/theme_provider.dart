import 'light_mode.dart';
import 'darkmode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightmode;
  ThemeData get themedata => _themeData;
  bool get isdarkmode => _themeData == darkmode;

  set themedata(ThemeData themedata) {
    _themeData = themedata;
    notifyListeners();
  }

  void toggletheme() {
    if (_themeData == lightmode) {
      themedata = darkmode;
    } else {
      themedata = lightmode;
    }
  }
}
