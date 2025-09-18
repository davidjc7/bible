import 'book_model.dart';
import 'chapter_info_model.dart';
import 'verse_model.dart';

class ChapterDetails {
  final Book book;
  final ChapterInfo chapterInfo;
  final List<Verse> verses;

  ChapterDetails({
    required this.book,
    required this.chapterInfo,
    required this.verses,
  });

  factory ChapterDetails.fromJson(Map<String, dynamic> json) {
    var versesList = json['verses'] as List;
    List<Verse> verseObjects = versesList.map((i) => Verse.fromJson(i)).toList();

    return ChapterDetails(
      book: Book.fromJson(json['book']),
      chapterInfo: ChapterInfo.fromJson(json['chapter']),
      verses: verseObjects,
    );
  }
}
