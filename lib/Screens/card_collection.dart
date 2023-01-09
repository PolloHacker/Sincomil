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

  late ScrollController _controller;

  String dropdownValue = '';
  String direction = '';

  int media(List<List<double>> data) {
    double media = 0;
    for (var element in data) {
      for (var nota in element) {
        media += nota;
      }
    }
    media /= 11.7;

    return media.round();
  }

  void _updateCards(List<String> cards, String nome) {
    final settings = Provider.of<AppSettings>(context, listen: false);
    settings.updateCards(cards, nome);
  }

  List<List<double>> organizeGrades() {
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
      widget.notas[widget.list.indexOf(dropdownValue)].a1.split(" "),
      widget.notas[widget.list.indexOf(dropdownValue)].a2.split(" "),
      widget.notas[widget.list.indexOf(dropdownValue)].a3.split(" "),
      widget.notas[widget.list.indexOf(dropdownValue)].a4.split(" "),
      widget.notas[widget.list.indexOf(dropdownValue)].a5.split(" "),
      widget.notas[widget.list.indexOf(dropdownValue)].a6.split(" "),
      widget.notas[widget.list.indexOf(dropdownValue)].a7.split(" "),
      widget.notas[widget.list.indexOf(dropdownValue)].a8.split(" "),
      widget.notas[widget.list.indexOf(dropdownValue)].a9.split(" ")
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

    return [artes, bio, ef, filo, fis, geo, hist, lem, port, mat, quim, red, socio];
  }

  Future<void> _getCards(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cards = sharedPreferences.getStringList(ownedCards + dropdownValue) ?? [];
    if (selected.length < cards.length) {
      selected = List.filled(allCards.length, false, growable: true);
    }
    if (expanded.length < cards.length) {
      expanded = List.filled(allCards.length, false, growable: true);
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
    if (cards.isEmpty) {
      var avg = media(organizeGrades());

      if (avg < 60) {
        cards.addAll(['100', 'bronzecommon']);
        _updateCards(cards, dropdownValue);
      } else if (avg < 65) {
        cards.addAll(['100', 'bronzecommon', 'bronze']);
        _updateCards(cards, dropdownValue);
      } else if (avg < 70) {
        cards.addAll(['100', 'bronzecommon', 'bronze', 'silvercommon']);
        _updateCards(cards, dropdownValue);
      } else if (avg < 75) {
        cards.addAll(['100', 'bronzecommon', 'bronze', 'silvercommon', 'silver']);
        _updateCards(cards, dropdownValue);
      } else if (avg < 80) {
        cards.addAll(['100', 'bronzecommon', 'bronze', 'silvercommon', 'silver', 'goldcommon']);
        _updateCards(cards, dropdownValue);
      } else if (avg > 85) {
        cards.addAll(['100', 'bronzecommon', 'bronze', 'silvercommon', 'silver', 'goldcommon', 'gold']);
        _updateCards(cards, dropdownValue);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    dropdownValue = widget.students[0].nome;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCards(context),
      builder: (context, AsyncSnapshot data) {
        if (data.connectionState == ConnectionState.done) {
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
                controller: _controller,
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
