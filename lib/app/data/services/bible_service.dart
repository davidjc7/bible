import '../core/rest_client.dart';
import '../models/book_model.dart';
import 'local_storage_service.dart';

class BibleService {
  final RestClient _restClient;
  final LocalStorageService _localStorageService;

  BibleService(this._restClient, this._localStorageService);

  Future<List<Book>> getBooks() async {
    final token = await _localStorageService.getToken();

    final response = await _restClient.get('/books', token: token);

    final List<dynamic> bookListJson = response;

    return bookListJson.map((json) => Book.fromJson(json)).toList();
  }
}
