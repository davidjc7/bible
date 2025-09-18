import 'package:flutter/foundation.dart';

import '../../data/models/chapter_details_model.dart';
import '../../data/repositories/bible_repository.dart';

class ChapterViewModel extends ChangeNotifier {
  final BibleRepository _repository;

  ChapterViewModel(this._repository);

  ChapterDetails? _chapterDetails;
  ChapterDetails? get chapterDetails => _chapterDetails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchChapter(String abbrev, int chapter) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _chapterDetails = await _repository.getChapter('nvi', abbrev, chapter);
    } catch (e) {
      _error = "Não foi possível carregar o capítulo. Tente novamente.";
      debugPrint("Erro ao buscar capítulo: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
