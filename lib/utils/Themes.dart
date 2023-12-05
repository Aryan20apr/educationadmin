import 'package:talentsearchenglish/utils/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  AppTheme._();

  static final defaultPinTheme = PinTheme(
    width: 15.w,
    height: 8.h,
    textStyle: TextStyle(
        fontSize: 20.sp,
        color: const Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xff8B8BAE)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const Color(0xffE78F8E)),
    borderRadius: BorderRadius.circular(8),
  );

  static final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
    ),
  );

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor:
          const Color(0xFFF7FFF7), //const Color(0xffECE2D0),
      primaryColor: const Color(0xFF4ECDC4),
      primaryColorDark: const Color(0xff00201E),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFF7FFF7)),
      appBarTheme: const AppBarTheme(
        elevation: 2,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: CustomColors.primaryColor,
            systemNavigationBarColor: Colors.white),
        backgroundColor: CustomColors.secondaryColor,
        foregroundColor: CustomColors.primaryColor,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: CustomColors.secondaryColor,
        shadowColor: Colors.grey.shade300,
        elevation: 2,
      ));
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor:
          const Color(0xFFF7FFF7), //const Color(0xffECE2D0),
      primaryColor: const Color(0xFF4ECDC4),
      primaryColorDark: const Color(0xff00201E),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFF7FFF7)),
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: CustomColors.primaryColorDark,
            systemNavigationBarColor: Colors.white),
        backgroundColor: CustomColors.primaryColorDark,
        foregroundColor: CustomColors.accentColor,
        elevation: 2,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: CustomColors.secondaryColor,
        shadowColor: Colors.grey.shade300,
        elevation: 2,
      ));
}
