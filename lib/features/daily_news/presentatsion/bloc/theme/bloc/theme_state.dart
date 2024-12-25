// theme_state.dart
import 'package:flutter/material.dart';

abstract class ThemeState {
  final ThemeData? themeData;

  ThemeState({this.themeData});
}


class LightThemeState extends ThemeState {
  final ThemeData themeData;
  LightThemeState() : themeData = ThemeData.light();
}

class DarkThemeState extends ThemeState {
  final ThemeData themeData;
  DarkThemeState() : themeData = ThemeData.dark();
}

