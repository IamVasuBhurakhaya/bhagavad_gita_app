class VersesModel {
  int? id, chapter_number;
  TextModel? textModel;
  TitleModel? titleModel;

  VersesModel({
    this.id,
    this.chapter_number,
    this.textModel,
    this.titleModel,
  });

  factory VersesModel.mapToModel(Map m1) {
    return VersesModel(
      id: m1[''],
      chapter_number: m1[''],
      textModel: TextModel.mapTOModel(m1['text']),
      titleModel: TitleModel.mapTOModel(m1['title']),
    );
  }
}

class TextModel {
  String? sanskrit, hindi, english, gujarati;

  TextModel({
    this.sanskrit,
    this.hindi,
    this.english,
    this.gujarati,
  });

  factory TextModel.mapTOModel(Map m1) {
    return TextModel(
      sanskrit: m1['sanskrit'],
      hindi: m1['hindi'],
      english: m1['english'],
      gujarati: m1['gujarati'],
    );
  }
}

class TitleModel {
  String? sanskrit, hindi, english, gujarati;

  TitleModel({
    this.sanskrit,
    this.hindi,
    this.english,
    this.gujarati,
  });

  factory TitleModel.mapTOModel(Map m1) {
    return TitleModel(
      sanskrit: m1['sanskrit'],
      hindi: m1['hindi'],
      english: m1['english'],
      gujarati: m1['gujarati'],
    );
  }
}
