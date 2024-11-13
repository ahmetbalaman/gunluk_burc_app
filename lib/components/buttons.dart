import 'package:flutter/material.dart';
import 'package:gunluk_burc_app/constants/myTheme.dart';
import '../main.dart';

Widget burcButton({
  required VoidCallback fonk,
  required TextStyle? deger,
  required String baslik,
  required String foto,
  required bool isDark,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: fonk,
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? ThemeColors.darkContextBackground
              : ThemeColors.lightContextBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/burclar/$foto.png",
              height: 50,
              color: isDark
                  ? ThemeColors.darkContextColor
                  : ThemeColors.lightContextColor,
            ),
            Text(
              baslik,
              style: deger,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
