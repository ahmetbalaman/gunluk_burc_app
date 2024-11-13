import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gunluk_burc_app/constants/context_extension.dart';
import 'package:gunluk_burc_app/constants/myTheme.dart';
import 'package:gunluk_burc_app/main.dart';
import 'package:gunluk_burc_app/service/sesli_okuma_servis.dart';
import 'package:gunluk_burc_app/service/theme_provider.dart';
import 'package:provider/provider.dart';

import '../components/burc_context_view.dart';

class BurcOzellikleri extends StatefulWidget {
  final String whereCameFrom;
  const BurcOzellikleri({
    Key? key,
    required this.whereCameFrom,
  }) : super(key: key);

  @override
  State<BurcOzellikleri> createState() => _BurcOzellikleriState();
}

class _BurcOzellikleriState extends State<BurcOzellikleri> {
  late SesliOku sesli;
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
    sesli = SesliOku();
  }

  @override
  void dispose() {
    sesli.sesliOku("", false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        return DefaultTabController(
          length: 6,
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
              bottom: TabBar(
                indicatorColor: isDark
                    ? ThemeColors.darkButtonArkaPlan
                    : ThemeColors.lightButtonArkaPlan,
                tabs: [
                  ...burcOzellikTab.map((e) {
                    return Tab(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          e,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: isDark
                                        ? ThemeColors.darkContextColor
                                        : ThemeColors.lightContextColor,
                                    fontSize: context.width / 30,
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
                        }, "ozellik"),
                        getirBurcBilgi(widget.whereCameFrom, "kadin", () {
                          setState(() {});
                        }, "ozellik"),
                        getirBurcBilgi(widget.whereCameFrom, "erkek", () {
                          setState(() {});
                        }, "ozellik"),
                        getirBurcBilgi(widget.whereCameFrom, "ask", () {
                          setState(() {});
                        }, "ozellik"),
                        getirBurcBilgi(widget.whereCameFrom, "finans", () {
                          setState(() {});
                        }, "ozellik"),
                        getirBurcBilgi(widget.whereCameFrom, "saglik", () {
                          setState(() {});
                        }, "ozellik"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
