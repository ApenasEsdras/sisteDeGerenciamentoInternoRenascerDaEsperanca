class Responsavel {
  String? nome;
  String? imageUrl;
  int? idade;
  String? endereco;
  String? fone;
  String? email;
  String? codigo;
  String? cpf;
  int? chave;
  String? classe;
  String? pais;
  String? uf;
  String? localidade;
  String? sublocalidade;
  String? logradouro;
  String? cep;
  String? numero;
  String? complemento;
  String? tipologradouro;
  List<Map<String, dynamic>>? dadosDosFamiliaresCadastradols;

  Responsavel({
    this.nome,
    this.imageUrl,
    this.fone,
    this.email,
    this.codigo,
    this.cpf,
    this.chave,
    this.classe,
    this.pais,
    this.uf,
    this.localidade,
    this.sublocalidade,
    this.logradouro,
    this.cep,
    this.numero,
    this.complemento,
    this.tipologradouro,
    this.idade,
    this.endereco,
    this.dadosDosFamiliaresCadastradols,
  });

  factory Responsavel.fromJson(Map<String, dynamic> json) {
    return Responsavel(
      nome: json['nome'],
      fone: json['fone'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      idade: json['idade'],
      cpf: json['cpf'],
      endereco: json['endereco'],
      dadosDosFamiliaresCadastradols: (json['familiares'] as List<dynamic>?)
          ?.map((item) => item as Map<String, dynamic>)
          .toList(),
    );
  }
}
