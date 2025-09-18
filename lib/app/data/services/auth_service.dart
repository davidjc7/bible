import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _baseUrl = 'https://www.abibliadigital.com.br/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/users/token'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao fazer login. Verifique suas credenciais.');
    }
  }

  Future<Map<String, dynamic>> getUser(String email, String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$email'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao buscar dados do usuário.');
    }
  }
}
