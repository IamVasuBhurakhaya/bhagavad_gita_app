class BhagavadGitaModel {
  int? id, verses_count;
  String? chapter_summary,
      chapter_summary_hindi,
      chapter_summary_gujarati,
      chapter_summary_sanskrit;

  ChapterNumberModel? chapterNumberModel;
  NameModel? nameModel;
}

class ChapterNumberModel {
  String? hindi, gujarati, english, sanskrit;

  ChapterNumberModel({
    this.hindi,
    this.gujarati,
    this.english,
    this.sanskrit,
  });
}

class NameModel {
  String? hindi, gujarati, english, sanskrit;

  NameModel({
    this.hindi,
    this.gujarati,
    this.english,
    this.sanskrit,
  });
}
