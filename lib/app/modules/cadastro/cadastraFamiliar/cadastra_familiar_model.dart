class Familiares {
  String nome;
  int idade;
  String sexo;
  bool isConjuge;
  bool isFilho;

  Familiares({
    required this.nome,
    required this.idade,
    required this.sexo,
    this.isConjuge = false,
    this.isFilho = false,
  });

  static List<Familiares> familiaresList = [];

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'idade': idade,
      'sexo': sexo,
      'isConjuge': isConjuge,
      'isFilho': isFilho,
    };
  }
}
