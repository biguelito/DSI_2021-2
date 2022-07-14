import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import '../util/utils.dart';

Widget cardTileRow(
    List<WordPair> sugestoes,
    List<WordPair> salvas,
    bool isCard,
    int index,
    int i,
    Function(WordPair parPalavara, bool isSalva) alternarSalvar) {
  WordPair parTile = sugestoes[index];
  WordPair parCard1 = sugestoes[i];
  WordPair parCard2 = sugestoes[i + 1];

  Widget _botaoGostei(WordPair parAlternar) {
    final _isSalva = sugestoes.contains(parAlternar);

    return GestureDetector(
      child: Icon(
        _isSalva ? Icons.favorite : Icons.favorite_border,
        color: _isSalva ? Colors.red : null,
        semanticLabel: _isSalva ? "Remover" : "Salvar",
      ),
      onTap: alternarSalvar(parAlternar, _isSalva),
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

  return isCard ? _buildRowTile(parTile) : _buildRowCard(parCard1, parCard2);
}
