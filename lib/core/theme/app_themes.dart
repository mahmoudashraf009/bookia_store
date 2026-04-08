import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "DM",
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      surface: Colors.white,
      onSurface: Colors.black,
      onPrimary: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: "DM",
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade200,
      thickness: 1,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "DM",
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkColor,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      surface: AppColors.darkColor,
      onSurface: Colors.white,
      onPrimary: Colors.white,
      secondary: AppColors.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: "DM",
      ),
    ),
    dividerTheme: DividerThemeData(
      color: Colors.white24,
      thickness: 1,
    ),
  );
}
