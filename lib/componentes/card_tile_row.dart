import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../util/utils.dart';
import 'package:randomizador/modelos/par.dart';
import 'package:randomizador/repositorio/par_repositorio.dart';

class CardTileRow extends StatefulWidget {
  const CardTileRow({
    Key? key,
    required ParRepositorio this.parRepositorio,
    required bool this.isCard,
    required int this.index,
    required int this.i,
    required String this.tipoTela,
  }) : super(key: key);
  final ParRepositorio parRepositorio;
  final bool isCard;
  final int index;
  final int i;
  final String tipoTela;

  @override
  State<CardTileRow> createState() => _CardTileRowState();
}

class _CardTileRowState extends State<CardTileRow> {
  @override
  Widget build(BuildContext context) {
    Widget _botaoGostei(Par parAlternar) {
      final isSalva = widget.parRepositorio.salvas.contains(parAlternar);

      void alternarSalvar(Par parAlternar) {
        widget.parRepositorio.alternarSalvarPar(parAlternar);
        setState(() {});
      }

      return GestureDetector(
        child: Icon(
          isSalva ? Icons.favorite : Icons.favorite_border,
          color: isSalva ? Colors.red : null,
          semanticLabel: isSalva ? "Remover" : "Salvar",
        ),
        onTap: () => alternarSalvar(parAlternar),
      );
    }

    void remover(Par par, bool isSalva) {
      widget.parRepositorio.removerSalvar(par);
      widget.parRepositorio.removerPar(par);
      setState(() {});
    }

    Widget _botaoRemover(Par parApagar) {
      final isSalva = widget.parRepositorio.salvas.contains(parApagar);

      return GestureDetector(
        child: const Icon(
          Icons.delete,
          color: Colors.red,
          semanticLabel: "Remover",
        ),
        onTap: () => remover(parApagar, isSalva),
      );
    }

    Widget _parTexto(Par parValor) {
      return Text(
        parValor.obter(),
        style: Utils.fonteStyleParPalavra,
      );
    }

    Widget _buildTile(Par par) {
      return ListTile(
        title: _parTexto(par),
        trailing: _botaoGostei(par),
        leading: _botaoRemover(par),
      );
    }

    Widget _buildRowTile(Par par) {
      return _buildTile(par);
    }

    Widget _buildCard(Par par) {
      return Expanded(
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                _parTexto(par),
                const SizedBox(height: 10),
                _botaoGostei(par),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildRowCard(Par par1, Par par2) {
      return Row(
        children: [_buildCard(par1), _buildCard(par2)],
      );
    }

    Widget RowBuilder() {
      Par parTile = widget.parRepositorio.obterSugestaoPorIndex(widget.index);
      Par parCard1 = widget.parRepositorio.obterSugestaoPorIndex(widget.i);
      Par parCard2 = widget.parRepositorio.obterSugestaoPorIndex(widget.i + 1);

      return !widget.isCard
          ? _buildRowTile(parTile)
          : _buildRowCard(parCard1, parCard2);
    }

    return RowBuilder();
  }
}
