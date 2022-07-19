class Par {
  String primeira;
  String segunda;

  Par({required this.primeira, required this.segunda});

  String obter() {
    return "${primeira}_$segunda";
  }
}
