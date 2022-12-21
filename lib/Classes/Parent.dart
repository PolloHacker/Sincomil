class Parent {
  final int id;

  final int cpf;
  final String nome;

  const Parent({
    required this.id,
    required this.cpf,
    required this.nome
  });

  factory Parent.fromJson (Map<String, dynamic> json) {
    return Parent(
      id: json['id'],
      cpf: json['cpf'],
      nome: json['nome']
    );
  }
}
