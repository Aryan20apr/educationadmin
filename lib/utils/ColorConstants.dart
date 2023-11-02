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

class CustomColors {
  static const Color primaryColor = Color(0xFF4ECDC4); // #4ECDC4
  static const Color secondaryColor = Color(0xFFF7FFF7); // #F7FFF7
  static const Color accentColor = Color(0xFFFFE1A8); // #FFE1A8
  static const Color primaryColorDark=Color(0xff00201E);
  static const Color tileColour=Color(0xff00504C);
  static const Color createrColour=Color(0xff1F7976);
}