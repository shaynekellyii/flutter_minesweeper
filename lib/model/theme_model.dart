import 'package:flutter/material.dart';

///
/// Model class for keeping state of light/dark theme.
///
/// Has [ChangeNotifier] mixin to notify widgets to rebuild when theme changes.
///
class ThemeModel with ChangeNotifier {
  ThemeData _theme = _kLightTheme;
  ThemeData get theme => _theme;

  bool _isLight = true;
  bool get isLight => _isLight;
  set isLight(bool newValue) {
    if (_isLight != newValue) {
      _isLight = newValue;
      _theme = _isLight ? _kLightTheme : _kDarkTheme;
      notifyListeners();
    }
  }
}

final _kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Dosis',
  primaryColor: Colors.grey[300],
);

final _kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Dosis',
);
