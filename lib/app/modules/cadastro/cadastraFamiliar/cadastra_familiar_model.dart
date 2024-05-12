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

 List<Familiares> familiaresList = [];
}
