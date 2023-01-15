import 'package:flutter/material.dart';
import 'package:sincomil/Widgets/nav_drawer.dart';
import 'package:sincomil/Screens/payments_page.dart';
import 'package:sincomil/Screens/grades_page.dart';

import '../Classes/grades.dart';
import '../Classes/parent.dart';
import '../Classes/payments.dart';
import '../Classes/student.dart';
import 'home_page.dart';

//ignore: must_be_immutable
class StartPage extends StatefulWidget {
  final Parent parent;
  final List<Student> data;
  final List<String> fotos;
  final List<String> fotosBG;
  final List<String> list;
  final List<Grades> grades;
  final List<Payments> payments;
  String value;
  StartPage(
      {super.key,
      required this.parent,
      required this.data,
      required this.fotos,
      required this.list,
      required this.grades,
      required this.value,
      required this.fotosBG,
      required this.payments});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  int _page = 0;
  String direction = '';
  bool expanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.fotos[widget.list.indexOf(widget.value)]),
                ),
                onVerticalDragEnd: (details) {
                  if (direction == 'baixo') {
                    setState(() {
                      widget.value = widget.list[(widget.list.indexOf(widget.value) + 1) % widget.list.length];
                    });
                  } else if (direction == 'cima') {
                    setState(() {
                      widget.value = widget.list[(widget.list.indexOf(widget.value) - 1) % widget.list.length];
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
                    children: widget.list
                        .asMap()
                        .entries
                        .map((e) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(widget.fotos[e.key]),
                              ),
                              title: Text("AL ${widget.data[e.key].nomeGuerra}"),
                              onTap: () {
                                setState(() {
                                  widget.value = widget.data[e.key].nome;
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
              data: widget.data,
              fotos: widget.fotos,
              list: widget.list,
              dropdownValue: widget.data[widget.list.indexOf(widget.value)].nome),
          PaymentsPage(
              data: widget.data,
              payments: widget.payments,
              dropdownValue: widget.data[widget.list.indexOf(widget.value)].nome,
              list: widget.list),
          GradesPage(
              notas: widget.grades,
              dropdownValue: widget.data[widget.list.indexOf(widget.value)].nome,
              list: widget.list,
              fotos: widget.fotos,
              fotosBG: widget.fotosBG,
              nomes: widget.data.map((e) => e.nomeGuerra).toList())
        ].elementAt(_page),
        drawer: NavDrawer(
            parent: widget.parent, data: widget.data, fotos: widget.fotos, list: widget.list, notas: widget.grades),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'Início'),
            BottomNavigationBarItem(
                icon: Icon(Icons.payments_outlined), activeIcon: Icon(Icons.payments_rounded), label: 'Pagamentos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined), activeIcon: Icon(Icons.bar_chart_rounded), label: 'Boletim')
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

const List<Widget> titles = <Widget>[Text('Visualização de aluno'), Text('Pagamentos'), Text('Boletim Escolar')];
