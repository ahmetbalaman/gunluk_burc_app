import 'package:flutter/material.dart';
import 'package:gunluk_burc_app/constants/myTheme.dart';
import 'package:gunluk_burc_app/main.dart';
import 'package:gunluk_burc_app/service/theme_provider.dart';
import 'package:provider/provider.dart';

ScaffoldFeatureController snackBarGoster(BuildContext context, String message) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  final isDark = themeProvider.isDarkMode;

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: isDark
          ? ThemeColors.darkButtonArkaPlan
          : ThemeColors.lightButtonArkaPlan,
      content: Text(
        message,
        style: TextStyle(
          color: isDark
              ? ThemeColors.darkContextColor
              : Colors.white, // Açık temada beyaz metin daha okunabilir
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      behavior: SnackBarBehavior.floating, // Floating stil için
      margin: const EdgeInsets.all(8), // Kenarlarda boşluk
    ),
  );
}
