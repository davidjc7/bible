import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/book_model.dart';
import '../viewmodels/home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Bíblia Sagrada'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              viewModel.logout(context);
            },
          ),
        ],
      ),
      body: _buildBody(viewModel),
    );
  }

  Widget _buildBody(HomeViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Ocorreu um erro: ${viewModel.errorMessage}',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (viewModel.books.isEmpty) {
      return const Center(child: Text('Nenhum livro encontrado.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: viewModel.books.length,
      itemBuilder: (context, index) {
        final Book book = viewModel.books[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(
                book.testament == 'VT' ? 'AT' : 'NT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
            title: Text(book.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${book.author} • ${book.group}'),
            trailing: Text(
              '${book.chapters} cap.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        );
      },
    );
  }
}
