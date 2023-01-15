import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sincomil/Constants/shared_constants.dart';

import '../Classes/grades.dart';
import '../Constants/constants.dart';

class PlayerCard extends StatelessWidget {
  PlayerCard(
      {super.key,
      required this.fotosBG,
      required this.nomes,
      required this.list,
      required this.dropdownValue,
      required this.notas});

  final List<String> fotosBG;
  final List<String> nomes;
  final List<String> list;
  final String dropdownValue;
  final List<Grades> notas;

  final Size _cardSize = const Size(400, 471);
  bool useCard = false;
  String carta = '0';

  int media(List<Grades> data) {
    double media = 0;
    for (var element in data[list.indexOf(dropdownValue)].artes.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].bio.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].ef.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].filo.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].fis.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].geo.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].hist.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].lem.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].port.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].mat.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].quim.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].red.grades) {
      media += element;
    }
    for (var element in data[list.indexOf(dropdownValue)].socio.grades) {
      media += element;
    }

    media /= 11.7;

    return media.round();
  }

  Future<void> _getCard(BuildContext context, String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    carta = sharedPreferences.getString(currentCard + name) ?? 'bronzecommon';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getCard(context, dropdownValue),
        builder: (context, AsyncSnapshot data) {
          if (data.connectionState == ConnectionState.done) {
            return Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/Cartinhas/$carta.png'),
                  //Flag
                  Positioned(
                      left: _cardSize.width * 0.17,
                      child: Image.asset('assets/images/Cartinhas/brasil.png',
                          width: _cardSize.width * 0.15, height: _cardSize.height * 0.2)),
                  //Picture
                  Positioned(
                      right: _cardSize.width * 0.12,
                      top: _cardSize.height * 0.16,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.network(
                          fotosBG[nomes.indexOf(nomes.elementAt(list.indexOf(dropdownValue)))],
                          width: _cardSize.width * 0.55,
                          height: _cardSize.height * 0.55,
                        ),
                      )),
                  //Overall
                  Positioned(
                      left: _cardSize.width * 0.17,
                      top: _cardSize.height * 0.25,
                      child: Text(media(notas).toString(),
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.ropaSans().fontFamily,
                              color: cartas[carta]))),
                  //Name
                  Positioned(
                    top: _cardSize.height * 0.69,
                    child: Text(nomes.elementAt(list.indexOf(dropdownValue)),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.ropaSans().fontFamily,
                            color: cartas[carta])),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
