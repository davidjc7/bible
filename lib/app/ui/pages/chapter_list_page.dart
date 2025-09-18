import 'package:flutter/material.dart';

import '../../data/models/book_model.dart';
import 'verse_list_page.dart';

class ChapterListPage extends StatelessWidget {
  final Book book;

  const ChapterListPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.name)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: book.chapters,
        itemBuilder: (context, index) {
          final chapterNumber = index + 1;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerseListPage(
                    bookAbbrev: book.abbrev.pt,
                    chapterNumber: chapterNumber,
                    bookName: book.name,
                  ),
                ),
              );
            },
            child: Card(
              child: Center(
                child: Text(
                  '$chapterNumber',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
