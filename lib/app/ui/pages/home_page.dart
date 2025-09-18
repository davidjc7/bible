import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/book_model.dart';
import '../viewmodels/auth_view_model.dart';
import '../viewmodels/home_viewmodel.dart';
import 'chapter_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bíblia Sagrada'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthViewModel>().logout();
            },
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(viewModel.errorMessage!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.fetchBooks(),
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.isLoading && viewModel.books.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.books.isEmpty) {
            return const Center(child: Text('Nenhum livro encontrado.'));
          }

          return ListView.builder(
            itemCount: viewModel.books.length,
            itemBuilder: (context, index) {
              final Book book = viewModel.books[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(book.name),
                  subtitle: Text(book.group),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChapterListPage(book: book),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
