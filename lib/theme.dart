import 'package:flutter/material.dart';

final darkTheme = ThemeData(primaryColor: Colors.white, backgroundColor: Colors.white);

enum ThemeType { dark, light }

class AppTheme {
  static ThemeType defaultTheme = ThemeType.dark;
  final ThemeType type;
  final bool isDark;
  final Color backgroundColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color textColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color dividerColor;

  AppTheme({
    required this.type,
    required this.isDark,
    required this.backgroundColor,
    required this.primaryColor,
    required this.textColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.dividerColor,
    required this.secondaryColor,
  });

  /// Creates an AppTheme from a provided Type.
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.dark:
        return AppTheme(
          isDark: true,
          type: t,
          backgroundColor: const Color.fromRGBO(34, 34, 58, 1),
          primaryColor: Colors.green,
          textColor: Colors.white,
          buttonColor: Colors.green,
          buttonTextColor: Colors.green,
          dividerColor: Colors.green,
          secondaryColor: const Color(0xffE0E0E0),
        );
      case ThemeType.light:
        return AppTheme(
          isDark: false,
          type: t,
          backgroundColor: Colors.white,
          primaryColor: const Color.fromARGB(255, 5, 128, 9),
          textColor: Colors.black87,
          buttonColor: const Color.fromARGB(255, 5, 128, 9),
          buttonTextColor: Colors.green,
          dividerColor: const Color.fromARGB(255, 185, 185, 185),
          secondaryColor: Colors.grey,
        );
      default:
        return AppTheme.fromType(defaultTheme);
    }
  }

  ThemeData toThemeData() {
    var t = ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor,
      backgroundColor: backgroundColor,
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
    );
    return t;
  }
}

class ThemeModel extends ChangeNotifier {
  static AppTheme get _defaultTheme => AppTheme.fromType(ThemeType.dark);

  void notify([VoidCallback? action]) {
    action?.call();
    notifyListeners();
  }

  /// Settings
  // Current Theme
  AppTheme _theme = _defaultTheme;
  AppTheme get theme => _theme;
  set theme(AppTheme theme) => notify(() => _theme = theme);

  void changeTheme(bool isDark) {
    theme = AppTheme.fromType(isDark ? ThemeType.dark : ThemeType.light);
  }
}
