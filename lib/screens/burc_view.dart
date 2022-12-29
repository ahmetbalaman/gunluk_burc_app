// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:gunluk_burc_app/components/navigate_components.dart';
import 'package:gunluk_burc_app/constants/context_extension.dart';
import 'package:gunluk_burc_app/main.dart';
import 'package:gunluk_burc_app/screens/burc_ozellikleri.dart';
import 'package:gunluk_burc_app/service/ad_services.dart';
import '../service/burc_parse_servis.dart';
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
                    decoration: BoxDecoration(
                      color: contextBackground,
                      borderRadius: const BorderRadius.only(
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
                child: Text(
                  e,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: contextColor),
                ),
              );
            })
          ]),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(children: [
                getir(widget.whereCameFrom, "", () {
                  setState(() {});
                }, "günlük"),
                getir(widget.whereCameFrom, "haftalik", () {
                  setState(() {});
                }, "günlük"),
                getir(widget.whereCameFrom, "aylik", () {
                  setState(() {});
                }, "günlük"),
                getir(widget.whereCameFrom, "yillik", () {
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
}

Widget contextMain(BuildContext context, List<String> data) {
  return Expanded(
    child: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: contextBackground, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                duzenle(
                  duzenle(data[2], "DİLARA YILDIZHAN", bitis: ":"),
                  "İlginizi Çekebilir",
                )
                    .trimLeft()
                    .replaceAll(data[0], "")
                    .replaceAll("...", "....\n")
                    .replaceAll(".", ".\n")
                    .replaceAll("?", "?\n\n"),
                style: Theme.of(context).textTheme.headline3?.copyWith(
                    fontSize: context.width * 0.05, color: contextColor),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget mainScreen(List<String> data, BuildContext context) {
  return Expanded(
    child: Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      data[0].toString(),
                      style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            contextMain(context, data)
          ],
        ),
      ],
    ),
  );
}

Widget getir(String whereCameFrom, String hangi, Function() fonk, String site) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Hero(
              tag: whereCameFrom,
              child: Image.asset("assets/burclar/$whereCameFrom.png")),
        ),
      ),
      FutureBuilder<List<String>?>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Expanded(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (!snapshot.hasData) {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Lütfen internete bağlanıp yeniden deneyiniz",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: fonk,
                      child: Text("Yenile",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: contextColor))),
                ],
              ),
            );
          } else {
            var data = snapshot.data!;
            return mainScreen(data, context);
          }
        },
        future: getirBurclar(whereCameFrom, hangi, site),
      ),
    ],
  );
}

String duzenle(String tumMetin, String silinecekMetin, {String bitis = ""}) {
  int varmi = tumMetin.indexOf(silinecekMetin);

  if (varmi == -1) {
    return tumMetin;
  } else if (bitis != "") {
    String altString1 = tumMetin.substring(varmi, tumMetin.length);
    int varmi2 = altString1.indexOf(bitis);
    if (varmi2 != -1) {
      altString1 = altString1.substring(0, altString1.indexOf(bitis) + 1);
      return tumMetin.replaceAll(altString1, "");
    }
  }

  return tumMetin.replaceAll(
      tumMetin.substring(tumMetin.indexOf(silinecekMetin), tumMetin.length),
      "");
}

String ikinciDuzenle(String str, String targetWord) {
  if (str.contains(targetWord)) {
    // Kelime bulundu, indekslerini bulalım
    int startIndex = str.indexOf(targetWord);
    int endIndex = startIndex + targetWord.length;

    // Kelimeyi ve o kelimeyi takip eden kısmı keserek yeni bir String oluşturalım
    String newStr = str.substring(0, startIndex) + str.substring(endIndex);
    return newStr;
  } else {
    return str;
  }
}
