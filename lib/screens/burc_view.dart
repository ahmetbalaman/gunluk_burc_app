import 'package:flutter/material.dart';
import 'package:gunluk_burc_app/components/navigate_components.dart';
import 'package:gunluk_burc_app/constants/myTheme.dart';
import 'package:gunluk_burc_app/main.dart';
import 'package:gunluk_burc_app/screens/burc_ozellikleri.dart';
import 'package:gunluk_burc_app/service/ad_services.dart';
import 'package:gunluk_burc_app/service/theme_provider.dart';
import 'package:provider/provider.dart';
import '../components/burc_context_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gunluk_burc_app/service/theme_provider.dart';

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
  //BannerAd? _banner;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        return DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: isDark
                      ? ThemeColors.darkContextColor
                      : ThemeColors.lightContextColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        navigate(
                          context,
                          BurcOzellikleri(
                            whereCameFrom: widget.whereCameFrom,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? ThemeColors.darkContextBackground
                              : ThemeColors.lightContextBackground,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Genel Özellikler",
                            style:
                                Theme.of(context).textTheme.headline5?.copyWith(
                                      color: isDark
                                          ? ThemeColors.darkContextColor
                                          : ThemeColors.lightContextColor,
                                    ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
              bottom: TabBar(
                indicatorColor: isDark
                    ? ThemeColors.darkButtonArkaPlan
                    : ThemeColors.lightButtonArkaPlan,
                tabs: [
                  ...gunlukBurcTab.map((e) {
                    return Tab(
                      child: FittedBox(
                        child: Text(
                          e,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: isDark
                                        ? ThemeColors.darkContextColor
                                        : ThemeColors.lightContextColor,
                                  ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            body: Container(
              color: isDark
                  ? ThemeColors.darkAppBackground
                  : ThemeColors.lightAppBackground,
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /* bottomNavigationBar: _banner == null
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    height: 52,
                    child: AdWidget(ad: _banner!),
                  ),*/
          ),
        );
      },
    );
  }
}


  /*
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
  */