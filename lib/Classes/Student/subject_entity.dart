class SubjectEntity {
  final String name;
  final List<double> grades;

  const SubjectEntity({required this.name, required this.grades});

  factory SubjectEntity.fromJson(Map<String, dynamic> json) {
    return SubjectEntity(name: json['nome'], grades: json['grades']);
  }
}
