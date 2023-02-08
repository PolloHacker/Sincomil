class Parent {
  final int id;

  final String cpf;
  final String nome;
  final String email;
  final String password;

  const Parent({
    required this.id,
    required this.cpf,
    required this.nome,
    required this.email,
    required this.password
  });

  factory Parent.fromJson (Map<String, dynamic> json) {
    return Parent(
      id: json['id'],
      cpf: json['cpf'],
      nome: json['nome'],
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, String> asMap() {
    return {
      'nome': nome,
      'cpf': cpf,
      'email': email
    };
  }
}
