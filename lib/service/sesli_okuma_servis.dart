import 'package:flutter_tts/flutter_tts.dart';

class SesliOku {
  FlutterTts sesliOkuma = FlutterTts();
  sesliOku(String deger, bool basla) async {
    await sesliOkuma.setLanguage("tr-TR");
    await sesliOkuma.setPitch(1);
    await sesliOkuma.setSpeechRate(0.6);
    if (basla) {
      await sesliOkuma.speak(deger);
    } else {
      await sesliOkuma.stop();
    }
  }
}
