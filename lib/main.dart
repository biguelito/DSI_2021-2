import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RandomizerApp',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.purple.shade800,
        ),
      ),
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
  final _salvas = <WordPair>[];

  void _listarSalvas() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _salvas.map(
            (par) {
              return ListTile(
                title: Text(
                  par.asSnakeCase,
                  style: _fonteStyleMaior,
                ),
              );
            },
          );

          final divisao = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text("Sugestões Salvas"),
            ),
            body: ListView(
              children: divisao,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Randomizador'),
        actions: [
          IconButton(
            onPressed: _listarSalvas,
            icon: const Icon(Icons.list),
            tooltip: "Sugestões salvas",
          )
        ],
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
    final isSalva = _salvas.contains(par);

    return ListTile(
      title: Text(
        par.asSnakeCase,
        style: _fonteStyleMaior,
      ),
      trailing: Icon(
        isSalva ? Icons.favorite : Icons.favorite_border,
        color: isSalva ? Colors.red : null,
        semanticLabel: isSalva ? "Remover" : "Salvar",
      ),
      onTap: () {
        setState(() {
          if (isSalva) {
            _salvas.remove(par);
          } else {
            _salvas.add(par);
          }
        });
      },
    );
  }
}
