import 'class_entity.dart';

class TeacherEntity {
  final String name;
  final List<String> years;
  final List<ClassEntity> classes;

  TeacherEntity(
      {required this.name, required this.years, required this.classes});
}
