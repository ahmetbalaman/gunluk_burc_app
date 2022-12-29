// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gunluk_burc_app/components/navigate_components.dart';
import 'package:gunluk_burc_app/constants/context_extension.dart';
import 'package:gunluk_burc_app/screens/burc_view.dart';
import 'package:gunluk_burc_app/service/ad_services.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map burclar = {
    "Kova": "kova",
    "Balık": "balik",
    "Koç": "koc",
    "Boğa": "boga",
    "İkizler": "ikizler",
    "Yengeç": "yengec",
    "Aslan": "aslan",
    "Başak": "basak",
    "Terazi": "terazi",
    "Akrep": "akrep",
    "Yay": "yay",
    "Oğlak": "oglak"
  };
  RewardedAd? _rewardedAd;
  int _rewardedScore = 0;
  @override
  void initState() {
    super.initState();
    _createRewardedlAd();
  }


  
  void _showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createRewardedlAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createRewardedlAd();
        },
      );
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) => setState(() => _rewardedScore++),
      );
      _rewardedAd = null;
    }
  }


  void _createRewardedlAd() {
    RewardedAd.load(
        adUnitId: AdMobService.rewardedAdUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          setState(() {
            _rewardedAd = ad;
          });
        }, onAdFailedToLoad: (error) {
          setState(() {
            _rewardedAd = null;
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    log(burclar.entries.first.toString());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Burcunuz",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 3 / 4),
          itemBuilder: (context, index) {
            return burcButton(
              fonk: () {
                _showRewardedAd();
                 navigateUstten(
                    context,
                    BurcViewPage(
                        whereCameFrom: burclar.entries.elementAt(index).value));
           
                  },
              deger: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(fontSize: context.width / 22),
              baslik: index==0?"Kova" : burclar.entries.elementAt(index).key,
              foto: burclar.entries.elementAt(index).value,
            );
          },
          itemCount: burclar.length,
        ));
  }
}

Widget burcButton(
    {required String foto,
    required String baslik,
    required var deger,
    required Function() fonk}) {
  return GestureDetector(
    onTap: fonk,
    child: Card(
      elevation: 2,
      color: buttonArkaPlan,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                  tag: foto,
                  child: Image.asset("assets/burclar/$foto.png",
                      fit: BoxFit.contain)),
              Text(
                baslik,
                style: deger,
              )
            ],
          ),
        ),
      ),
    ),
  );
}

/*
ANLIK REKLAM GÖSTEREN KOD

  void _createInterstitialAd(){
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId!,
       request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) => _instertitialAd=ad, onAdFailedToLoad: (LoadAdError error)=> _instertitialAd=null)
  );}

  void _showInterstitialAd(){
    if(_instertitialAd!=null){
      _instertitialAd!.fullScreenContentCallback=FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          _createInterstitialAd();
        }
      );
      _instertitialAd!.show();
      _instertitialAd=null;
    }
  }


*/
/*
Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: context.height / 4,
                  child: ClipPath(
                    clipper: AppClipper(),
                    child: Container(color: buttonArkaPlan, child: Container()),
                  ),
                ),
              ),
              Positioned(
                  top: context.height / 10,
                  child: Transform.rotate(
                    angle: -math.pi / 11,
                    child: Text(
                      ' Burcunuz:',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.copyWith(fontSize: context.width / 5),
                    ),
                  )),
            ],
          ),
          */