import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  final SharedPreferences prefs;

  const ThemeStorage({
    required this.prefs,
  });

  static const String key = 'theme_mode';

  Future setThemeMode(String value) async {
    return await prefs.setString(key, value);
  }

  String getThemeMode() {
    return prefs.getString(key) ?? '';
  }
}
