import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';

class AuthRepository {
  final AuthService _authService;
  final LocalStorageService _localStorageService;

  AuthRepository(this._authService, this._localStorageService);

  String? _userNameCache;

  Future<User> registerUser(String name, String email, String password, bool notifications) async {
    final user = await _authService.register(name, email, password, notifications);
    await _localStorageService.saveToken(user.token);
    await _localStorageService.saveUserName(user.name);
    _userNameCache = user.name;
    return user;
  }

  Future<User> loginUser(String email, String password) async {
    final user = await _authService.login(email, password);
    await _localStorageService.saveToken(user.token);
    await _localStorageService.saveUserName(user.name);
    _userNameCache = user.name;
    return user;
  }

  Future<void> logoutUser() async {
    await _localStorageService.clearToken();
    _userNameCache = null;
  }

  Future<String?> getUserName() async {
    return _userNameCache;
  }
}
