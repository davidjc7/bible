import 'package:bible/app/ui/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/book_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/bible_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final BibleRepository _bibleRepository;

  HomeViewModel(this._authRepository, this._bibleRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Book> _books = [];
  List<Book> get books => _books;

  String? _userName;
  String? get userName => _userName;

  Future<void> loadInitialData() async {
    _setLoading(true);
    _errorMessage = null;

    await Future.wait([
      _loadUserName(),
      fetchBooks(),
    ]);

    _setLoading(false);
  }

  Future<void> _loadUserName() async {
    _userName = await _authRepository.getUserName();
    notifyListeners();
  }

  Future<void> fetchBooks() async {
    try {
      _books = await _bibleRepository.fetchBooks();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<void> logout(BuildContext context) async {
    await _authRepository.logoutUser();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
