import 'package:flutter/material.dart';
import 'package:sincomil/Widgets/nav_drawer.dart';
import 'package:sincomil/Screens/payments_page.dart';
import 'package:sincomil/Screens/grades_page.dart';

import '../Classes/grades.dart';
import '../Classes/parent.dart';
import '../Classes/student.dart';
import 'home_page.dart';

class StartPage extends StatefulWidget {
  final Parent parent;
  final List<Student> data;
  final List<String> fotos;
  final List<String> list;
  final List<Grades> grades;
  final String value;
  const StartPage(
      {super.key,
      required this.parent,
      required this.data,
      required this.fotos,
      required this.list,
      required this.grades,
      required this.value});

  @override
  State<StartPage> createState() =>
      _StartPageState(parent, data, fotos, list, grades, value);
}

class _StartPageState extends State<StartPage> {
  int _page = 0;
  _StartPageState(
      this.parent, this.data, this.fotos, this.list, this.grades, this.value);
  final Parent parent;
  final List<Student> data;
  final List<String> fotos;
  final List<String> list;
  String direction = '';
  List<Grades> grades;
  String value;
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(fotos[list.indexOf(value)]),
                ),
                onVerticalDragEnd: (details) {
                  if (direction == 'baixo') {
                    setState(() {
                      value = list[(list.indexOf(value) + 1) % list.length];
                    });
                  } else if (direction == 'cima') {
                    setState(() {
                      value = list[(list.indexOf(value) - 1) % list.length];
                    });
                  }
                },
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy > 0) {
                    direction = 'baixo';
                  } else if (details.delta.dy < 0) {
                    direction = 'cima';
                  }
                },
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                      content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: list
                        .asMap()
                        .entries
                        .map((e) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(fotos[e.key]),
                              ),
                              title: Text("AL ${data[e.key].nomeGuerra}"),
                              onTap: () {
                                setState(() {
                                  value = data[e.key].nome;
                                });
                                Navigator.of(context).pop('Chosen');
                              },
                            ))
                        .toList(),
                  )),
                ),
              ),
            )
          ],
          title: titles.elementAt(_page),
        ),
        body: <Widget>[
          HomePage(
              data: data,
              fotos: fotos,
              list: list,
              dropdownValue: data[list.indexOf(value)].nome),
          PaymentsPage(data: data),
          GradesPage(notas: grades, dropdownValue: data[list.indexOf(value)].nome, list: list)
        ].elementAt(_page),
        drawer: NavDrawer(parent: parent, data: data, fotos: fotos),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Início'),
            BottomNavigationBarItem(
                icon: Icon(Icons.payments_outlined),
                activeIcon: Icon(Icons.payments_rounded),
                label: 'Pagamentos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined),
                activeIcon: Icon(Icons.bar_chart_rounded),
                label: 'Boletim')
          ],
          onTap: (index) => {
            setState(() {
              _page = index;
            })
          },
          currentIndex: _page,
        ));
  }
}

const List<Widget> titles = <Widget>[
  Text('Visualização de aluno'),
  Text('Pagamentos'),
  Text('Boletim Escolar')
];
