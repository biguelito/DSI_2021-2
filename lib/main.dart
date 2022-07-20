import 'package:flutter/material.dart';
import 'package:randomizador/repositorio/par_repositorio.dart';
import 'package:randomizador/telas/tela_inicial.dart';
import 'package:randomizador/telas/tela_salvas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ParRepositorio parRepositorio = ParRepositorio();

    return MaterialApp(
        title: 'RandomizerApp',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            foregroundColor: Colors.purple.shade800,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => TelaInicial(parRepositorio: parRepositorio),
          '/salvas': (context) => TelaSalvas(parRepositorio: parRepositorio)
        });
  }
}
