import 'package:randomizador/modelos/par.dart';
import 'package:english_words/english_words.dart';

class ParRepositorio {
  final List<Par> sugestoes = <Par>[];
  final List<Par> salvas = <Par>[];

  ParRepositorio();

  void inserirNovoPar(WordPair novoWordpair) {
    Par novoPar =
        Par(primeira: novoWordpair.first, segunda: novoWordpair.second);
    sugestoes.add(novoPar);
  }

  void inserirSalvar(Par par) {
    salvas.add(par);
  }

  void removerPar(Par par) {
    if (sugestoes.contains(par)) {
      sugestoes.remove(par);
    }
  }

  void removerSalva(Par par) {
    if (salvas.contains(par)) {
      salvas.remove(par);
    }
  }

  void alternarSalvarPar(Par par) {
    if (salvas.contains(par)) {
      salvas.remove(par);
    } else {
      salvas.add(par);
    }
  }

  Par obterSugestaoPorIndex(int index) {
    return sugestoes[index];
  }
}
