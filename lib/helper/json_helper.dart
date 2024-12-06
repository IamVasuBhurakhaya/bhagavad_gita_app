import 'dart:convert';

import 'package:bhagavad_gita_app/model/json_model/chapter_model.dart';
import 'package:bhagavad_gita_app/model/json_model/verses_model.dart';
import 'package:flutter/services.dart';

class JsonHelper {
  Future<List<ChapterModel>> chapterJsonParsing() async {
    String jsonString = await rootBundle.loadString("assets/chapters.json");
    List jsonList = jsonDecode(jsonString);

    List<ChapterModel> chapterList = jsonList
        .map(
          (e) => ChapterModel(
            id: e['id'],
            verses_count: e['verses_count'],
            chapter_summary: e['chapter_summary'],
            chapter_summary_hindi: e['chapter_summary_hindi'],
            chapter_summary_gujarati: e['chapter_summary_gujarati'],
            chapter_summary_sanskrit: e['chapter_summary_sanskrit'],
            nameModel: NameModel.mapToModel(e['name']),
            chapterNumberModel:
                ChapterNumberModel.mapToModel(e['chapter_number']),
          ),
        )
        .toList();

    return chapterList;
  }

  Future<List<VersesModel>> versesJsonParsing() async {
    String? json = await rootBundle.loadString("assets/verses.json");
    List jsonList = jsonDecode(json);

    List<VersesModel> versesList = jsonList
        .map(
          (e) => VersesModel(
            id: e['id'],
            chapter_number: e['chapter_number'],
            textModel: TextModel.mapTOModel(e['text']),
            titleModel: TitleModel.mapTOModel(e['title']),
          ),
        )
        .toList();
    return versesList;
  }
}
