import 'package:nfactorial_cup/data/local_db/theme_storage.dart';
import 'package:flutter/material.dart';

enum AppColorMode { light, dark }

class ThemeNotifier extends ChangeNotifier {
  final ThemeStorage themeStorage;

  AppColorMode _themeMode = AppColorMode.light;

  AppColorMode get getThemeMode => _themeMode;

  ThemeNotifier({required this.themeStorage}) {
    _iniMode();
  }

  switchMode(AppColorMode mode) async {
    await themeStorage.setThemeMode(mode.name);

    _themeMode = mode;

    notifyListeners();
  }

  _iniMode() {
    final theme = themeStorage.getThemeMode();

    switch (theme) {
      case 'light':
        _themeMode = AppColorMode.light;
      case 'dark':
        _themeMode = AppColorMode.dark;
    }
    notifyListeners();
  }
}
