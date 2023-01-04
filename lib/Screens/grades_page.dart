import 'package:flutter/material.dart';
import 'package:sincomil/Widgets/grades_radar.dart';
import 'package:sincomil/Widgets/grades_table.dart';

import '../Classes/grades.dart';

class GradesPage extends StatelessWidget {
  final List<Grades> notas;
  final List<String> list;
  final String dropdownValue;
  const GradesPage(
      {super.key,
      required this.notas,
      required this.dropdownValue,
      required this.list});

  Future<List<List<double>>> organizeGrades() {
    List<double> artes = [];
    List<double> bio = [];
    List<double> ef = [];
    List<double> filo = [];
    List<double> fis = [];
    List<double> geo = [];
    List<double> hist = [];
    List<double> lem = [];
    List<double> port = [];
    List<double> mat = [];
    List<double> quim = [];
    List<double> red = [];
    List<double> socio = [];

    final grades = [
      notas[list.indexOf(dropdownValue)].a1.split(" "),
      notas[list.indexOf(dropdownValue)].a2.split(" "),
      notas[list.indexOf(dropdownValue)].a3.split(" "),
      notas[list.indexOf(dropdownValue)].a4.split(" "),
      notas[list.indexOf(dropdownValue)].a5.split(" "),
      notas[list.indexOf(dropdownValue)].a6.split(" "),
      notas[list.indexOf(dropdownValue)].a7.split(" "),
      notas[list.indexOf(dropdownValue)].a8.split(" "),
      notas[list.indexOf(dropdownValue)].a9.split(" ")
    ];

    for (var i = 0; i < grades.length; i++) {
      artes.add(double.parse(grades[i][0]));
      bio.add(double.parse(grades[i][1]));
      ef.add(double.parse(grades[i][2]));
      filo.add(double.parse(grades[i][3]));
      fis.add(double.parse(grades[i][4]));
      geo.add(double.parse(grades[i][5]));
      hist.add(double.parse(grades[i][6]));
      lem.add(double.parse(grades[i][7]));
      port.add(double.parse(grades[i][8]));
      mat.add(double.parse(grades[i][9]));
      quim.add(double.parse(grades[i][10]));
      red.add(double.parse(grades[i][11]));
      socio.add(double.parse(grades[i][12]));
    }

    return Future.delayed(const Duration(seconds: 1), () {
      return [artes, bio, ef, filo, fis, geo, hist, lem, port, mat, quim, red, socio];
    });
  }

  Future<List<List<List<double>>>> orgAllGrades() {
    List<double> artes = [];
    List<double> bio = [];
    List<double> ef = [];
    List<double> filo = [];
    List<double> fis = [];
    List<double> geo = [];
    List<double> hist = [];
    List<double> lem = [];
    List<double> port = [];
    List<double> mat = [];
    List<double> quim = [];
    List<double> red = [];
    List<double> socio = [];

    var alunos = List<List<List<double>>>.empty(growable: true);

    for (var i = 0; i < list.length ; i++) {
      artes.clear();
      bio.clear();
      ef.clear();
      filo.clear();
      fis.clear();
      geo.clear();
      hist.clear();
      lem.clear();
      port.clear();
      mat.clear();
      quim.clear();
      red.clear();
      socio.clear();
      alunos.add(List.empty(growable: true));
      var grades = [
        notas[i].a1.split(" "),
        notas[i].a2.split(" "),
        notas[i].a3.split(" "),
        notas[i].a4.split(" "),
        notas[i].a5.split(" "),
        notas[i].a6.split(" "),
        notas[i].a7.split(" "),
        notas[i].a8.split(" "),
        notas[i].a9.split(" ")
      ];

      for (var j = 0; j < grades.length; j++) {
        artes.add(double.parse(grades[j][0]));
        bio.add(double.parse(grades[j][1]));
        ef.add(double.parse(grades[j][2]));
        filo.add(double.parse(grades[j][3]));
        fis.add(double.parse(grades[j][4]));
        geo.add(double.parse(grades[j][5]));
        hist.add(double.parse(grades[j][6]));
        lem.add(double.parse(grades[j][7]));
        port.add(double.parse(grades[j][8]));
        mat.add(double.parse(grades[j][9]));
        quim.add(double.parse(grades[j][10]));
        red.add(double.parse(grades[j][11]));
        socio.add(double.parse(grades[j][12]));
      }
      alunos[i].add(List.from(artes));
      alunos[i].add(List.from(bio));
      alunos[i].add(List.from(ef));
      alunos[i].add(List.from(filo));
      alunos[i].add(List.from(fis));
      alunos[i].add(List.from(geo));
      alunos[i].add(List.from(hist));
      alunos[i].add(List.from(lem));
      alunos[i].add(List.from(port));
      alunos[i].add(List.from(mat));
      alunos[i].add(List.from(quim));
      alunos[i].add(List.from(red));
      alunos[i].add(List.from(socio));
    }
    return Future.delayed(const Duration(seconds: 1), () {
      return alunos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderOnForeground: false,
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            alignment: Alignment.center,
            child: Card(
              elevation: 10.0,
              shadowColor: const Color.fromRGBO(255, 255, 255, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GradesTable(
                    notas: notas, list: list, dropdownValue: dropdownValue, organizeGrades: organizeGrades()),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            alignment: Alignment.center,
            child: RadarGraph(orgAllGrades: orgAllGrades(), list: list),
          )
        ],
      ),
    );
  }
}
