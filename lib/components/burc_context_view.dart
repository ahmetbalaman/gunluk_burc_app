import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gunluk_burc_app/constants/myTheme.dart';
import 'package:gunluk_burc_app/main.dart';
import 'package:gunluk_burc_app/service/sesli_okuma_servis.dart';
import 'package:gunluk_burc_app/service/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:gunluk_burc_app/components/sesli_okuma_button.dart';
import 'package:gunluk_burc_app/constants/context_extension.dart';
import '../service/burc_parse_servis.dart';
import '../service/metin_duzeltme.dart';

Widget contextMain(BuildContext context, List<String> data) {
  return Consumer<ThemeProvider>(
    builder: (context, themeProvider, child) {
      final isDark = themeProvider.isDarkMode;

      return Expanded(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? ThemeColors.darkContextBackground
                  : ThemeColors.lightContextBackground,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
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
                          fontSize: context.width * 0.05,
                          color: isDark
                              ? ThemeColors.darkContextColor
                              : ThemeColors.lightContextColor,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget mainScreen(List<String> data, BuildContext context) {
  return Consumer<ThemeProvider>(
    builder: (context, themeProvider, child) {
      final isDark = themeProvider.isDarkMode;

      return Expanded(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: context.width * 0.8,
                        child: Text(
                          data[0].toString(),
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: isDark
                                        ? ThemeColors.darkContextColor
                                        : ThemeColors.lightContextColor,
                                  ),
                        ),
                      ),
                      SesliOkumaButon(
                        secildi: (bool value) {
                          if (value) {
                            sesli.sesliOku(data[2], true);
                          } else {
                            sesli.sesliOku(data[2], false);
                          }
                        },
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
    },
  );
}

Widget getirBurcBilgi(
    String whereCameFrom, String hangi, Function() fonk, String site) {
  return Consumer<ThemeProvider>(
    builder: (context, themeProvider, child) {
      final isDark = themeProvider.isDarkMode;

      return Column(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Hero(
                tag: whereCameFrom,
                child: Image.asset(
                  "assets/burclar/$whereCameFrom.png",
                  color: isDark
                      ? ThemeColors.darkContextColor
                      : ThemeColors.lightContextColor,
                ),
              ),
            ),
          ),
          FutureBuilder<List<String>?>(
            future: getirBurclar(whereCameFrom, hangi, site),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.hasError) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Lütfen internete bağlanıp yeniden deneyiniz",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: isDark
                                  ? ThemeColors.darkYaziColor
                                  : ThemeColors.lightYaziColor,
                            ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fonk,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? ThemeColors.darkButtonArkaPlan
                              : ThemeColors.lightButtonArkaPlan,
                        ),
                        child: Text(
                          "Yenile",
                          style: TextStyle(
                            color: isDark
                                ? ThemeColors.darkContextColor
                                : ThemeColors.lightContextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              List<String> data = snapshot.data!;
              return mainScreen(data, context);
            },
          ),
        ],
      );
    },
  );
}
