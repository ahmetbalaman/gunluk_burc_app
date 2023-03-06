import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gunluk_burc_app/screens/home_page.dart';
import 'package:gunluk_burc_app/service/sesli_okuma_servis.dart';

Future main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

const Color yaziColor = Color(0xFF342640);
const Color buttonArkaPlan = Color(0xFF9E78E0);
const Color contextBackground = Color(0xFFD9D9D9);
const Color contextColor = Color(0xFF000000);
const Color appBackground = Color(0xFFDAF2E1);
SesliOku sesli = SesliOku();
var fontName = GoogleFonts.milonga().copyWith(color: yaziColor);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Burç Takibi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: buttonArkaPlan,
          secondary: Colors.red,
        ),
        scaffoldBackgroundColor: appBackground,
        fontFamily: GoogleFonts.milonga().toString(),
        textTheme: TextTheme(
          headline1: fontName.copyWith(color: contextColor),
          headline2: fontName.copyWith(color: contextColor),
          headline3: fontName,
          headline4: fontName,
          headline5: fontName,
          headline6: fontName,
          subtitle1: fontName,
        ).apply(),
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          "assets/logo2.png",
        ),
        duration: 1800,
        splashIconSize: 280,
        backgroundColor: buttonArkaPlan,
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.rotationTransition,
      ),
    );
  }
}
