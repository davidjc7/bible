import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app_widget.dart';
import 'app/data/repositories/auth_repository.dart';
import 'app/data/repositories/bible_repository.dart';
import 'app/data/services/auth_service.dart';
import 'app/data/services/bible_service.dart';
import 'app/data/services/local_storage_service.dart';
import 'app/ui/viewmodels/auth_view_model.dart';
import 'app/ui/viewmodels/home_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorageService = await LocalStorageService.getInstance();
  final authService = AuthService();
  final bibleService = BibleService();

  final authRepository = AuthRepository(authService, localStorageService);
  final bibleRepository = BibleRepository(bibleService, authRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(bibleRepository),
        ),
      ],
      child: const AppWidget(),
    ),
  );
}
