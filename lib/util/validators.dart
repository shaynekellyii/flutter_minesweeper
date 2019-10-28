import 'package:flutter_minesweeper/constants/constants.dart';
import 'package:flutter_minesweeper/constants/strings.dart';

///
/// File containing validators for formfields.
///

///
/// Validates that the row/col value is valid and between 10 -> 98.
///
String kRowColValidator(String value) {
  if (value.isEmpty) {
    return kEnterValue;
  }
  final int rows = int.tryParse(value);
  if (rows == null || rows < 1) {
    return kEnterValidNumber;
  } else if (rows >= kMaxRowsCols) {
    return '$kEnterLessThan $kMaxRowsCols';
  } else if (rows <= kMinRowsCols) {
    return '$kEnterMoreThan $kMinRowsCols';
  }
  return null;
}

///
/// Validates that the number of mines is valid and within the valid range for
/// the given number of rows and columns.
///
String kMineValidator(String value, String rowValue, String colValue) {
  if (value.isEmpty) {
    return kEnterValue;
  }

  final int mines = int.tryParse(value);
  if (mines == null || mines < 1) {
    return kEnterValidNumber;
  }

  final int rows = int.tryParse(rowValue ?? '');
  final int cols = int.tryParse(colValue ?? '');
  if (rows == null || cols == null) return null;

  final maxMines = (rows * cols - kTileBuffer);
  if (mines >= maxMines) {
    return '$kTooManyMines $maxMines';
  }

  return null;
}
