class ClassEntity {
  final String className;
  final List<String> participants;
  final List<List<double>> participantsGrades;

  ClassEntity(
      {required this.className,
      required this.participants,
      required this.participantsGrades});
}
