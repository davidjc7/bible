import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/chapter_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';

class VerseListPage extends StatelessWidget {
  final String bookAbbrev;
  final int chapterNumber;
  final String bookName;

  const VerseListPage({
    super.key,
    required this.bookAbbrev,
    required this.chapterNumber,
    required this.bookName,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChapterViewModel(
        Provider.of<HomeViewModel>(context, listen: false).bibleRepository,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('$bookName $chapterNumber'),
        ),
        body: _VerseListBody(
          abbrev: bookAbbrev,
          chapter: chapterNumber,
        ),
      ),
    );
  }
}

class _VerseListBody extends StatefulWidget {
  final String abbrev;
  final int chapter;

  const _VerseListBody({required this.abbrev, required this.chapter});

  @override
  State<_VerseListBody> createState() => _VerseListBodyState();
}

class _VerseListBodyState extends State<_VerseListBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChapterViewModel>().fetchChapter(widget.abbrev, widget.chapter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChapterViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                viewModel.error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (viewModel.chapterDetails == null) {
          return const Center(child: Text('Nenhum dado para exibir.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: viewModel.chapterDetails!.verses.length,
          itemBuilder: (context, index) {
            final verse = viewModel.chapterDetails!.verses[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style.copyWith(fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${verse.number} ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                    ),
                    TextSpan(text: verse.text),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
