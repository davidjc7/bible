import 'package:flutter/foundation.dart';

import 'auth_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthViewModel _authViewModel;

  LoginViewModel(this._authViewModel);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final success = await _authViewModel.login(email, password);

    if (_isDisposed) {
      return success;
    }

    if (!success) {
      _errorMessage = "Email ou senha inválidos.";
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }
}
