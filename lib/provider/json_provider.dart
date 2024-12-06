import 'package:bhagavad_gita_app/helper/json_helper.dart';
import 'package:bhagavad_gita_app/model/json_model/chapter_model.dart';
import 'package:bhagavad_gita_app/model/json_model/verses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class JsonProvider with ChangeNotifier {
  List<ChapterModel> chapterList = [];
  List<VersesModel> versesList = [];
  List<VersesModel> chapterWiseVersesList = [];

  int languageIndex = 0;

  void setLanguageIndex(int index) {
    languageIndex = index;
    notifyListeners();
  }

  void getChapterData() async {
    JsonHelper helper = JsonHelper();
    chapterList = await helper.chapterJsonParsing();
    notifyListeners();
  }

  void getVersesData() async {
    JsonHelper helper = JsonHelper();
    versesList = await helper.versesJsonParsing();
    notifyListeners();
  }

  void chapterWiseVerse(int chapterId) {
    chapterWiseVersesList =
        versesList.where((verse) => verse.chapter_number == chapterId).toList();
    notifyListeners();
  }

  VersesModel? getVerseById(int chapterId, int verseId) {
    return versesList.firstWhere(
      (verse) => verse.chapter_number == chapterId && verse.id == verseId,
    );
  }

  List<String> chapterBackgroundImages = [
    'assets/bg/1.jpg',
    'assets/bg/2.jpg',
    'assets/bg/3.jpg',
    'assets/bg/4.jpg',
    'assets/bg/5.jpg',
    'assets/bg/6.jpg',
    'assets/bg/7.jpg',
    'assets/bg/8.jpg',
    'assets/bg/9.jpg',
    'assets/bg/10.jpg',
    'assets/bg/11.jpg',
    'assets/bg/12.jpg',
    'assets/bg/_13.jpg',
    'assets/bg/14.jpg',
    'assets/bg/15.jpg',
    'assets/bg/16.jpg',
    'assets/bg/17.jpg',
    'assets/bg/18.jpg',
  ];

  String getChapterBackgroundImage(int chapterIndex) {
    if (chapterIndex >= 0 && chapterIndex < chapterBackgroundImages.length) {
      return chapterBackgroundImages[chapterIndex];
    }
    return 'assets/bg/default.jpg';
  }

  void changeVerseIndexAsVerseNo(int chapterNo) {}

  FlutterTts flutterTts = FlutterTts();
  bool isPlay = false;

  void speakText(String verseText) async {
    if (await flutterTts.isLanguageAvailable("en-US")) {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setSpeechRate(0.5);

      if (isPlay) {
        await flutterTts.stop();
        isPlay = false;
      } else {
        await flutterTts.speak(verseText);
        isPlay = true;
      }
    } else {
      print("Text-to-Speech not available");
    }
    notifyListeners();
  }

  void stopSpeaking() async {
    await flutterTts.stop();
    isPlay = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
