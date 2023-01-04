class Grades {
  final int id;

  final String nome;

  final String a1;
  final String a2;
  final String a3;
  final String a4;
  final String a5;
  final String a6;
  final String a7;
  final String a8;
  final String a9;

  const Grades({
    required this.id,
    required this.nome,
    required this.a1,
    required this.a2,
    required this.a3,
    required this.a4,
    required this.a5,
    required this.a6,
    required this.a7,
    required this.a8,
    required this.a9,
  });

  factory Grades.fromJson(Map<String, dynamic> json) {
    return Grades(
        id: json['id'],
        nome: json['nome'],
        a1: json['a1'],
        a2: json['a2'],
        a3: json['a3'],
        a4: json['a4'],
        a5: json['a5'],
        a6: json['a6'],
        a7: json['a7'],
        a8: json['a8'],
        a9: json['a9']);
  }
}
