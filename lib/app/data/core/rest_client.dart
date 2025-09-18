import 'dart:convert';
import 'package:http/http.dart' as http;

class RestClient {
  final String _baseUrl;
  final http.Client _client;

  RestClient({required String baseUrl, http.Client? client}) : _baseUrl = baseUrl, _client = client ?? http.Client();

  /// Realiza uma requisição GET.
  Future<http.Response> get(String path, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$_baseUrl$path');
    final response = await _client.get(uri, headers: headers);
    _handleResponse(response);
    return response;
  }

  /// Realiza uma requisição POST.
  Future<http.Response> post(String path, {dynamic body, Map<String, String>? headers}) async {
    final defaultHeaders = {'content-type': 'application/json; charset=utf-8'};
    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    final uri = Uri.parse('$_baseUrl$path');
    final response = await _client.post(uri, headers: defaultHeaders, body: jsonEncode(body));
    _handleResponse(response);
    return response;
  }

  /// Realiza uma requisição PUT.
  Future<http.Response> put(String path, {dynamic body, Map<String, String>? headers}) async {
    final defaultHeaders = {'content-type': 'application/json; charset=utf-8'};
    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    final uri = Uri.parse('$_baseUrl$path');
    final response = await _client.put(uri, headers: defaultHeaders, body: jsonEncode(body));
    _handleResponse(response);
    return response;
  }

  void _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Erro na requisição: Status ${response.statusCode}',
      );
    }
  }
}
