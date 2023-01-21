import 'package:flutter/material.dart';
import 'package:gunluk_burc_app/constants/context_extension.dart';

import '../main.dart';

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
    return IconButton(
        onPressed: () {
          _isSelected = !_isSelected;
          widget.secildi(_isSelected);
          setState(() {});
        },
        icon: Icon(
          Icons.record_voice_over,
          size: context.width / 12,
          color: _isSelected ? buttonArkaPlan     : contextColor,
        ));
  }
}