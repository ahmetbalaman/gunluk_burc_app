import 'package:flutter/material.dart';
import 'package:gunluk_burc_app/components/navigate_components.dart';
import 'package:gunluk_burc_app/main.dart';
import 'package:gunluk_burc_app/screens/burc_ozellikleri.dart';
import 'package:gunluk_burc_app/service/ad_services.dart';
import '../components/burc_context_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// ignore: must_be_immutable
class BurcViewPage extends StatefulWidget {
  String whereCameFrom;
  BurcViewPage({
    Key? key,
    required this.whereCameFrom,
  }) : super(key: key);
  @override
  State<BurcViewPage> createState() => _BurcViewPageState();
}
List<String> gunlukBurcTab = ["Günlük", "Haftalık", "Aylık", "Yıllık"];

class _BurcViewPageState extends State<BurcViewPage> {
  BannerAd? _banner;
  RewardedAd? _rewardedAd;
  int _rewardedScore = 0;
  @override
  void initState() {
    super.initState();
    _createBannerAd();
    _createRewardedlAd();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                      _showRewardedAd();
                    navigate(
                        context,
                        BurcOzellikleri(
                          whereCameFrom: widget.whereCameFrom,
                        ));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: contextBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Genel Özellikler",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: contextColor),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
          bottom: TabBar(tabs: [
            ...gunlukBurcTab.map((e) {
              return Tab(
                child: FittedBox(
                  child: Text(
                    e,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: contextColor),
                  ),
                ),
              );
            })
          ]),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(children: [
                getirBurcBilgi(widget.whereCameFrom, "", () {
                  setState(() {});
                }, "günlük"),
                getirBurcBilgi(widget.whereCameFrom, "haftalik", () {
                  setState(() {});
                }, "günlük"),
                getirBurcBilgi(widget.whereCameFrom, "aylik", () {
                  setState(() {});
                }, "günlük"),
                getirBurcBilgi(widget.whereCameFrom, "yillik", () {
                  setState(() {});
                }, "günlük"),
              ]),
            ),
          ],
        ),
        bottomNavigationBar: _banner == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 52,
                child: AdWidget(ad: _banner!),
              ),
      ),
    );
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

  void _createBannerAd() {
    _banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId!,
        listener: AdMobService.bannerAdListener,
        request: const AdRequest())
      ..load();
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
