
import 'package:flutter/Material.dart';
import 'package:gunluk_burc_app/main.dart';

ScaffoldFeatureController snackBarGoster(BuildContext context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
      backgroundColor: buttonArkaPlan,
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))));
}
