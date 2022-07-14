import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:randomizador/util/utils.dart';
import 'componentes/card_tile_row.dart';

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
  final _salvas = <WordPair>[];

  bool _isCard = false;
  String _nomeTrocaOpcaoCardTile = "card";

  Widget _salvasTile() {
    Iterable<ListTile> tiles = _salvas.map(
      (par) {
        return ListTile(
          title: Text(
            par.asSnakeCase,
            style: Utils.fonteStyleParPalavra,
          ),
        );
      },
    );

    List<Widget> divisao = tiles.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
        : <Widget>[];

    return ListView(children: divisao);
  }

  void _listarSalvas() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Sugestões Salvas"),
            ),
            body: _salvasTile(),
          );
        },
      ),
    );
  }

  void _opcaoEscolhida(context, value) {
    switch (value) {
      case 0:
        _listarSalvas();
        break;
      case 1:
        _trocarCardTile();
        break;
    }
  }

  void _trocarCardTile() {
    if (_nomeTrocaOpcaoCardTile == "card") {
      _nomeTrocaOpcaoCardTile = "tile";
    } else {
      _nomeTrocaOpcaoCardTile = "card";
    }
    setState(() {
      _isCard = !_isCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randomizador'),
        actions: [
          PopupMenuButton(
            onSelected: (value) => _opcaoEscolhida(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Text("Pares salvos"),
              ),
              PopupMenuItem(
                value: 1,
                child: Text("Trocar para $_nomeTrocaOpcaoCardTile"),
              )
            ],
          ),
        ],
      ),
      body: _buildSugestoes(),
    );
  }

  dynamic alternarSalvar(WordPair par, bool isSalva) {
    setState(() {
      if (isSalva) {
        _salvas.remove(par);
      } else {
        _salvas.add(par);
      }
    });
  }

  Widget _buildSugestoes() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          if (_isCard) {
            return const SizedBox();
          }
          return const Divider();
        }

        final int index = i ~/ 2;
        if (i >= _sugestoes.length - 2) {
          _sugestoes.addAll(generateWordPairs().take(10));
        }

        return cardTileRow(
            _sugestoes, _salvas, _isCard, index, i, alternarSalvar);
      },
    );
  }

  // Widget _buildRow(WordPair par) {
  //   final isSalva = _salvas.contains(par);

  //   void alternarSalvar() {
  //     setState(() {
  //       if (isSalva) {
  //         _salvas.remove(par);
  //       } else {
  //         _salvas.add(par);
  //       }
  //     });
  //   }

  //   Widget _botaoGostei() {
  //     return GestureDetector(
  //       child: Icon(
  //         isSalva ? Icons.favorite : Icons.favorite_border,
  //         color: isSalva ? Colors.red : null,
  //         semanticLabel: isSalva ? "Remover" : "Salvar",
  //       ),
  //       onTap: alternarSalvar,
  //     );
  //   }

  //   Widget _parTexto() {
  //     return Text(
  //       par.asSnakeCase,
  //       style: _fonteStyleMaior,
  //     );
  //   }

  //   Widget _buildTile(WordPair par) {
  //     return ListTile(
  //       title: _parTexto(),
  //       trailing: _botaoGostei(),
  //     );
  //   }

  //   Widget _buildCard(WordPair par) {
  //     return Expanded(
  //       child: Card(
  //         margin: const EdgeInsets.all(8.0),
  //         child: Padding(
  //           padding: const EdgeInsets.all(5.0),
  //           child: Column(
  //             children: [
  //               _parTexto(),
  //               const SizedBox(height: 10),
  //               _botaoGostei(),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  //   return _isCard ? _buildCard(par) : _buildTile(par);
  // }
}
