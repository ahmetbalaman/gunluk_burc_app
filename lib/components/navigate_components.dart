import 'package:flutter/Material.dart';

Future<dynamic> navigateReplace(BuildContext context, Widget page) {
  return Navigator.of(context).pushReplacement(_createRoute(page, 1.0, 0.0));
}

Future<dynamic> navigate(BuildContext context, Widget page) {
  return Navigator.of(context).push(_createRoute(page, 1.0, 0.0));
}

Future<dynamic> navigateUstten(BuildContext context, Widget page) {
  return Navigator.of(context).push(_createRoute(page, 0.0, 1.0));
}

Route _createRoute(Widget gidilecekSayfa, double x, double y) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => gidilecekSayfa,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final begin = Offset(x, y);
      const end = Offset.zero;
      const curve = Curves.easeIn;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
