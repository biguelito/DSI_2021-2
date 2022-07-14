import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../util/utils.dart';

class CardTileRow extends StatefulWidget {
  const CardTileRow({
    Key? key,
    required List<WordPair> this.salvas,
    required bool this.isCard,
    required WordPair this.parTile,
    required WordPair this.parCard1,
    required WordPair this.parCard2,
    required String this.tipoTela,
  }) : super(key: key);

  final List<WordPair> salvas;
  final bool isCard;
  final WordPair parTile;
  final WordPair parCard1;
  final WordPair parCard2;
  final String tipoTela;

  @override
  State<CardTileRow> createState() => _CardTileRowState();
}

class _CardTileRowState extends State<CardTileRow> {
  @override
  Widget build(BuildContext context) {
    void alternarSalvar(WordPair par, bool isSalva) {
      setState(() {
        if (isSalva) {
          widget.salvas.remove(par);
        } else {
          widget.salvas.add(par);
        }
      });
    }

    Widget _botaoGostei(WordPair parAlternar) {
      final _isSalva = widget.salvas.contains(parAlternar);

      return GestureDetector(
        child: Icon(
          _isSalva ? Icons.favorite : Icons.favorite_border,
          color: _isSalva ? Colors.red : null,
          semanticLabel: _isSalva ? "Remover" : "Salvar",
        ),
        onTap: () => alternarSalvar(parAlternar, _isSalva),
      );
    }

    Widget _parTexto(WordPair parValor) {
      return Text(
        parValor.asSnakeCase,
        style: Utils.fonteStyleParPalavra,
      );
    }

    Widget _buildTile(WordPair par) {
      return ListTile(
        title: _parTexto(par),
        trailing: _botaoGostei(par),
      );
    }

    Widget _buildRowTile(WordPair par) {
      return _buildTile(par);
    }

    Widget _buildCard(WordPair par) {
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

    Widget _buildRowCard(WordPair par1, WordPair par2) {
      return Row(
        children: [_buildCard(par1), _buildCard(par2)],
      );
    }

    Widget RowBuilder() {
      return !widget.isCard
          ? _buildRowTile(widget.parTile)
          : _buildRowCard(widget.parCard1, widget.parCard2);
    }

    return RowBuilder();
  }
}
