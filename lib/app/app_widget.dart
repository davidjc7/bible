import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/pages/home_page.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/splash_page.dart';
import 'ui/viewmodels/auth_view_model.dart';
import 'ui/viewmodels/home_viewmodel.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bíblia Sagrada',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthViewModel>(
        builder: (context, auth, child) {
          switch (auth.status) {
            case AuthStatus.Unauthenticated:
              return const LoginPage();
            case AuthStatus.Authenticating:
              return const SplashPage();
            case AuthStatus.Authenticated:
              context.read<HomeViewModel>().fetchBooks();
              return const HomePage();
            default:
              return const LoginPage();
          }
        },
      ),
    );
  }
}
