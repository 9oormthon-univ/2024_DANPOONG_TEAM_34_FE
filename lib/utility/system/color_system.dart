import 'package:flutter/material.dart';

abstract class ColorSystem {
  /// Transparent Color
  static Color transparent = Colors.transparent;

  /// White Color
  static Color white = Colors.white;

  /// Black Color
  static Color black = Colors.black;

  /// Health Primary Color
  static Color lightPink = const Color(0xFFFBE1EA);

  /// Cash Primary Color
  static Color lightYellow = const Color(0xFFFEF0D6);

  /// Mental Primary Color
  static Color lightBlue = const Color(0xFFE1EAFC);

  /// Speech Bubble Color
  static Color lightBeige = const Color(0xFFF3F1EE);

  static const int _bluePrimaryValue = 0xFF0C1C56;

  static MaterialColor blue = const MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      100: Color(0xFFE3E5EC), // 90% 밝게
      200: Color(0xFFC7CAD9), // 80% 밝게
      300: Color(0xFFABAFC6), // 70% 밝게
      400: Color(0xFF8F94B3), // 60% 밝게
      500: Color(_bluePrimaryValue), // 기본 색상
      600: Color(0xFF0A1749), // 10% 어둡게
      700: Color(0xFF08133C), // 20% 어둡게
      800: Color(0xFF060E2F), // 30% 어둡게
      900: Color(0xFF040A22), // 40% 어둡게
      1000: Color(0xFF020515), // 50% 어둡게
    },
  );

  /// Grey Color
  static MaterialColor grey = const MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      100: Color(0xFFF8F9FC),
      200: Color(0xFFF0F1F5),
      300: Color(0xFFDBDCE5),
      400: Color(0xFFBDBEC5),
      500: Color(0xFFACADB2),
      600: Color(0xFF96979E),
      700: Color(0xFF808289),
      800: Color(0xFF6B6D75),
      900: Color(0xFF575861),
      1000: Color(0xFF43454C),
    },
  );
  static const int _greyPrimaryValue = 0xFFACADB2;

  /// Green Color
  static MaterialColor green = const MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      100: Color(0xFFF8FFFD),
      200: Color(0xFFDBFFF6),
      300: Color(0xFFBDFFEF),
      400: Color(0xFFA7E7D7),
      500: Color(0xFF90CDBE),
      600: Color(0xFF7AB3A5),
      700: Color(0xFF538075),
      800: Color(0xFF538075),
      900: Color(0xFF40675D),
      1000: Color(0xFF2F4E46),
    },
  );
  static const int _greenPrimaryValue = 0xFF90CDBE;

  /// Pink Color
  static MaterialColor pink = const MaterialColor(
    _pinkPrimaryValue,
    <int, Color>{
      100: Color(0xFFFFF7F7),
      200: Color(0xFFF9D1D1),
      300: Color(0xFFF2ABAB),
      400: Color(0xFFD99595),
      500: Color(0xFFBF7F7F),
      600: Color(0xFFA66B6B),
      700: Color(0xFF8C5858),
      800: Color(0xFF734646),
      900: Color(0xFF593434),
      1000: Color(0xFF402424),
    },
  );
  static const int _pinkPrimaryValue = 0xFFF2ABAB;
}
