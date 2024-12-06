import 'dart:async';
import 'dart:ui';
import 'package:bhagavad_gita_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> blurAnimation;

  double opacityValue = 1.0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    blurAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    Timer(const Duration(seconds: 3), () {
      setState(() {
        opacityValue = 0.0;
      });
      controller.forward();

      Timer(const Duration(milliseconds: 800), () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/image/cover2.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: blurAnimation,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: blurAnimation.value,
                    sigmaY: blurAnimation.value,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: opacityValue,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            top: 34,
            right: 20,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'श्रीमद भगवद्‍ गीता',
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
        ],
      ),
    );
  }
}
