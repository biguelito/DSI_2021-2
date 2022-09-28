import 'package:flutter/material.dart';
import 'package:randomizador/modelos/par.dart';
import 'package:randomizador/modelos/par_dto.dart';
import 'package:randomizador/util/utils.dart';

class InserirEditarParForm extends StatelessWidget {
  const InserirEditarParForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parPalavrasFormDto =
        ModalRoute.of(context)!.settings.arguments as ParDto;
    final acao = parPalavrasFormDto.acao;
    bool isParValido = acao == "Editar" ? true : false;

    final primeiraPalavraController = isParValido
        ? TextEditingController(text: parPalavrasFormDto.par!.primeira)
        : TextEditingController(text: "");
    final segundaPalavraController = isParValido
        ? TextEditingController(text: parPalavrasFormDto.par!.segunda)
        : TextEditingController(text: "");

    retornarPar() {
      Par resultado = Par(
        primeiraPalavraController.text,
        segundaPalavraController.text,
      );
      Navigator.pop(context, resultado);
    }

    void validarPar() {
      if (primeiraPalavraController.text.isEmpty ||
          segundaPalavraController.text.isEmpty) {
        isParValido = false;
        return;
      }
      isParValido = true;
      return;
    }

    return Scaffold(
      appBar: AppBar(title: Text('$acao Par')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Primeira Palavra",
                labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(gapPadding: 5),
              ),
              controller: primeiraPalavraController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Segunda Palavra",
                labelStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(gapPadding: 5),
              ),
              controller: segundaPalavraController,
            ),
          ),
          ElevatedButton(
            onPressed: retornarPar,
            child: Text("$acao Par", style: Utils.fonteStyleParPalavra),
          )
        ],
      ),
    );
  }
}
