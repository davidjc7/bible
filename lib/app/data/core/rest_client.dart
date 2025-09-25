import 'dart:convert';
import 'package:http/http.dart' as http;

class RestClient {
  final String _baseUrl = "https://www.abibliadigital.com.br/api";

  final Map<String, String> _baseHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String endpoint, {String? token}) async {
    final headers = {..._baseHeaders};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    final response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: headers,
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _baseHeaders,
      body: jsonEncode(body),
    );

    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _baseHeaders,
      body: jsonEncode(body),
    );

    return _handleResponse(response) as Map<String, dynamic>;
  }

  dynamic _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else {
      final errorMessage = body is Map ? body['msg'] : 'Erro na requisição';
      throw Exception(errorMessage);
    }
  }
}
