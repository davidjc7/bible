import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/register_viewmodel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _notifications = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
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
                      Text('Registro', style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nome'),
                        validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 16),
                      CheckboxListTile(
                        title: const Text("Receber notificações"),
                        value: _notifications,
                        onChanged: (newValue) {
                          setState(() {
                            _notifications = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 24),
                      Consumer<RegisterViewModel>(
                        builder: (context, viewModel, child) {
                          if (viewModel.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.register(
                                  context,
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                  _notifications,
                                );
                              }
                            },
                            child: const Text(
                              'Registrar',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Consumer<RegisterViewModel>(
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
                        onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                        child: const Text('Já tem uma conta? Faça login'),
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
