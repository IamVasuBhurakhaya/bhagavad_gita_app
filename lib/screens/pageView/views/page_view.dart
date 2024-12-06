import 'dart:ui';

import 'package:bhagavad_gita_app/provider/json_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageViewScreen extends StatefulWidget {
  final int initialIndex;

  const PageViewScreen({super.key, required this.initialIndex});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  late PageController pageController;
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialIndex);
  }

  String getAppBarTitle(JsonProvider provider, int index) {
    switch (provider.languageIndex) {
      case 0:
        return "अध्याय $index के श्लोक";
      case 1:
        return "अध्याय $index के श्लोक";
      case 2:
        return "Verses of Chapter $index";
      case 3:
        return "અધ્યાય $index ના શ્લોક";
      default:
        return "अध्याय $index के श्लोक";
    }
  }

  String getVerseTitle(dynamic titleModel, int languageIndex) {
    switch (languageIndex) {
      case 0:
        return " ${titleModel.hindi ?? 'अज्ञात'}";
      case 1:
        return " ${titleModel.hindi ?? 'अज्ञात'}";
      case 2:
        return " ${titleModel.english ?? 'Unknown'}";
      case 3:
        return " ${titleModel.gujarati ?? 'અજ્ઞાત'}";
      default:
        return " ${titleModel.hindi ?? 'अज्ञात'}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerW = context.watch<JsonProvider>();
    final languageIndex = providerW.languageIndex;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/image/appBar.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Text(
                getAppBarTitle(providerW, widget.initialIndex + 1),
                style: const TextStyle(
                  fontSize: 36,
                  height: 1.8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: providerW.chapterWiseVersesList.length,
        itemBuilder: (context, index) {
          String verseText = languageIndex == 0
              ? providerW.chapterWiseVersesList[index].textModel!.sanskrit ??
                  "Verse text unavailable"
              : languageIndex == 1
                  ? providerW.chapterWiseVersesList[index].textModel!.hindi ??
                      "Verse text unavailable"
                  : languageIndex == 2
                      ? providerW.chapterWiseVersesList[index].textModel!
                              .english ??
                          "Verse text unavailable"
                      : languageIndex == 3
                          ? providerW.chapterWiseVersesList[index].textModel!
                                  .gujarati ??
                              "Verse text unavailable"
                          : "Verse text unavailable";

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  providerW.chapterBackgroundImages[index],
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 400,
                  height: 600,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage("assets/image/verses_bg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 65,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 160),
                      Text(
                        getVerseTitle(
                            providerW.chapterWiseVersesList[index].titleModel,
                            languageIndex),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        verseText,
                        style: const TextStyle(
                          color: Color(0xff800200),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 6,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          if (isSpeaking) {
                            providerW.stopSpeaking();
                          } else {
                            providerW.speakText(verseText);
                          }

                          setState(() {
                            isSpeaking = !isSpeaking;
                          });
                        },
                        icon: Icon(
                          isSpeaking
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
