import 'package:randomizador/modelos/par.dart';
import 'package:english_words/english_words.dart';

class ParRepositorio {
  List<Par> sugestoes = <Par>[];
  List<Par> salvas = <Par>[];

  ParRepositorio() {
    generateWordPairs().take(20).forEach((par) {
      inserirNovoWordPair(par);
    });
  }

  void inserirNovoPar(Par novoPar) {
    sugestoes.insert(0, novoPar);
  }

  void inserirNovoWordPair(WordPair novoWordpair) {
    Par novoPar = Par(novoWordpair.first, novoWordpair.second);
    sugestoes.add(novoPar);
  }

  void inserirSalvar(Par par) {
    salvas.add(par);
  }

  void atualizarPar(Par novopar, int index) {
    Par antigopar = sugestoes[index];
    sugestoes[index] = novopar;
    if (salvas.contains(antigopar)) {
      int salvaAntigoIndex = salvas.indexOf(antigopar);
      salvas[salvaAntigoIndex] = novopar;
    }
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

  bool alternarSalvarPar(Par par) {
    if (salvas.contains(par)) {
      salvas.remove(par);
      return false;
    } else {
      salvas.add(par);
      return true;
    }
  }

  Par obterSugestaoPorIndex(int index) {
    return sugestoes[index];
  }

  Par obterSalvasPorIndex(int index) {
    return salvas[index];
  }

  bool temSegundoCardSalvas(int index) {
    return salvas.length > index + 1;
  }
}
