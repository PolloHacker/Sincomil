import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sincomil/Constants/shared_constants.dart';
import 'package:sincomil/Provider/app_settings.dart';

import '../Constants/constants.dart';

class PlayerCard extends StatelessWidget {
  PlayerCard(
      {super.key,
      required this.fotosBG,
      required this.nomes,
      required this.list,
      required this.dropdownValue,
      required this.organizeGrades});

  final List<String> fotosBG;
  final List<String> nomes;
  final List<String> list;
  final String dropdownValue;
  final Future<List<List<double>>> organizeGrades;

  final Size _cardSize = const Size(400, 471);
  bool useCard = false;
  String carta = 'bronzecommon';

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

  void _getCard(BuildContext context, String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    carta = sharedPreferences.getString(currentCard + name) ?? 'bronzecommon';
  }

  @override
  Widget build(BuildContext context) {
    _getCard(context, dropdownValue);
    return FutureBuilder(
        future: organizeGrades,
        builder: (context, AsyncSnapshot<List<List<double>>> data) {
          if (data.hasData) {
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
                        alignment: Alignment.centerLeft,
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
                      child: Text(media(data.data!).toString(),
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
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.ropaSans().fontFamily,
                            color: cartas[carta])),
                  )
                ],
              ),
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
