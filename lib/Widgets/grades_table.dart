import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../Classes/grades.dart';
import 'grades_dialog.dart';

class GradesTable extends StatelessWidget {
  final List<Grades> notas;
  final List<String> list;
  final String dropdownValue;

  const GradesTable({super.key, required this.notas, required this.list, required this.dropdownValue});

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
      rows: notas[list.indexOf(dropdownValue)].asMap().entries.map((e) {
        var list = DataRow(cells: [
          DataCell(Text(e.value.name), onTap: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(10),
                      child: SlideInUp(child: GradesDialog(title: e.value.name, notas: e.value.grades)),
                    ));
          })
        ]);
        if (e.value.grades.length < 9) {
          int tam = e.value.grades.length;
          for (var i = 0; i < 9 - tam; i++) {
            e.value.grades.add(-1);
          }
        }
        for (var element in e.value.grades) {
          if (element == -1) {
            list.cells.add(const DataCell(Text("-")));
          } else {
            list.cells.add(DataCell(Text(element.toString())));
          }
        }
        return list;
      }).toList(),
    );
  }
}
