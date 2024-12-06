import 'dart:math';

import 'package:bhagavad_gita_app/helper/json_helper.dart';
import 'package:bhagavad_gita_app/model/json_model/chapter_model.dart';
import 'package:bhagavad_gita_app/model/json_model/verses_model.dart';
import 'package:flutter/cupertino.dart';

class JsonProvider with ChangeNotifier {
  List<ChapterModel> chapterList = [];
  List<VersesModel> versesList = [];
  List chapterWiseVersesList = [];

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

  void chapterWiseVerse(int verses_count) {
    chapterWiseVersesList = versesList
        .where(
          (element) => element.chapter_number == verses_count,
        )
        .toList();
    print("=================================${versesList.length}");
    notifyListeners();
  }
}
