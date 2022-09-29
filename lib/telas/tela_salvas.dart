import 'package:flutter/material.dart';
import 'package:randomizador/componentes/card_tile_row.dart';
import 'package:randomizador/componentes/saved_card_tile_row.dart';
import 'package:randomizador/repositorio/par_repositorio.dart';
import 'package:randomizador/modelos/par.dart';

class TelaSalvas extends StatefulWidget {
  const TelaSalvas({
    Key? key,
    required this.parRepositorio,
    required this.isCard,
    required this.atualizar,
    required this.alternarCardTile,
    required this.nomeOpcaoCardTile,
  }) : super(key: key);

  final ParRepositorio parRepositorio;
  final bool isCard;
  final Function atualizar;
  final Function alternarCardTile;
  final String nomeOpcaoCardTile;

  @override
  State<TelaSalvas> createState() => _TelaSalvasState();
}

class _TelaSalvasState extends State<TelaSalvas> {
  Widget _salvasRow() {
    return ListView.builder(
      itemCount: widget.parRepositorio.salvas.length,
      itemBuilder: (BuildContext _context, int i) {
        return widget.parRepositorio.salvas.isNotEmpty
            ? SavedCardTileRow(
                parRepositorio: widget.parRepositorio,
                isCard: widget.isCard,
                index: i,
                tela: 'salvas',
                atualizar: () {
                  setState(() {});
                },
              )
            : const SizedBox();
      },
    );
  }

  void _trocarCardTile() {
    widget.alternarCardTile();
  }

  void _opcaoEscolhida(context, value) {
    switch (value) {
      case 0:
        _trocarCardTile();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.parRepositorio.salvas =
        ModalRoute.of(context)!.settings.arguments as List<Par>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sugestões Salvas"),
        actions: [
          PopupMenuButton(
            onSelected: (value) => _opcaoEscolhida(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text("Trocar para ${widget.nomeOpcaoCardTile}"),
              )
            ],
          ),
        ],
        leading: BackButton(
          onPressed: (() {
            Navigator.pop(
              context,
              widget.parRepositorio.salvas,
            );
          }),
        ),
      ),
      body: _salvasRow(),
    );
  }
}
