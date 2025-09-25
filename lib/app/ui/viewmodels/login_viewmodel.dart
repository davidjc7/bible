import 'package:flutter/material.dart';

import '../../data/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> login(BuildContext context, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.loginUser(email, password);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
