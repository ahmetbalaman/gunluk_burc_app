import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gunluk_burc_app/components/navigate_components.dart';
import 'package:gunluk_burc_app/components/snackbar_show.dart';
import 'package:gunluk_burc_app/screens/burc_view.dart';
import 'package:gunluk_burc_app/service/ad_services.dart';
import '../components/buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int firstOpening = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 14,
          child: Center(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 3 / 4),
              itemBuilder: (context, index) {
                return burcButton(
                  fonk: () {
                    if (firstOpening == 0) {
                      firstOpening++;
                      navigateUstten(
                          context,
                          BurcViewPage(
                              whereCameFrom:
                                  burclar.entries.elementAt(index).value));
                    } else {
                      if (_rewardedScore > 0) {
                        _rewardedScore--;
                        setState(() {
                          
                        });
                        navigateUstten(
                            context,
                            BurcViewPage(
                                whereCameFrom:
                                    burclar.entries.elementAt(index).value));
                      } else {
                        snackBarGoster(context,
                            "Lütfen puan kazanmak için ödüllü reklam izleyin.");
                      }
                    }
                  },
                  deger: Theme.of(context).textTheme.subtitle1?.copyWith(),
                  baslik: index == 0
                      ? "Kova"
                      : burclar.entries.elementAt(index).key,
                  foto: burclar.entries.elementAt(index).value,
                );
              },
              itemCount: burclar.length,
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Puanınız: ${_rewardedScore * 25}",
                  style: Theme.of(context).textTheme.headline5,
                ),
                ElevatedButton(onPressed: () {
                  _showRewardedAd();
                  setState(() {
                    
                  });
                }, child: Row(
                  children: [
                    Text("Ödüllü Reklam İzle",style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white),),
                    const Icon(Icons.play_circle)
                  ],
                ))
              ],
            )),
      ],
    ));
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