import 'package:flutter/material.dart';

/// --------------
/// Constant Color
/// --------------
class ColorManager {
  static Color primary = HexColor.fromHex("#131835");
  static Color grey = HexColor.fromHex("#A6A6A6");

  //Text colors
  static Color textColorPrimary = HexColor.fromHex("#1E1E1E");
  static Color textColorWhite = HexColor.fromHex("#FFFFFF");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString'; // 8 Char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
