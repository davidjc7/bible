import '../models/book_model.dart';
import '../services/bible_service.dart';

class BibleRepository {
  final BibleService _bibleService;

  BibleRepository(this._bibleService);

  Future<List<Book>> fetchBooks() async {
    return await _bibleService.getBooks();
  }
}
