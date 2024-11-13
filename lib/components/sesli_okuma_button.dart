import 'package:flutter/material.dart';
import 'package:gunluk_burc_app/constants/myTheme.dart';
import 'package:gunluk_burc_app/main.dart';
import 'package:gunluk_burc_app/service/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:gunluk_burc_app/constants/context_extension.dart';

class SesliOkumaButon extends StatefulWidget {
  final ValueChanged<bool> secildi;
  const SesliOkumaButon({
    Key? key,
    required this.secildi,
  }) : super(key: key);

  @override
  State<SesliOkumaButon> createState() => _SesliOkumaButonState();
}

class _SesliOkumaButonState extends State<SesliOkumaButon> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        return IconButton(
          onPressed: () {
            _isSelected = !_isSelected;
            widget.secildi(_isSelected);
            setState(() {});
          },
          icon: Icon(
            Icons.record_voice_over,
            size: context.width / 12,
            color: _isSelected
                ? (isDark
                    ? ThemeColors.darkButtonArkaPlan
                    : ThemeColors.lightButtonArkaPlan)
                : (isDark
                    ? ThemeColors.darkContextColor
                    : ThemeColors.lightContextColor),
          ),
        );
      },
    );
  }
}
