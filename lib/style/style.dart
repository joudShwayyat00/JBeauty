import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jbeauty/data/shared_perf_manager.dart';

class Style {
  // static ThemeData themeData = ThemeData(
  //   textTheme: GoogleFonts.poppinsTextTheme(),
  //   primaryColor: primaryColor,
  //   colorScheme:
  // );

  static ThemeData getThemeData(WidgetRef ref) {
    final theme = ref.watch(currentThemeProvider).currentTheme;
    bool isAr =
        ref.watch(currentLocalProvider).currentLocal.languageCode == 'ar';
    return ThemeData.from(
      colorScheme: theme,
      textTheme: isAr
          ? GoogleFonts.cairoTextTheme(
              Theme.of(ref.context).textTheme.apply(bodyColor: theme.onSurface),
            )
          : GoogleFonts.poppinsTextTheme(
              Theme.of(ref.context).textTheme.apply(bodyColor: theme.onSurface),
            ),
    ).copyWith(
      appBarTheme: Theme.of(ref.context).appBarTheme.copyWith(
            backgroundColor: theme.primary,
            foregroundColor: theme.background,
          ),
    );
  }

  /// light theme
  static const Color primaryColor = Color(0xFFffb6c1);
  static const Color secondaryColor = Color(0xFFCC7D00);
  static const Color background = Colors.white;
  static const Color red = Color.fromARGB(255, 175, 41, 41);

  static ColorScheme lightColorScheme = const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: background,
    background: background,
    error: red,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  /// dark theme
  static const Color primaryColorDark = Color(0xFFffb6c1);
  static const Color secondaryColorDark = Color(0xFFCC7D00);
  static const Color backgraoundDark = Color.fromARGB(255, 39, 33, 33);
  static const Color redDark = Color.fromARGB(255, 175, 41, 41);

  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: primaryColorDark,
    secondary: secondaryColorDark,
    surface: backgraoundDark,
    background: backgraoundDark,
    error: redDark,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  );
}

final currentThemeProvider = ChangeNotifierProvider((ref) => ThemeNotifier());

class ThemeNotifier extends ChangeNotifier {
  ColorScheme currentTheme =
      getColorSchemeFromThemeMode(SharedPerfManager.themeMode);

  void toggleTheme(ThemeMode themeMode) {
    SharedPerfManager.setThemeMode(themeMode);
    currentTheme = getColorSchemeFromThemeMode(themeMode);
    notifyListeners();
  }

  static getColorSchemeFromThemeMode(ThemeMode appThemeMode) {
    switch (appThemeMode) {
      case ThemeMode.light:
        return Style.lightColorScheme;
      case ThemeMode.dark:
        return Style.darkColorScheme;
      default:
        // get system theme mode
        var brightness = PlatformDispatcher.instance.platformBrightness;
        bool isDarkMode = brightness == Brightness.dark;
        return isDarkMode ? Style.darkColorScheme : Style.lightColorScheme;
    }
  }
}

/// local provider
final currentLocalProvider =
    ChangeNotifierProvider((ref) => LocalChangeNotifier());

class LocalChangeNotifier extends ChangeNotifier {
  Locale currentLocal = SharedPerfManager.locale;

  /// set local
  void setLocale(Locale locale) {
    SharedPerfManager.setLocale(locale);
    currentLocal = SharedPerfManager.locale;
    notifyListeners();
  }
}
