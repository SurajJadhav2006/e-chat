import 'package:flutter/material.dart';

import '../Utils/common_color.dart';
import 'Text_Themes.dart';

class AppThemes {
  static ThemeData lightTheme({String? fontFamily}) {
    return ThemeData(

      fontFamily: fontFamily ?? 'Roboto',
      brightness: Brightness.light,

      primaryColor: CC.primary,
      scaffoldBackgroundColor: CC.background,

      appBarTheme: const AppBarTheme(
        backgroundColor: CC.background,
        elevation: 0,
        foregroundColor: CC.textPrimary,
      ),

      colorScheme: const ColorScheme(
        surfaceContainer: CC.background,
        primaryContainer: CC.inputBackground,   // container ke liye
        brightness: Brightness.light,
        primary: CC.primary,
        secondary: CC.primary,
        onPrimary: CC.subPrimary,   // text into btn
        onSecondary:CC.text,
        background: CC.background,
        onBackground: CC.onBgLight,    //onbording bg
        surface: CC.textIcon,
        onInverseSurface: CC.textIcon,
        onSurface: CC.background,       //text color headings
        onTertiary: CC.textSubSecondary,   // TFFHeading text

        error: CC.error,
        onError: Colors.white,
        outline: CC.border,
        tertiary: CC.surface,
        inversePrimary: CC.textSecondary
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CC.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: CC.border),
        ),
      ),

      textTheme: ThemeDataDark.textTheme(
        CC.background,
        fontFamily,
      ),
    );
  }

  /// DARK THEME
  static ThemeData darkTheme({String? fontFamily}) {
    return ThemeData(

      fontFamily: fontFamily ?? 'Roboto',

      brightness: Brightness.dark,
      primaryColor: CCDark.primary,
      scaffoldBackgroundColor: CCDark.background,
      appBarTheme:  AppBarTheme(
        backgroundColor: Color(0xff135CAF),
        elevation: 0,
      ),

      colorScheme:  ColorScheme(
        surfaceContainer: Color(0xff393A4C),
        onInverseSurface: CCDark.textIcon,
        onTertiary: CCDark.tFFHDa,    // TFFHeading text
        brightness: Brightness.dark,
        primaryContainer: CCDark.background,
        primary: CCDark.primary,
        secondary: CCDark.secondary,
        onPrimary: CCDark.primary,    // text into btn
        onSecondary: CCDark.icon,
        background: CCDark.background,
        onBackground: CCDark.onBgDark,
        surface: CCDark.surface,    //isRemember
        onSurface: CCDark.primary,   // textColor heading
        error: CCDark.error,
        onError: Colors.white,
        outline: CCDark.border,
        tertiary: CCDark.icon,
        inversePrimary: Color(0xffD0D1DB)  //tff heading lable

      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CCDark.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: CCDark.border),
        ),
      ),

      textTheme: ThemeDataDark.textTheme(
         CCDark.primary,
        fontFamily,
      ),
    );
  }
}