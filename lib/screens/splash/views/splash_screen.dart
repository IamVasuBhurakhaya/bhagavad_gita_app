import 'dart:async';
import 'package:bhagavad_gita_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      timer.cancel();
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/image/cover2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'श्रीमद भगवत गीता',
                    textStyle: const TextStyle(
                      color: Color(0xff800000),
                    ),
                    speed: const Duration(milliseconds: 140),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
