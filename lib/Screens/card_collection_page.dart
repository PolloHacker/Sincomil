import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sincomil/Constants/constants.dart';
import 'package:sincomil/Constants/shared_constants.dart';

import '../Classes/grades.dart';
import '../Classes/student.dart';
import '../Provider/app_settings.dart';
import '../Widgets/portrait_card.dart';

class CardColection extends StatefulWidget {
  const CardColection(
      {super.key, required this.students, required this.fotos, required this.list, required this.notas});

  final List<Student> students;
  final List<String> fotos;
  final List<String> list;
  final List<Grades> notas;

  @override
  State<CardColection> createState() => _CardColectionState();
}

class _CardColectionState extends State<CardColection> {
  List<String> cards = [];
  List<bool> selected = [];
  List<bool> expanded = [];

  String dropdownValue = '';
  String direction = '';
  List<bool> first = [];

  double media(List<Grades> data) {
    double media = 0;
    double gradeCount = 0;
    Map<String, List<double>> subjects = {
      'artes': data[widget.list.indexOf(dropdownValue)].artes.grades,
      'bio': data[widget.list.indexOf(dropdownValue)].bio.grades,
      'ef': data[widget.list.indexOf(dropdownValue)].ef.grades,
      'filo': data[widget.list.indexOf(dropdownValue)].filo.grades,
      'fis': data[widget.list.indexOf(dropdownValue)].fis.grades,
      'geo': data[widget.list.indexOf(dropdownValue)].geo.grades,
      'hist': data[widget.list.indexOf(dropdownValue)].hist.grades,
      'lem': data[widget.list.indexOf(dropdownValue)].lem.grades,
      'port': data[widget.list.indexOf(dropdownValue)].port.grades,
      'mat': data[widget.list.indexOf(dropdownValue)].mat.grades,
      'quim': data[widget.list.indexOf(dropdownValue)].quim.grades,
      'red': data[widget.list.indexOf(dropdownValue)].red.grades,
      'socio': data[widget.list.indexOf(dropdownValue)].socio.grades
    };
    subjects.forEach((key, value) {
      media += value.reduce((grade, element) => grade + element);
      gradeCount += value.length;
    });
    media /= gradeCount;
    return media * 10;
  }

  void _updateCards(List<String> cards, String nome) {
    final settings = Provider.of<AppSettings>(context, listen: false);
    settings.updateCards(cards, nome);
  }

  void removeCard(String card) async {
    int index = cards.indexOf(card);
    if (index != -1) {
      setState(() {
        cards.removeAt(index);
      });
      _updateCards(cards, dropdownValue);
    }
  }

  //TODO: implement giveaway of the rest of the cards
  void giveaway() {
    var avg = media(widget.notas);

    //common cards
    if (avg < 60) {
      cards.addAll(['bronzecommon']);
    } else if (avg < 65) {
      cards.addAll(['bronzecommon', 'bronze']);
    } else if (avg < 70) {
      cards.addAll(['bronzecommon', 'bronze', 'silvercommon']);
    } else if (avg < 75) {
      cards.addAll(['bronzecommon', 'bronze', 'silvercommon', 'silver']);
    } else if (avg < 80) {
      cards.addAll(['bronzecommon', 'bronze', 'silvercommon', 'silver', 'goldcommon']);
    } else if (80 <= avg) {
      cards.addAll(['bronzecommon', 'bronze', 'silvercommon', 'silver', 'goldcommon', 'gold']);
    }

    //consecutive grades
    final studentGrades = widget.notas[widget.list.indexOf(dropdownValue)];

    List<List<String>> ifGrades = [
      studentGrades.artes.grades,
      studentGrades.bio.grades,
      studentGrades.ef.grades,
      studentGrades.filo.grades,
      studentGrades.fis.grades,
      studentGrades.geo.grades,
      studentGrades.hist.grades,
      studentGrades.lem.grades,
      studentGrades.port.grades,
      studentGrades.mat.grades,
      studentGrades.quim.grades,
      studentGrades.red.grades,
      studentGrades.socio.grades
    ]
        .expand((e) => e
        .asMap()
        .entries
        .where((i) =>
    (i.value >= 9 && i.key + 1 < e.length && e[i.key + 1] >= 9) ||
        (i.value >= 8 && i.key + 1 < e.length && e[i.key + 1] >= 8) ||
        (i.value >= 7 && i.key + 1 < e.length && e[i.key + 1] >= 7))
        .map((j) => j.value >= 9 && j.key + 1 < e.length && e[j.key + 1] >= 9
        ? ['bronzeif', 'silverif', 'goldif']
        : j.value >= 8 && j.key + 1 < e.length && e[j.key + 1] >= 8
        ? ['bronzeif', 'silverif']
        : j.value >= 7 && j.key + 1 < e.length && e[j.key + 1] >= 7
        ? ['bronzeif']
        : [''])
        .toList())
        .toList();
    cards.addAll(ifGrades.expand((e) => e).toList());


    List<List<double>> alamarGrades = [
      studentGrades.artes.grades,
      studentGrades.bio.grades,
      studentGrades.ef.grades,
      studentGrades.filo.grades,
      studentGrades.fis.grades,
      studentGrades.geo.grades,
      studentGrades.hist.grades,
      studentGrades.lem.grades,
      studentGrades.port.grades,
      studentGrades.mat.grades,
      studentGrades.quim.grades,
      studentGrades.red.grades,
      studentGrades.socio.grades
    ];

    for (var element in alamarGrades) {
      double md1 = element.sublist(0, 3).map((e) => e).reduce((a, b) => a + b) / 3;
      double md2 = element.sublist(3, 6).map((e) => e).reduce((a, b) => a + b) / 3;
      double md3 = element.sublist(6).map((e) => e).reduce((a, b) => a + b) / 3;
      if (md1 >= 8 || md2 >= 8 || md3 >= 8) {
        cards.add('flashback');
        break;
      }
    }

    _updateCards(cards, dropdownValue);
  }

  Future<bool> _getCards(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cards = sharedPreferences.getStringList(ownedCards + dropdownValue) ?? ['bronzecommon'];
    if (selected.length < cards.length) {
      selected = List.filled(allCards.length, false, growable: true);
    }
    if (expanded.length < cards.length) {
      expanded = List.filled(allCards.length, false, growable: true);
    }
    if (first.length < cards.length) {
      first = List.filled(allCards.length, true, growable: true);
    }
    var indx = sharedPreferences.getInt(selectedCard + dropdownValue) ?? -1;
    if (indx != -1) {
      selected[indx] = true;
      for (var i = 0; i < selected.length; i++) {
        if (indx != i) {
          selected[i] = false;
        }
      }
    }
    if (first[widget.list.indexOf(dropdownValue)]) {
      first[widget.list.indexOf(dropdownValue)] = false;

      giveaway();
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.students[0].nome;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCards(context),
      builder: (context, AsyncSnapshot<bool> data) {
        if (data.hasData) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.fotos[widget.list.indexOf(dropdownValue)]),
                    ),
                    onVerticalDragEnd: (details) {
                      if (direction == 'baixo') {
                        setState(() {
                          dropdownValue = widget.list[(widget.list.indexOf(dropdownValue) + 1) % widget.list.length];
                        });
                      } else if (direction == 'cima') {
                        setState(() {
                          dropdownValue = widget.list[(widget.list.indexOf(dropdownValue) - 1) % widget.list.length];
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
                                  title: Text("AL ${widget.students[e.key].nomeGuerra}"),
                                  onTap: () {
                                    setState(() {
                                      dropdownValue = widget.students[e.key].nome;
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
              title: const Text('Coleção de cartas'),
            ),
            body: Material(
              elevation: 0,
              borderOnForeground: false,
              child: ListView(
                children: [
                  const ListTile(
                    leading: Icon(Icons.warning_rounded),
                    title: Text('Selecione uma carta'),
                    subtitle: Text('A carta selecionada será exibida na aba de notas'),
                  ),
                  PortraitCard(dropdownValue: dropdownValue, cards: cards, selected: selected, expanded: expanded)
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.fotos[widget.list.indexOf(dropdownValue)]),
                    ),
                    onVerticalDragEnd: (details) {
                      if (direction == 'baixo') {
                        setState(() {
                          dropdownValue = widget.list[(widget.list.indexOf(dropdownValue) + 1) % widget.list.length];
                        });
                      } else if (direction == 'cima') {
                        setState(() {
                          dropdownValue = widget.list[(widget.list.indexOf(dropdownValue) - 1) % widget.list.length];
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
                                  title: Text("AL ${widget.students[e.key].nomeGuerra}"),
                                  onTap: () {
                                    setState(() {
                                      dropdownValue = widget.students[e.key].nome;
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
              title: const Text('Coleção de cartas'),
            ),
            body: Material(
                elevation: 0,
                borderOnForeground: false,
                child: Center(
                  child: Column(
                    children: const [Spacer(), CircularProgressIndicator(), Text('Carregando cartas'), Spacer()],
                  ),
                )),
          );
        }
      },
    );
  }
}
