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
  late AnimationController _controller;
  late Animation<double> _blurAnimation;

  double opacityValue = 1.0;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Define blur animation
    _blurAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations with a delay
    Timer(const Duration(seconds: 3), () {
      setState(() {
        opacityValue = 0.0; // Start fade-out
      });
      _controller.forward(); // Start blur animation

      // Navigate to the home screen after animations
      Timer(const Duration(milliseconds: 800), () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/image/cover2.jpg",
              fit: BoxFit.fill,
            ),
          ),
          // Blur Animation
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _blurAnimation,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _blurAnimation.value,
                    sigmaY: _blurAnimation.value,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                );
              },
            ),
          ),
          // Fade-Out Animation
          Positioned.fill(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: opacityValue,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Animated Text
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
        ],
      ),
    );
  }
}
