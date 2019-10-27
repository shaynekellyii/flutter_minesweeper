import 'package:flutter/widgets.dart';
import 'package:flutter_minesweeper/constants/constants.dart';

bool isMobile(BuildContext context) =>
    MediaQuery.of(context).size.width < kMobileLayoutThresholdPixels;
