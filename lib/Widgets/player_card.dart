import 'package:flutter/material.dart';
import 'package:sincomil/Widgets/card_reveal.dart';

import '../Constants/constants.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard(
      {super.key,
      required this.fotosBG,
      required this.list,
      required this.dropdownValue,
      required this.organizeGrades});

  final List<String> fotosBG;
  final List<String> list;
  final String dropdownValue;
  final Future<List<List<double>>> organizeGrades;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: organizeGrades,
        builder: (context, AsyncSnapshot<List<List<double>>> data) {
          if (data.hasData) {
            return Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              alignment: Alignment.center,
              child: CardReveal(key: ValueKey<Map<String, List>>({dropdownValue: data.data!}), fotosBG: fotosBG, list: list, dropdownValue: dropdownValue, data: data.data!),
            );
          } else {
            return const Material(
              elevation: 0,
              borderOnForeground: false,
              child: Center(
                child: CircularProgressIndicator(color: buttonColor),
              ),
            );
          }
        });
  }
}
