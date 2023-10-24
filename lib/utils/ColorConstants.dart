import 'package:flutter/material.dart';

class ColorConstants {
  static Color gray50 = hexToColor('#e9e9e9');
  static Color gray100 = hexToColor('#bdbebe');
  static Color gray200 = hexToColor('#929293');
  static Color gray300 = hexToColor('#666667');
  static Color gray400 = hexToColor('#505151');
  static Color gray500 = hexToColor('#242526');
  static Color gray600 = hexToColor('#202122');
  static Color gray700 = hexToColor('#191a1b');
  static Color gray800 = hexToColor('#121313');
  static Color gray900 = hexToColor('#0e0f0f');
  static Color textFieldBgColor = const Color(0xfff7faf9);
  static Color appColors = const   Color(0xff3ac4ac);
  static Color primaryColor =const Color(0xFF3D5AFE); // Primary Color - Indigo
    static Color accentColor = const Color(0xFFFF8F00); // Accent Color - Amber
    static Color secondaryColor = const Color(0xFF00C853); // Secondary Color - Green
    static Color textColor = const Color(0xFF212121); // Text Color - Black
    static Color cardBackgroundColor = const Color(0xFFE6F0FF); // Light blue gradient background
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) +
      (hex.length == 7 ? 0xFF000000 : 0x00000000));
}