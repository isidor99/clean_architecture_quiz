import 'package:flutter/material.dart';
import 'package:quiz_app/core/model/app_theme.dart';

class AppThemes {
  static List<AppTheme> themes = [
    AppTheme(mode: ThemeMode.light, title: 'Light'),
    AppTheme(mode: ThemeMode.dark, title: 'Dark'),
    AppTheme(mode: ThemeMode.system, title: 'System'),
  ];
}
