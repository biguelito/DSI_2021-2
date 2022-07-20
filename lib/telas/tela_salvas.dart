import 'package:flutter/material.dart';
import '../repositorio/par_repositorio.dart';
import '../util/utils.dart';

class TelaSalvas extends StatefulWidget {
  const TelaSalvas({
    Key? key,
    required this.parRepositorio,
    required this.isCard,
  }) : super(key: key);

  final ParRepositorio parRepositorio;
  final bool isCard;

  @override
  State<TelaSalvas> createState() => _TelaSalvasState();
}

class _TelaSalvasState extends State<TelaSalvas> {
  Widget _salvasTile() {
    Iterable<ListTile> tiles = widget.parRepositorio.salvas.map(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sugestões Salvas"),
      ),
      body: _salvasTile(),
    );
  }
}
