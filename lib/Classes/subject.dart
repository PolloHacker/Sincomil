class Subject {
  final String name;
  final List<double> grades;

  const Subject({required this.name, required this.grades});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(name: json['nome'], grades: json['grades']);
  }
}
