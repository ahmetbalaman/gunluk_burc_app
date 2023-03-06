import 'package:flutter/material.dart';
import 'package:gunluk_burc_app/components/sesli_okuma_button.dart';
import 'package:gunluk_burc_app/constants/context_extension.dart';

import '../main.dart';
import '../service/burc_parse_servis.dart';
import '../service/metin_duzeltme.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data[0].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black),
                  ),
                  SesliOkumaButon(
                    secildi: (bool value) {
                      if (value) {
                        sesli.sesliOku(data[2], true);
                      } else {
                        sesli.sesliOku(data[2], false);
                      }
                    },
                  )
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

Widget getirBurcBilgi(
    String whereCameFrom, String hangi, Function() fonk, String site) {
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
