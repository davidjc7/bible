import 'dart:convert';

import 'package:bible/app/core/app_urls.dart';
import 'package:bible/app/core/rest_client.dart';

class BibleService {
  final RestClient _restClient = RestClient(baseUrl: AppUrls.baseUrl);

  /// Busca a lista de todos os livros.
  Future<List<dynamic>> fetchBooks(String token) async {
    try {
      final response = await _restClient.get(
        '/books',
        headers: {'Authorization': 'Bearer $token'},
      );
      return json.decode(response.body);
    } catch (e) {
      throw Exception('Falha ao carregar os livros.');
    }
  }

  /// Busca o conteúdo de um capítulo específico.
  Future<Map<String, dynamic>> fetchChapter({
    required String version,
    required String abbrev,
    required int chapter,
    required String token,
  }) async {
    try {
      final path = '/verses/$version/$abbrev/$chapter';
      final response = await _restClient.get(path, headers: {'Authorization': 'Bearer $token'});
      return json.decode(response.body);
    } catch (e) {
      throw Exception('Falha ao carregar o capítulo.');
    }
  }
}
