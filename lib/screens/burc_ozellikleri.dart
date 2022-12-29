// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gunluk_burc_app/constants/context_extension.dart';

import '../main.dart';
import '../service/ad_services.dart';
import 'burc_view.dart';

// ignore: must_be_immutable
class BurcOzellikleri extends StatefulWidget {
  String whereCameFrom;
  BurcOzellikleri({
    Key? key,
    required this.whereCameFrom,
  }) : super(key: key);

  @override
  State<BurcOzellikleri> createState() => _BurcOzellikleriState();
}

class _BurcOzellikleriState extends State<BurcOzellikleri> {
  List<String> burcOzellikTab = [
    "Genel",
    "Kadın",
    "Erkek",
    "Aşk",
    "Finans",
    "Sağlık"
  ];
   BannerAd? _banner;
  @override
  void initState() {
    super.initState();
    _createBannerAd();

  }

  void _createBannerAd() {
    _banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId!,
        listener: AdMobService.bannerAdListener,
        request: const AdRequest())
      ..load();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
         
            bottom: TabBar(tabs: [
              ...burcOzellikTab.map((e) {
                return Tab(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: contextColor, fontSize: context.width / 30),
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
                  getir(widget.whereCameFrom, "", () {
                    setState(() {});
                  }, "ozellik"),
                  getir(widget.whereCameFrom, "kadin", () {
                    setState(() {});
                  }, "ozellik"),
                  getir(widget.whereCameFrom, "erkek", () {
                    setState(() {});
                  }, "ozellik"),
                  getir(widget.whereCameFrom, "ask", () {
                    setState(() {});
                  }, "ozellik"),
                  getir(widget.whereCameFrom, "finans", () {
                    setState(() {});
                  }, "ozellik"),
                  getir(widget.whereCameFrom, "saglik", () {
                    setState(() {});
                  }, "ozellik"),
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










          /*
                Tab(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Genel",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: contextColor),
                  ),
                ),
              ),
              Tab(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Kadın",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: contextColor),
                  ),
                ),
              ),
              Tab(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Erkek",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: contextColor),
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Aşk",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: contextColor, fontSize: context.width / 28),
                ),
              ),
              Tab(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Finans",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: contextColor),
                  ),
                ),
              ),
              Tab(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Sağlık",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: contextColor),
                  ),
                ),
              ),
              */