import 'package:flutter/material.dart';

import '../Classes/grades.dart';
import 'grades_dialog.dart';

class GradesTable extends StatelessWidget {
  final List<Grades> notas;
  final List<String> list;
  final String dropdownValue;
  final Future<List<List<double>>> organizeGrades;

  const GradesTable({super.key, required this.notas, required this.list, required this.dropdownValue, required this.organizeGrades});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
            label: Text('Matérias',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        DataColumn(
            label: Text('A1',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        DataColumn(
            label: Text('A2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        DataColumn(
            label: Text('A3',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        DataColumn(
            label: Text('A4',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        DataColumn(
            label: Text('A5',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        DataColumn(
            label: Text('A6',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        DataColumn(
            label: Text('A7',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        DataColumn(
            label: Text('A8',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        DataColumn(
            label: Text('A9',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
      ],
      rows: [
        DataRow(cells: [
          DataCell(const Text('Arte'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'Arte', index: 0),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[0])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[0])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[0])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[0])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[0])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[0])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[0])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[0])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[0]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Biologia'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'Biologia', index: 1),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[1])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[1])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[1])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[1])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[1])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[1])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[1])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[1])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[1]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Educação Física'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(
                      organizeGrades: organizeGrades, title: 'Educação Física', index: 2),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[2])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[2])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[2])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[2])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[2])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[2])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[2])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[2])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[2]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Filosofia'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'Filosofia', index: 3),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[3])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[3])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[3])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[3])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[3])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[3])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[3])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[3])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[3]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Física'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'Física', index: 4),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[4])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[4])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[4])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[4])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[4])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[4])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[4])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[4])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[4]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Geografia'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'Geografia', index: 5),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[5])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[5])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[5])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[5])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[5])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[5])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[5])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[5])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[5]))
        ]),
        DataRow(cells: [
          DataCell(const Text('História'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'História', index: 6),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[6])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[6])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[6])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[6])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[6])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[6])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[6])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[6])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[6]))
        ]),
        DataRow(cells: [
          DataCell(const Text('LEM - Inglês'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child:
                  GradesDialog(organizeGrades: organizeGrades, title: 'LEM - Inglês', index: 7),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[7])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[7])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[7])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[7])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[7])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[7])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[7])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[7])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[7]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Língua Protuguesa'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(
                      organizeGrades: organizeGrades, title: 'Língua Portuguesa', index: 8),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[8])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[8])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[8])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[8])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[8])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[8])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[8])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[8])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[8]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Matemática'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'Matemática', index: 9),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[9])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[9])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[9])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[9])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[9])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[9])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[9])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[9])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[9]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Química'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'Química', index: 10),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[10])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[10])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[10])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[10])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[10])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[10])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[10])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[10])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[10]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Redação'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'Redação', index: 11),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[11])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[11])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[11])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[11])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[11])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[11])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[11])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[11])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[11]))
        ]),
        DataRow(cells: [
          DataCell(const Text('Sociologia'), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                  insetPadding: const EdgeInsets.all(10),
                  child: GradesDialog(organizeGrades: organizeGrades, title: 'Sociologia', index: 12),
                ));
          }),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a1.split(" ")[12])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a2.split(" ")[12])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a3.split(" ")[12])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a4.split(" ")[12])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a5.split(" ")[12])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a6.split(" ")[12])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a7.split(" ")[12])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a8.split(" ")[12])),
          DataCell(Text(notas[list.indexOf(dropdownValue)].a9.split(" ")[12]))
        ]),
      ],
    );
  }

}