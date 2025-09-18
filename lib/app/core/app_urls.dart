abstract class AppUrls {
  static const String baseUrl = 'https://www.abibliadigital.com.br/api';

  static const String login = '/users/token';
  static String user(String email) => '/users/$email';
}
