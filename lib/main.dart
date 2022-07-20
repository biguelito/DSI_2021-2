import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'componentes/card_tile_row.dart';
import 'package:randomizador/util/utils.dart';
import 'package:randomizador/repositorio/par_repositorio.dart';

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
  final ParRepositorio _parRepositorio = ParRepositorio();

  bool _isCard = false;
  String _nomeTrocaOpcaoCardTile = "card";

  // TODO: ajustar rota
  Widget _salvasTile() {
    Iterable<ListTile> tiles = _parRepositorio.salvas.map(
      (par) {
        return ListTile(
          title: Text(
            par.obter(),
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
        if (i >= _parRepositorio.sugestoes.length - 2) {
          generateWordPairs().take(20).forEach((par) {
            _parRepositorio.inserirNovoPar(par);
          });
        }

        return CardTileRow(
          parRepositorio: _parRepositorio,
          isCard: _isCard,
          index: index,
          i: i,
          tipoTela: "lista",
        );
      },
    );
  }
}
