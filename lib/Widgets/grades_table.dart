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
                      insetPadding: const EdgeInsets.all(10),
                      child: GradesDialog(title: e.value.name, notas: e.value.grades),
                    ));
          })
        ]);
        for (var element in e.value.grades) {
          list.cells.add(DataCell(Text(element.toString())));
        }
        return list;
      }).toList(),
    );
  }
}
