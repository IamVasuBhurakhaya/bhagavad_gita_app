import 'dart:ui';
import 'package:bhagavad_gita_app/model/json_model/chapter_model.dart';
import 'package:bhagavad_gita_app/provider/json_provider.dart';
import 'package:bhagavad_gita_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VersesScreen extends StatefulWidget {
  const VersesScreen({super.key});

  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  late JsonProvider providerR;

  @override
  void initState() {
    super.initState();
    providerR = context.read<JsonProvider>();
    providerR.getVersesData();
  }

  @override
  Widget build(BuildContext context) {
    final providerW = context.watch<JsonProvider>();
    final ChapterModel model =
        ModalRoute.of(context)!.settings.arguments as ChapterModel;

    final chapterVerses = providerW.versesList
        .where((verse) => verse.chapter_number == model.id)
        .toList();

    String getChapterSummary() {
      switch (providerW.languageIndex) {
        case 0:
          return model.chapter_summary_sanskrit ?? "Summary unavailable";
        case 1:
          return model.chapter_summary_hindi ?? "Summary unavailable";
        case 2:
          return model.chapter_summary ?? "Summary unavailable";
        case 3:
          return model.chapter_summary_gujarati ?? "Summary unavailable";
        default:
          return model.chapter_summary_sanskrit ?? "Summary unavailable";
      }
    }

    String getAppBarTitle() {
      switch (providerW.languageIndex) {
        case 0:
          return "अध्याय ${model.id} के श्लोक";
        case 1:
          return "अध्याय ${model.id} के श्लोक";
        case 2:
          return "Verses of Chapter ${model.id}";
        case 3:
          return "અધ્યાય ${model.id} ના શ્લોક";
        default:
          return "अध्याय ${model.id} के श्लोक";
      }
    }

    String getChapterSummaryTitle(ChapterModel model) {
      switch (providerW.languageIndex) {
        case 0:
          return "अध्यायसारांशः ${model.id}";
        case 1:
          return "अध्याय ${model.id} का सारांश";
        case 2:
          return "Chapter ${model.id} Summary";
        case 3:
          return "પ્રકરણ ${model.id} સારાંશ";
        default:
          return "अध्यायसारांशः ${model.id}";
      }
    }

    String getVerseTitle(dynamic verse) {
      switch (providerW.languageIndex) {
        case 0:
          return verse.titleModel?.sanskrit ?? "Title unavailable";
        case 1:
          return verse.titleModel?.hindi ?? "Title unavailable";
        case 2:
          return verse.titleModel?.english ?? "Title unavailable";
        case 3:
          return verse.titleModel?.gujarati ?? "Title unavailable";
        default:
          return verse.titleModel?.sanskrit ?? "Title unavailable";
      }
    }

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
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Text(
                getAppBarTitle(),
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/cover2.jpg',
              fit: BoxFit.fill,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          getChapterSummaryTitle(model),
                          style: const TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          getChapterSummary(),
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: chapterVerses.length,
                    itemBuilder: (context, index) {
                      final verse = chapterVerses[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.shade200,
                                  Colors.pink.shade100
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.pageView,
                                  arguments: {'initialIndex': index},
                                );
                              },
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [Colors.deepOrange, Colors.yellow],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: Center(
                                  child: Text(
                                    "${verse.id}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                getVerseTitle(verse),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
