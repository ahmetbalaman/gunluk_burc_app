import 'package:flutter/material.dart';
import '../main.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
                tag: foto,
                child: Image.asset("assets/burclar/$foto.png",
                    fit: BoxFit.contain)),
            FittedBox(
              fit:BoxFit.contain,
              child: Text(
                baslik,
                style: deger,
              ),
            )
          ],
        ),
      ),
    ),
  );
}