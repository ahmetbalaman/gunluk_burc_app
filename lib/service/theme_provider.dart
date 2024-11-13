import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gunluk_burc_app/constants/myTheme.dart';
import 'package:gunluk_burc_app/service/theme_provider.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  // Font stilini provider içinde tutuyoruz
  TextStyle get fontStyle => GoogleFonts.milonga().copyWith(
        color: _isDarkMode
            ? ThemeColors.darkYaziColor
            : ThemeColors.lightYaziColor,
      );

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
