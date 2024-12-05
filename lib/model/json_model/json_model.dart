class BhagavadGitaModel {
  int? id, verses_count;
  String? chapter_summary,
      chapter_summary_hindi,
      chapter_summary_gujarati,
      chapter_summary_sanskrit;

  ChapterNumberModel? chapterNumberModel;
  NameModel? nameModel;

  BhagavadGitaModel({
    this.id,
    this.verses_count,
    this.chapter_summary,
    this.chapter_summary_hindi,
    this.chapter_summary_gujarati,
    this.chapter_summary_sanskrit,
    this.chapterNumberModel,
    this.nameModel,
  });

  factory BhagavadGitaModel.mapToModel(Map m1) {
    return BhagavadGitaModel(
        id: m1['id'],
        verses_count: m1['verses_count'],
        chapter_summary: m1['chapter_summary'],
        chapter_summary_hindi: m1['chapter_summary_hindi'],
        chapter_summary_gujarati: m1['chapter_summary_gujarati'],
        chapter_summary_sanskrit: m1['chapter_summary_sanskrit'],
        nameModel: NameModel.mapToModel(m1['name']),
        chapterNumberModel:
            ChapterNumberModel.mapToModel(m1['chapter_number']));
  }
}

class ChapterNumberModel {
  String? hindi, gujarati, english, sanskrit;

  ChapterNumberModel({
    this.hindi,
    this.gujarati,
    this.english,
    this.sanskrit,
  });

  factory ChapterNumberModel.mapToModel(Map m1) {
    return ChapterNumberModel(
      hindi: m1['hindi'],
      gujarati: m1['gujarati'],
      english: m1['english'],
      sanskrit: m1['sanskrit'],
    );
  }
}

class NameModel {
  String? hindi, gujarati, english, sanskrit;

  NameModel({
    this.hindi,
    this.gujarati,
    this.english,
    this.sanskrit,
  });

  factory NameModel.mapToModel(Map m1) {
    return NameModel(
      hindi: m1['hindi'],
      gujarati: m1['gujarati'],
      english: m1['english'],
      sanskrit: m1['sanskrit'],
    );
  }
}
