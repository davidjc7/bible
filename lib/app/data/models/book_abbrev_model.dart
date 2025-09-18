class BookAbbrev {
  final String pt;
  final String en;

  BookAbbrev({
    required this.pt,
    required this.en,
  });

  factory BookAbbrev.fromJson(Map<String, dynamic> json) {
    return BookAbbrev(
      pt: json['pt'],
      en: json['en'],
    );
  }
}
