import 'package:shared_preferences/shared_preferences.dart';

class ThemePersistence {
  // Store the user's saved theme in shared preference
  Future<void> storeTheme(bool isDark) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("isDark", isDark);
    print("Store Theme");
  }

  // Load the user's saved theme from shared preference
  Future<bool> loadTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("Load Theme");
    return preferences.getBool("isDark") ?? false;
  }
}
