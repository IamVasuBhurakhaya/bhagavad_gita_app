import 'package:bhagavad_gita_app/screens/home/views/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static String home = "/";

  static Map<String, Widget Function(BuildContext)> routes = {
    home: (context) => const HomeScreen(),
  };
}
