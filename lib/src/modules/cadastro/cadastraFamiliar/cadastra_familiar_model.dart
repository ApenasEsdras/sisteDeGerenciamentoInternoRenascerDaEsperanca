class Familiares {
  String uid;
  String nome;
  int idade;
  String sexo;
  bool isConjuge;
  bool isFilho;

  Familiares({
    required this.uid,
    required this.nome,
    required this.idade,
    required this.sexo,
    this.isConjuge = false,
    this.isFilho = false,
  });
  static List<Map<String, dynamic>> dadosDosFamiliares = [];
}
