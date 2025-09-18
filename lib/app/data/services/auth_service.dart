import 'dart:convert';

import 'package:bible/app/core/app_urls.dart';
import 'package:bible/app/core/rest_client.dart';

class AuthService {
  final RestClient _restClient = RestClient(baseUrl: AppUrls.baseUrl);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _restClient.put(
        AppUrls.login,
        body: {
          'email': email,
          'password': password,
        },
      );
      return json.decode(response.body);
    } catch (e) {
      throw Exception('Falha ao fazer login. Verifique suas credenciais.');
    }
  }

  Future<Map<String, dynamic>> getUser(String email, String token) async {
    try {
      final response = await _restClient.get(
        AppUrls.user(email),
        headers: {'Authorization': 'Bearer $token'},
      );
      return json.decode(response.body);
    } catch (e) {
      throw Exception('Falha ao buscar dados do usuário.');
    }
  }
}
