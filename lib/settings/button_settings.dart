import 'package:flutter/material.dart';

class ButtonSettings {
  final Color fontColor;
  final Color backgroundColor;

  ButtonSettings({this.fontColor, this.backgroundColor});

  static Map<String, Color> _mapColorsFonts = {
    'black': Colors.black,
    'white': Colors.white
  };

  static Map<String, Color> _mapBackground = {
    'lightGrey': Color.fromARGB(255, 165, 165, 165),
    'darkGrey': Color.fromARGB(255, 51, 51, 51),
    'orange': Color.fromARGB(255, 254, 149, 2),
  };

  static Map<String, ButtonSettings> _buttons = {
    'dark': ButtonSettings(
        fontColor: _mapColorsFonts['white'],
        backgroundColor: _mapBackground['darkGrey']),
    'light': ButtonSettings(
        fontColor: _mapColorsFonts['black'],
        backgroundColor: _mapBackground['lightGrey']),
    'orange': ButtonSettings(
        fontColor: _mapColorsFonts['white'],
        backgroundColor: _mapBackground['orange']),
  };

  Map<String, ButtonSettings> get buttons {
    return _buttons;
  }
}
