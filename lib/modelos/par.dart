import 'package:uuid/uuid.dart';

class Par {
  String primeira;
  String segunda;
  String id = const Uuid().v4();

  Par(this.primeira, this.segunda);

  factory Par.FromFirebase(Map<String, dynamic> json, String id) {
    var par = Par(json["Primeira"], json["Segunda"]);
    par.id = id;
    return par;
  }

  String obter() {
    return "${primeira}_$segunda";
  }
}
