import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences prefs;
  static const String _themeKey = "current_theme";

  ThemeCubit(this.prefs) : super(ThemeMode.light) {
    _loadTheme();
  }

  void _loadTheme() {
    final String? theme = prefs.getString(_themeKey);
    if (theme == "dark") {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }

  Future<void> toggleTheme() async {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      await prefs.setString(_themeKey, "dark");
    } else {
      emit(ThemeMode.light);
      await prefs.setString(_themeKey, "light");
    }
  }

  bool get isDarkMode => state == ThemeMode.dark;
}
