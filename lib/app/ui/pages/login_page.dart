import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Bem-vindo!', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'E-mail'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        obscureText: true,
                        validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 24),
                      Consumer<LoginViewModel>(
                        builder: (context, viewModel, child) {
                          if (viewModel.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.login(
                                  context,
                                  _emailController.text,
                                  _passwordController.text,
                                );
                              }
                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Consumer<LoginViewModel>(
                        builder: (context, viewModel, child) {
                          if (viewModel.errorMessage != null) {
                            return Text(
                              viewModel.errorMessage!,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                        child: const Text('Não tem uma conta? Registre-se'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
