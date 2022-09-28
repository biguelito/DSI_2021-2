import 'package:flutter/material.dart';
import 'package:randomizador/modelos/par_dto.dart';
import 'package:randomizador/repositorio/par_firestore.dart';
import '../util/utils.dart';
import 'package:randomizador/modelos/par.dart';
import 'package:randomizador/repositorio/par_repositorio.dart';

class CardTileRow extends StatefulWidget {
  const CardTileRow({
    Key? key,
    required this.parRepositorio,
    required this.isCard,
    required this.index,
    required this.tela,
    required this.atualizar,
  }) : super(key: key);

  final ParRepositorio parRepositorio;
  final bool isCard;
  final int index;
  final String tela;
  final Function atualizar;

  @override
  State<CardTileRow> createState() => _CardTileRowState();
}

class _CardTileRowState extends State<CardTileRow> {
  ParFirestore _parFirestore = ParFirestore();

  @override
  Widget build(BuildContext context) {
    Future<void> _editarPar(Par parEditar, int index) async {
      String acao = "Editar";

      final resultado = await Navigator.pushNamed(
        context,
        '/inserireditarparform',
        arguments: ParDto(parEditar, acao),
      );
      if (resultado != null) {
        setState(() {
          Par parRetorno = resultado as Par;
          widget.parRepositorio.atualizarPar(parRetorno, index);
          widget.atualizar();
        });
      }
    }

    Widget _botaoGostei(Par parAlternar) {
      final isSalvaIcone = widget.parRepositorio.salvas.contains(parAlternar);

      void alternarSalvar(Par parAlternar) {
        widget.parRepositorio.alternarSalvarPar(parAlternar);
        _parFirestore.alternarPar(parAlternar);
        widget.atualizar();
      }

      return GestureDetector(
        child: Icon(
          isSalvaIcone ? Icons.favorite : Icons.favorite_border,
          color: isSalvaIcone ? Colors.red : null,
          semanticLabel: isSalvaIcone ? "Remover" : "Salvar",
        ),
        onTap: () => alternarSalvar(parAlternar),
      );
    }

    void remover(Par par) {
      widget.parRepositorio.removerSalva(par);
      widget.parRepositorio.removerPar(par);
      widget.atualizar();
    }

    Widget _botaoRemover(Par parApagar) {
      return GestureDetector(
        child: const Icon(
          Icons.delete,
          color: Colors.red,
          semanticLabel: "Remover",
        ),
        onTap: () => remover(parApagar),
      );
    }

    Widget _parTexto(Par parValor) {
      return Text(
        parValor.obter(),
        style: Utils.fonteStyleParPalavra,
      );
    }

    Widget _buildTile(Par par) {
      return widget.tela == 'inicial'
          ? Dismissible(
              key: Key(par.obter()),
              child: Column(
                children: [
                  ListTile(
                    title: _parTexto(par),
                    trailing: _botaoGostei(par),
                    onLongPress: () => _editarPar(par, widget.index),
                  ),
                  const Divider()
                ],
              ),
              onDismissed: ((direction) {
                remover(par);
              }),
              background: Container(
                color: Colors.red,
              ),
            )
          : ListTile(
              title: _parTexto(par),
              trailing: _botaoGostei(par),
            );
    }

    Widget _buildRowTile(Par par) {
      return _buildTile(par);
    }

    Widget _buildCard(Par par, int index) {
      return Expanded(
        child: Card(
          margin: const EdgeInsets.all(6.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                _parTexto(par),
                const Divider(
                  height: 10,
                  thickness: 1,
                ),
                Row(
                  children: [
                    widget.tela == 'inicial'
                        ? Expanded(
                            child: _botaoRemover(par),
                          )
                        : const SizedBox(),
                    widget.tela == 'inicial'
                        ? Expanded(
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blueGrey,
                              ),
                              onPressed: () => _editarPar(par, index),
                            ),
                          )
                        : const SizedBox(),
                    Expanded(child: _botaoGostei(par)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildRowCard(Par par1, Par? par2) {
      return Row(
        children: [
          _buildCard(par1, widget.index),
          par2 != null
              ? _buildCard(par2, widget.index + 1)
              : const Expanded(child: SizedBox())
        ],
      );
    }

    Widget rowBuilderInicial() {
      Par parTile = widget.parRepositorio.obterSugestaoPorIndex(widget.index);
      Par parCard1 = widget.parRepositorio.obterSugestaoPorIndex(widget.index);
      Par parCard2 =
          widget.parRepositorio.obterSugestaoPorIndex(widget.index + 1);

      if (!widget.isCard) {
        return _buildRowTile(parTile);
      } else if (widget.index.isEven) {
        return _buildRowCard(parCard1, parCard2);
      } else {
        return const SizedBox();
      }
    }

    Widget rowBuilderSalvas() {
      Par parTile = widget.parRepositorio.obterSalvasPorIndex(widget.index);
      Par parCard1 = widget.parRepositorio.obterSalvasPorIndex(widget.index);
      Par? parCard2 = widget.parRepositorio.temSegundoCardSalvas(widget.index)
          ? widget.parRepositorio.obterSalvasPorIndex(widget.index + 1)
          : null;

      if (!widget.isCard) {
        return _buildRowTile(parTile);
      } else if (widget.index.isEven) {
        return _buildRowCard(parCard1, parCard2 ?? null);
      } else {
        return const SizedBox();
      }
    }

    Widget cardTileRow() {
      if (widget.tela == 'salvas') {
        return rowBuilderSalvas();
      }
      return rowBuilderInicial();
    }

    return cardTileRow();
  }
}
