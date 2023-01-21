

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService{
  static String? get bannerAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-7728946181381370/2918116883';
    }
    return null;
  } 
   static String? get rewardedAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-7728946181381370/8074488065';
    }
    return null;
  } 

  static final BannerAdListener bannerAdListener=BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Reklam yuklendi'),
    onAdFailedToLoad: (ad,error){
      ad.dispose();
      debugPrint('Reklam Yüklenemedi : ${error.message}');
    },
    onAdOpened: (ad)=>debugPrint('Reklam Açıldı'),
    onAdClosed: (ad)=>debugPrint('Reklam Kapatıldı'),

  );

}

