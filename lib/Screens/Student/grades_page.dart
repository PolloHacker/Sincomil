import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sincomil/Provider/app_settings.dart';
import 'package:sincomil/Widgets/Student/grades_radar.dart';
import 'package:sincomil/Widgets/Student/grades_table.dart';
import 'package:sincomil/Widgets/Portraits/player_card.dart';

import '../../Classes/Student/grades_entity.dart';

class GradesPage extends StatelessWidget {
  final List<GradesEntity> notas;
  final List<String> list;
  final List<String> nomes;
  final List<String> fotos;
  final List<String> fotosBG;
  final String dropdownValue;
  const GradesPage(
      {super.key,
      required this.notas,
      required this.dropdownValue,
      required this.list,
      required this.fotos,
      required this.fotosBG,
      required this.nomes});

  @override
  Widget build(BuildContext context) {
    final useCards = Provider.of<AppSettings>(context);
    return Material(
      elevation: 0,
      borderOnForeground: false,
      child: ListView(
        children: <Widget>[
          useCards.useCard == "true"
              ? PlayerCard(
                  fotosBG: fotosBG,
                  list: list,
                  nomes: nomes,
                  dropdownValue: dropdownValue,
          notas: notas)
              : Container(),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            alignment: Alignment.center,
            child: Card(
              elevation: 10.0,
              shadowColor: const Color.fromRGBO(255, 255, 255, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GradesTable(
                    notas: notas,
                    list: list,
                    dropdownValue: dropdownValue),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
            alignment: Alignment.center,
            child: RadarGraph(list: list, notas: notas),
          )
        ],
      ),
    );
  }
}
