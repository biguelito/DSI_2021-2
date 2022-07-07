import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RandomizerApp',
      home: Randomizer(),
    );
  }
}

class Randomizer extends StatefulWidget {
  const Randomizer({Key? key}) : super(key: key);

  @override
  State<Randomizer> createState() => _RandomizerState();
}

class _RandomizerState extends State<Randomizer> {
  final _sugestoes = <WordPair>[];
  final _fonteStyleMaior = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo ao randomizador'),
      ),
      body: _buildSugestoes(),
    );

    // return _buildSugestoes();
  }

  Widget _buildSugestoes() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        }

        final int index = i ~/ 2;
        if (index >= _sugestoes.length) {
          _sugestoes.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_sugestoes[index]);
      },
    );
  }

  Widget _buildRow(WordPair par) {
    return ListTile(
      title: Text(
        par.asSnakeCase,
        style: _fonteStyleMaior,
      ),
    );
  }
}
