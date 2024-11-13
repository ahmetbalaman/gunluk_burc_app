/*import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1429686129018235/7717370818';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1429686129018235/8076425472';
    }
    return null;
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1429686129018235/5794438145';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1429686129018235/8076425472';
    }
    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Reklam yuklendi'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Reklam Yüklenemedi : ${error.message}');
    },
    onAdOpened: (ad) => debugPrint('Reklam Açıldı'),
    onAdClosed: (ad) => debugPrint('Reklam Kapatıldı'),
  );
}
*/