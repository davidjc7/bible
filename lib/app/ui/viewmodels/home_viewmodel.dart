import 'package:bible/app/data/repositories/bible_repository.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/book_model.dart';

class HomeViewModel extends ChangeNotifier {
  final BibleRepository bibleRepository;

  HomeViewModel(this.bibleRepository) {
    Future.microtask(() => fetchBooks());
  }

  List<Book> _books = [];
  List<Book> get books => _books;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> fetchBooks() async {
    try {
      _errorMessage = null;
      _books = await bibleRepository.getBooks();
    } catch (e) {
      debugPrint("Erro ao buscar livros: $e");
      _errorMessage = "Não foi possível carregar os livros. Tente novamente.";
    } finally {
      if (!_isDisposed) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }
}
