import 'package:flutter/material.dart';

import '../../data/services/local_storage_service.dart';

class SplashViewModel extends ChangeNotifier {
  final LocalStorageService _localStorageService;

  SplashViewModel(this._localStorageService);

  Future<void> checkLoginStatus(BuildContext context) async {
    // Um pequeno delay para a splash ser visível
    await Future.delayed(const Duration(seconds: 2));

    final token = await _localStorageService.getToken();
    if (token != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
