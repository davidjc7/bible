import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/data/core/rest_client.dart';
import 'app/data/repositories/auth_repository.dart';
import 'app/data/repositories/bible_repository.dart';
import 'app/data/services/auth_service.dart';
import 'app/data/services/bible_service.dart';
import 'app/data/services/local_storage_service.dart';
import 'app/ui/pages/home_page.dart';
import 'app/ui/pages/login_page.dart';
import 'app/ui/pages/register_page.dart';
import 'app/ui/pages/splash_page.dart';
import 'app/ui/viewmodels/home_viewmodel.dart';
import 'app/ui/viewmodels/login_viewmodel.dart';
import 'app/ui/viewmodels/register_viewmodel.dart';
import 'app/ui/viewmodels/splash_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RestClient>(create: (_) => RestClient()),
        Provider<LocalStorageService>(create: (_) => LocalStorageService()),

        Provider<AuthService>(
          create: (context) => AuthService(context.read<RestClient>()),
        ),
        Provider<BibleService>(
          create: (context) => BibleService(
            context.read<RestClient>(),
            context.read<LocalStorageService>(),
          ),
        ),

        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            context.read<AuthService>(),
            context.read<LocalStorageService>(),
          ),
        ),
        Provider<BibleRepository>(
          create: (context) => BibleRepository(context.read<BibleService>()),
        ),

        ChangeNotifierProvider<SplashViewModel>(
          create: (context) => SplashViewModel(context.read<LocalStorageService>()),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create: (context) => RegisterViewModel(context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (context) => LoginViewModel(context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(
            context.read<AuthRepository>(),
            context.read<BibleRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Bible App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        routes: {
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
        },
      ),
    );
  }
}
