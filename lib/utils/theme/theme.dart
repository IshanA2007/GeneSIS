import 'package:flutter/material.dart';
import 'package:grades/utils/theme/custom_themes/app_bar_theme.dart';
import 'package:grades/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:grades/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:grades/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:grades/utils/theme/custom_themes/text_field_theme.dart';
import 'package:grades/utils/theme/custom_themes/text_theme.dart';
import '../constants/colors.dart';

class GenesisTheme {
  GenesisTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: GenesisColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GenesisTextTheme.lightTextTheme,
    elevatedButtonTheme: GenesisElevatedButtonTheme.lightElevatedButtonTheme,
    checkboxTheme: GenesisCheckboxTheme.lightCheckboxTheme,
    outlinedButtonTheme: GenesisOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: GenesisTextFormFieldTheme.lightInputDecorationTheme,
    appBarTheme: GenesisAppBarTheme.lightAppBarTheme,
  );

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: GenesisColors.primaryColor,
      scaffoldBackgroundColor: Colors.black,
      textTheme: GenesisTextTheme.darkTextTheme,
      elevatedButtonTheme: GenesisElevatedButtonTheme.darkElevatedButtonTheme,
      checkboxTheme: GenesisCheckboxTheme.darkCheckboxTheme,
      outlinedButtonTheme: GenesisOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: GenesisTextFormFieldTheme.darkInputDecorationTheme,
      appBarTheme: GenesisAppBarTheme.darkAppBarTheme);
}
