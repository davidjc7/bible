import '../models/book_model.dart';
import '../models/chapter_details_model.dart';
import '../services/bible_service.dart';
import 'auth_repository.dart';

class BibleRepository {
  final BibleService _bibleService;
  final AuthRepository _authRepository;

  BibleRepository(this._bibleService, this._authRepository);

  Future<List<Book>> getBooks() async {
    final token = await _authRepository.getToken();
    if (token == null) throw Exception("Usuário não autenticado.");

    final List<dynamic> rawBooks = await _bibleService.fetchBooks(token);
    return rawBooks.map((json) => Book.fromJson(json)).toList();
  }

  Future<ChapterDetails> getChapter(String version, String abbrev, int chapter) async {
    final token = await _authRepository.getToken();
    if (token == null) throw Exception("Usuário não autenticado.");

    final Map<String, dynamic> rawChapter = await _bibleService.fetchChapter(
      version: version,
      abbrev: abbrev,
      chapter: chapter,
      token: token,
    );

    return ChapterDetails.fromJson(rawChapter);
  }
}
