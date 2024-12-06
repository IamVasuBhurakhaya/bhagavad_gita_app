import 'package:bhagavad_gita_app/helper/json_helper.dart';
import 'package:bhagavad_gita_app/model/json_model/chapter_model.dart';
import 'package:bhagavad_gita_app/model/json_model/verses_model.dart';
import 'package:flutter/material.dart';

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
}
