import 'package:bible/app/data/core/rest_client.dart';
import 'package:bible/app/data/models/user_model.dart';

class AuthService {
  final RestClient _restClient;

  AuthService(this._restClient);

  Future<User> register(String name, String email, String password, bool notifications) async {
    final response = await _restClient.post('/users', {
      'name': name,
      'email': email,
      'password': password,
      'notifications': notifications,
    });
    return User.fromJson(response);
  }

  Future<User> login(String email, String password) async {
    final response = await _restClient.put('/users/token', {
      'email': email,
      'password': password,
    });
    return User.fromJson(response);
  }
}
