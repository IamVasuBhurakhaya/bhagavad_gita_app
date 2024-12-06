import 'package:bhagavad_gita_app/screens/home/views/home_screen.dart';
import 'package:bhagavad_gita_app/screens/pageView/views/page_view.dart';
import 'package:bhagavad_gita_app/screens/splash/views/splash_screen.dart';
import 'package:bhagavad_gita_app/screens/verses/views/verses_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static String splash = "/";
  static String home = "home_screen";
  static String verses = "verses_screen";
  static String pageView = "page_view_screen";

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    verses: (context) => const VersesScreen(),
    pageView: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
      final initialIndex = arguments?['initialIndex'] ?? 0;
      return PageViewScreen(initialIndex: initialIndex);
    },
  };
}
