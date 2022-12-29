

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService{
  static String? get bannerAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  } 
  static String? get interstitialAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return null;
  }
   static String? get rewardedAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/5224354917';
    }
    return null;
  } 

  static final BannerAdListener bannerAdListener=BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad Loaded'),
    onAdFailedToLoad: (ad,error){
      ad.dispose();
      debugPrint('Reklam Yüklenemedi : ${error.message}');
    },
    onAdOpened: (ad)=>debugPrint('Reklam Açıldı'),
    onAdClosed: (ad)=>debugPrint('Reklam Kapatıldı'),

  );

}

