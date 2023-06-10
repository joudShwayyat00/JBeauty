import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPerfManager {
  static bool isLoggedIn = false;
  static bool showIntro = true;
  static SharedPreferences? prefs;
  static ThemeMode themeMode = ThemeMode.system;
  static Locale locale = const Locale('en');

  /// This method is used to initialize the shared preferences
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    isLoggedIn = await getIsLogedIn();
    showIntro = await getShowIntro();
    themeMode = await getThemeMode() ?? ThemeMode.system;
    locale = await getLocale() ?? const Locale('en');

    return;
  }

  static void setLocale(Locale localeIn) {
    locale = localeIn;
    prefs?.setString('Locale', localeIn.languageCode);
  }

  static Future<Locale?> getLocale() async {
    var localeIn = prefs?.getString('Locale');
    locale = Locale(localeIn ?? 'en');
    return locale;
  }

  static void setThemeMode(ThemeMode themeModeIn) {
    themeMode = themeModeIn;
    prefs?.setInt('ThemeMode', themeMode.index);
  }

  static Future<ThemeMode?> getThemeMode() async {
    var themeModeIn = prefs?.getInt('ThemeMode');
    themeMode = ThemeMode.values[themeModeIn ?? 0];
    return themeMode;
  }

  static Future<bool> getIsLogedIn() async {
    isLoggedIn = prefs?.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  static Future<void> setIsLogedIn(bool value) async {
    isLoggedIn = value;
    prefs?.setBool('isLoggedIn', value);
  }

  static Future<bool> getShowIntro() async {
    showIntro = prefs?.getBool('showIntro') ?? true;
    return showIntro;
  }

  static Future<void> setShowIntro(bool value) async {
    showIntro = value;
    prefs?.setBool('showIntro', value);
  }

  static void clearAllData() {
    setIsLogedIn(false);
    setShowIntro(true);
    setThemeMode(ThemeMode.system);
    setLocale(const Locale('en'));
    prefs?.clear();
  }
}
