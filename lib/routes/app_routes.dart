import 'package:bhagavad_gita_app/screens/home/views/home_screen.dart';
import 'package:bhagavad_gita_app/screens/splash/views/splash_screen.dart';
import 'package:bhagavad_gita_app/screens/verses/views/verses_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static String splash = "/";
  static String home = "home_screen";
  static String verses = "verses_screen";

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    verses: (context) => const VersesScreen(),
  };
}
