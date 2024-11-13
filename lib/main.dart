import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gunluk_burc_app/constants/myTheme.dart';
import 'package:gunluk_burc_app/screens/home_page.dart';
import 'package:gunluk_burc_app/service/sesli_okuma_servis.dart';
import 'package:gunluk_burc_app/service/theme_provider.dart';
import 'package:provider/provider.dart';

Future main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

SesliOku sesli = SesliOku();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;
        final fontStyle = themeProvider.fontStyle;

        return MaterialApp(
          navigatorKey: navigatorKey, // Burada kullanın

          title: 'Burç Takibi',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: isDark
                  ? ThemeColors.darkButtonArkaPlan
                  : ThemeColors.lightButtonArkaPlan,
              secondary: Colors.red,
              brightness: isDark ? Brightness.dark : Brightness.light,
            ),
            scaffoldBackgroundColor: isDark
                ? ThemeColors.darkAppBackground
                : ThemeColors.lightAppBackground,
            fontFamily: GoogleFonts.milonga().toString(),
            textTheme: TextTheme(
              headline1: fontStyle.copyWith(
                color: isDark
                    ? ThemeColors.darkContextColor
                    : ThemeColors.lightContextColor,
              ),
              headline2: fontStyle.copyWith(
                color: isDark
                    ? ThemeColors.darkContextColor
                    : ThemeColors.lightContextColor,
              ),
              headline3: fontStyle,
              headline4: fontStyle,
              headline5: fontStyle,
              headline6: fontStyle,
              subtitle1: fontStyle,
            ).apply(),
          ),
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
            splash: Image.asset(
              "assets/logo2.png",
            ),
            duration: 1800,
            splashIconSize: 280,
            backgroundColor: !isDark
                ? ThemeColors.darkButtonArkaPlan
                : ThemeColors.lightButtonArkaPlan,
            nextScreen: const HomePage(),
            splashTransition: SplashTransition.rotationTransition,
          ),
        );
      },
    );
  }
}
