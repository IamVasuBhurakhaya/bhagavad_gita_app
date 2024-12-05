import 'dart:convert';

import 'package:bhagavad_gita_app/model/json_model/json_model.dart';
import 'package:flutter/services.dart';

class JsonHelper {
  Future<List<BhagavadGitaModel>> chapterJsonParsing() async {
    String jsonString = await rootBundle.loadString("assets/chapters.json");
    List jsonList = jsonDecode(jsonString);

    List<BhagavadGitaModel> chapterList = jsonList
        .map(
          (e) => BhagavadGitaModel(
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
}
