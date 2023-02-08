import 'package:sincomil/Classes/Student/subject_entity.dart';

class GradesEntity {
  final int id;

  final String nome;

  final SubjectEntity artes;
  final SubjectEntity bio;
  final SubjectEntity ef;
  final SubjectEntity filo;
  final SubjectEntity fis;
  final SubjectEntity geo;
  final SubjectEntity hist;
  final SubjectEntity lem;
  final SubjectEntity port;
  final SubjectEntity mat;
  final SubjectEntity quim;
  final SubjectEntity red;
  final SubjectEntity socio;

  const GradesEntity(
      {required this.id,
      required this.nome,
      required this.artes,
      required this.bio,
      required this.ef,
      required this.filo,
      required this.fis,
      required this.geo,
      required this.hist,
      required this.lem,
      required this.port,
      required this.mat,
      required this.quim,
      required this.red,
      required this.socio});

  factory GradesEntity.fromJson(Map<String, dynamic> json) {
    return GradesEntity(
        id: json['id'],
        nome: json['nome'],
        artes: json['artes'],
        bio: json['bio'],
        ef: json['ef'],
        filo: json['filo'],
        fis: json['fis'],
        geo: json['geo'],
        hist: json['hist'],
        lem: json['lem'],
        port: json['port'],
        mat: json['mat'],
        quim: json['quim'],
        red: json['red'],
        socio: json['socio']);
  }

  Map<int, SubjectEntity> asMap() {
    return {
      0: artes,
      1: bio,
      2: ef,
      3: filo,
      4: fis,
      5: geo,
      6: hist,
      7: lem,
      8: port,
      9: mat,
      10: quim,
      11: red,
      12: socio
    };
  }
}
