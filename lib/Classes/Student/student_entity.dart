class StudentEntity {
  //id do aluno na base de dados
  final int id;

  // codigo único do aluno
  final String codigo;

  final String foto;

  //informações padrão do aluno
  final String nome;
  final String nomeGuerra;
  final int numero;

  //informações pessoais do aluno
  final String email;
  final String cpf;
  final String telefone;
  final String nascimento;

  //informações adicionais do aluno
  final String nacionalidade;
  final String uf;
  final String naturalidade;
  final String identidade;

  final String cor;
  final String sexo;
  final bool orphan;
  final bool especial;

  const StudentEntity(
      {required this.id,
      required this.codigo,
      required this.foto,
      required this.nome,
      required this.nomeGuerra,
      required this.numero,
      required this.email,
      required this.cpf,
      required this.telefone,
      required this.nascimento,
      required this.nacionalidade,
      required this.uf,
      required this.naturalidade,
      required this.identidade,
      required this.cor,
      required this.sexo,
      required this.orphan,
      required this.especial});

  factory StudentEntity.fromJson(Map<String, dynamic> json) {
    return StudentEntity(
        id: json['id'],
        codigo: json['codigo'],
        foto: json['foto'],
        nome: json['nome'],
        nomeGuerra: json['nomeGuerra'],
        numero: json['numero'],
        email: json['email'],
        cpf: json['cpf'],
        telefone: json['telefone'],
        nascimento: json['nascimento'],
        nacionalidade: json['nacionalidade'],
        uf: json['uf'],
        naturalidade: json['naturalidade'],
        identidade: json['identidade'],
        cor: json['cor'],
        sexo: json['sexo'],
        orphan: json['orphan'],
        especial: json['especial']);
  }

  Map<String, String> asMap() {
    return {
      'nome': nome,
      'nomeGuerra': nomeGuerra,
      'email': email,
      'cpf': cpf,
      'telefone': telefone,
      'nacionalidade': nacionalidade,
      'uf': uf,
      'naturalidade': naturalidade,
      'identidade': identidade,
      'cor': cor,
    };
  }
}
