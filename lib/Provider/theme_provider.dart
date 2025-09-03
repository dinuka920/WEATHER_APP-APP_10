import 'package:flutter/material.dart';
import 'package:weather_app/services/theme_persistence.dart';
import 'package:weather_app/utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _loadTheme();
  }
  // initial theme
  ThemeData _themeData = ThemeModeData().lightMode;

  final ThemePersistence _themePersistence = ThemePersistence();

  // getter
  ThemeData get getThemeData => _themeData;

  // setter
  set setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  // Load the Theme from Shared pref
  Future<void> _loadTheme() async {
    bool isDark = await _themePersistence.loadTheme();
    setThemeData = isDark
        ? ThemeModeData().darkMode
        : ThemeModeData().lightMode;
  }

  // toggle theme
  Future<void> toggleTheme(bool isDark) async {
    setThemeData = isDark
        ? ThemeModeData().darkMode
        : ThemeModeData().lightMode;

    await _themePersistence.storeTheme(isDark);
    notifyListeners();
  }
}
