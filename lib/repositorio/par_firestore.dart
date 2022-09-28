import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:randomizador/modelos/par.dart';

class ParFirestore {
  bool _configured = false;
  late CollectionReference _db;

  static final ParFirestore _firestoreProfileRepository =
      ParFirestore._internal();

  factory ParFirestore() {
    _firestoreProfileRepository.configure();
    return _firestoreProfileRepository;
  }

  ParFirestore._internal();

  void configure() {
    if (!_configured) {
      _configured = true;
      _db = FirebaseFirestore.instance.collection("ParPalavras");
    }
  }

  Future<List<Par>> obterPares() async {
    var paresQuerys = await _db.get();
    List<Par> pares = paresQuerys.docs
        .map((par) =>
            Par.FromFirebase(par.data() as Map<String, dynamic>, par.id))
        .toList();
    return pares;
  }

  Future<Par?> obterParPorId(String parId) async {
    var par = await _db.doc(parId).get();
    if (par.exists) {
      return Par.FromFirebase(par.data() as Map<String, dynamic>, par.id);
    }
    return null;
  }

  Future<String> alternarPar(Par par) async {
    var parExistente = await obterParPorId(par.id);
    if (parExistente == null) {
      inserirPar(par);
    } else {
      deletarPar(par.id);
    }
    return "";
  }

  Future<String> inserirPar(Par par) async {
    var jsonPar = {
      "Primeira": par.primeira,
      "Segunda": par.segunda,
    };
    return _db
        .doc(par.id)
        .set(jsonPar)
        .then((value) => "", onError: (error) => error.toString());
  }

  Future<String> atualizarPar(Par par) async {
    var jsonPar = {
      "Primeira": par.primeira,
      "Segunda": par.segunda,
    };
    return _db
        .doc(par.id)
        .set(jsonPar)
        .then((value) => "", onError: (error) => error.toString());
  }

  Future<String> deletarPar(String parId) async {
    return _db
        .doc(parId)
        .delete()
        .then((value) => "", onError: (error) => error.toString());
  }
}
