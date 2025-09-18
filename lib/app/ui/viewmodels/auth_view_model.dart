import 'package:flutter/foundation.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

enum AuthStatus { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthStatus _status = AuthStatus.Uninitialized;
  AuthStatus get status => _status;

  UserModel? _user;
  UserModel? get user => _user;

  AuthViewModel(this._authRepository) {
    _tryAutoLogin();
  }

  Future<bool> login(String email, String password) async {
    _status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      _user = await _authRepository.login(email, password);
      _status = AuthStatus.Authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<void> _tryAutoLogin() async {
    final token = await _authRepository.getToken();
    if (token == null) {
      _status = AuthStatus.Unauthenticated;
    } else {
      _status = AuthStatus.Authenticated;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _status = AuthStatus.Unauthenticated;
    _user = null;
    await _authRepository.logout();
    notifyListeners();
  }
}
