import 'package:bhagavad_gita_app/helper/json_helper.dart';
import 'package:bhagavad_gita_app/model/json_model/json_model.dart';
import 'package:flutter/cupertino.dart';

class JsonProvider with ChangeNotifier {
  List<BhagavadGitaModel> chapterList = [];

  void getChapterData() async {
    JsonHelper helper = JsonHelper();
    chapterList = await helper.chapterJsonParsing();
    notifyListeners();
  }
}
