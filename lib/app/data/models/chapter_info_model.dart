class ChapterInfo {
  final int number;
  final int verses;

  ChapterInfo({
    required this.number,
    required this.verses,
  });

  factory ChapterInfo.fromJson(Map<String, dynamic> json) {
    return ChapterInfo(
      number: json['number'],
      verses: json['verses'],
    );
  }
}
