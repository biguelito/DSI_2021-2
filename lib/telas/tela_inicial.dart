import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:randomizador/modelos/par.dart';
import 'package:randomizador/modelos/par_dto.dart';
import 'package:randomizador/repositorio/par_repositorio.dart';
import 'package:randomizador/componentes/card_tile_row.dart';

class TelaInicial extends StatefulWidget {
  final ParRepositorio parRepositorio;
  final bool isCard;
  final Function alternarCardTile;
  final Function atualizar;
  final String nomeOpcaoCardTile;

  const TelaInicial({
    Key? key,
    required this.parRepositorio,
    required this.isCard,
    required this.alternarCardTile,
    required this.atualizar,
    required this.nomeOpcaoCardTile,
  }) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  void _listarSalvas() {
    Navigator.pushNamed(
      context,
      '/salvas',
      arguments: widget.parRepositorio.salvas,
    ).then((novasSalvas) {
      setState(() {
        widget.parRepositorio.salvas = novasSalvas as List<Par>;
      });
    });
  }

  void _opcaoEscolhida(context, value) {
    switch (value) {
      case 0:
        _listarSalvas();
        break;
      case 1:
        widget.alternarCardTile();
        break;
    }
  }

  Future<void> _editarPar() async {
    String acao = "Inserir";

    final resultado = await Navigator.pushNamed(
      context,
      '/inserireditarparform',
      arguments: ParDto(null, acao),
    );
    if (resultado != null) {
      setState(() {
        Par parRetorno = resultado as Par;
        widget.parRepositorio.inserirNovoPar(parRetorno);
        widget.atualizar();
      });
    }
  }

  Widget _buildSugestoes() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i >= widget.parRepositorio.sugestoes.length - 2) {
          generateWordPairs().take(20).forEach((par) {
            widget.parRepositorio.inserirNovoWordPair(par);
          });
        }

        return CardTileRow(
          parRepositorio: widget.parRepositorio,
          isCard: widget.isCard,
          index: i,
          tela: "inicial",
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
                child: Text("Trocar para ${widget.nomeOpcaoCardTile}"),
              )
            ],
          ),
        ],
      ),
      body: _buildSugestoes(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editarPar(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
