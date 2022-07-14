import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

Widget _buildRow(WordPair par, bool isCard, salvas) {
  final isSalva = salvas.contains(par);

  // TODO: Recriar usando repositorio para palavras

  void alternarSalvar() {
    setState(() {
      if (isSalva) {
        salvas.remove(par);
      } else {
        salvas.add(par);
      }
    });
  }

  Widget _botaoGostei() {
    return GestureDetector(
      child: Icon(
        isSalva ? Icons.favorite : Icons.favorite_border,
        color: isSalva ? Colors.red : null,
        semanticLabel: isSalva ? "Remover" : "Salvar",
      ),
      onTap: alternarSalvar,
    );
  }

  Widget _parTexto() {
    return Text(
      par.asSnakeCase,
      style: _fonteStyleMaior, // TODO: Criar e obter por classe utils
    );
  }

  Widget _buildTile(WordPair par) {
    return ListTile(
      title: _parTexto(),
      trailing: _botaoGostei(),
    );
  }

  Widget _buildCard(WordPair par) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              _parTexto(),
              const SizedBox(height: 10),
              _botaoGostei(),
            ],
          ),
        ),
      ),
    );
  }

  return isCard ? _buildCard(par) : _buildTile(par);
}
