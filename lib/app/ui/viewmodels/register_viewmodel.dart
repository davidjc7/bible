import 'package:flutter/material.dart';

import '../../data/repositories/auth_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  RegisterViewModel(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> register(BuildContext context, String name, String email, String password, bool notifications) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authRepository.registerUser(name, email, password, notifications);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
