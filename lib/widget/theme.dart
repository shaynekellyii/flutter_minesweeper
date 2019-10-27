import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends StatelessWidget {
  const ThemeProvider({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>.value(
      value: ThemeModel(),
      child: child,
    );
  }
}

class ThemeModel with ChangeNotifier {
  ThemeData _theme = _kLightTheme;
  ThemeData get theme => _theme;

  bool _isLight = true;
  get isLight => _isLight;
  set isLight(bool newValue) {
    if (_isLight != newValue) {
      _isLight = newValue;
      _theme = _isLight ? _kLightTheme : _kDarkTheme;
      notifyListeners();
    }
  }
}

final _kLightTheme = ThemeData(
  fontFamily: 'Dosis',
  primaryColor: Colors.grey[300],
);

final _kDarkTheme = ThemeData.dark();
