import 'package:bible/app/data/services/local_storage_service.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;
  final LocalStorageService _localStorageService;

  AuthRepository(this._authService, this._localStorageService);

  Future<UserModel> login(String email, String password) async {
    final authData = await _authService.login(email, password);
    final token = authData['token'];

    await _localStorageService.saveToken(token);

    return UserModel.fromJson(authData['user']);
  }

  Future<void> logout() async {
    await _localStorageService.deleteToken();
  }

  Future<String?> getToken() async {
    return _localStorageService.getToken();
  }

  Future<UserModel> getUser(String email) async {
    final token = await getToken();
    if (token == null) throw Exception('Usuário não autenticado.');

    final rawUser = await _authService.getUser(email, token);
    return UserModel.fromJson(rawUser);
  }
}
