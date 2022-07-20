import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:randomizador/repositorio/par_repositorio.dart';
import 'package:randomizador/componentes/card_tile_row.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({
    Key? key,
    required this.parRepositorio,
    required this.isCard,
    required this.alternarCardTile,
    required this.atualizar,
  }) : super(key: key);

  final ParRepositorio parRepositorio;
  final bool isCard;
  final Function alternarCardTile;
  final Function atualizar;

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String _nomeTrocaOpcaoCardTile = "card";

  void _listarSalvas() {
    Navigator.pushNamed(context, '/salvas');
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
    widget.alternarCardTile();
  }

  Widget _buildSugestoes() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i >= widget.parRepositorio.sugestoes.length - 2) {
          generateWordPairs().take(20).forEach((par) {
            widget.parRepositorio.inserirNovoPar(par);
          });
        }

        return CardTileRow(
          parRepositorio: widget.parRepositorio,
          isCard: widget.isCard,
          index: i,
          tela: "lista",
          atualizar: () {
            setState(() {});
          },
        );
      },
    );
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
}
