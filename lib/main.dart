import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:randomizador/repositorio/par_repositorio.dart';
import 'package:randomizador/telas/tela_inicial.dart';
import 'package:randomizador/telas/tela_salvas.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ParRepositorio parRepositorio = ParRepositorio();
    bool isCard = false;

    void alternarCardTile() {
      setState(() {
        isCard = !isCard;
      });
    }

    void atualizar() {
      setState(() {
        isCard = !isCard;
      });
    }

    return MaterialApp(
        title: 'RandomizerApp',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            foregroundColor: Colors.purple.shade800,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => TelaInicial(
                parRepositorio: parRepositorio,
                isCard: isCard,
                alternarCardTile: () => alternarCardTile(),
                atualizar: () => atualizar(),
              ),
          '/salvas': (context) => TelaSalvas(
                parRepositorio: parRepositorio,
                isCard: isCard,
                atualizar: () => atualizar(),
              )
        });
  }
}
