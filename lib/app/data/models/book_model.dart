import 'book_abbrev_model.dart';

class Book {
  final BookAbbrev abbrev;
  final String name;
  final String author;
  final String group;
  final String testament;
  final int chapters;

  Book({
    required this.abbrev,
    required this.name,
    required this.author,
    required this.group,
    required this.testament,
    required this.chapters,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      abbrev: BookAbbrev.fromJson(json['abbrev']),
      name: json['name'],
      author: json['author'],
      group: json['group'],
      testament: json['testament'],
      chapters: json['chapters'],
    );
  }
}
