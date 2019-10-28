import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minesweeper/model/models.dart';
import 'package:test/test.dart';

void main() {
  test('Initial values are set correctly', () {
    final model = ThemeModel();
    expect(model.isLight, true);
    expect(model.theme.brightness, Brightness.light);
    expect(model.theme.primaryColor, Colors.grey[300]);
  });

  test('Set dark mode', () {
    final model = ThemeModel()..isLight = false;
    expect(model.isLight, false);
    expect(model.theme.brightness, Brightness.dark);
  });
}