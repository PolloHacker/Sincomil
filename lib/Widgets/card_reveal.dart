import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/constants.dart';

class CardReveal extends StatefulWidget {
  const CardReveal(
      {required this.key,
      required this.fotosBG,
      required this.list,
      required this.dropdownValue,
      required this.data});
  @override
  final ValueKey<Map<String, List>> key;
  final List<String> fotosBG;
  final List<String> list;
  final String dropdownValue;
  final List<List<double>> data;

  @override
  State<CardReveal> createState() =>
      _CardRevealState(key, fotosBG, list, dropdownValue, data);
}

class _CardRevealState extends State<CardReveal> {
  final ValueKey<Map<String, List>> key;
  final List<String> fotosBG;
  final List<String> list;
  final String dropdownValue;
  final List<List<double>> data;

  final _cardKey = GlobalKey();
  Size? _cardSize;

  String carta = '100';

  _CardRevealState(
      this.key, this.fotosBG, this.list, this.dropdownValue, this.data);

  void _getSize() {
    setState(() {
      _cardSize = _cardKey.currentContext!.size;
    });
  }

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

  //TODO: Add card colection
  void _getCard(List<List<double>> data) {
    var avg = media(data);
    if (avg < 60) {
      carta = 'bronzecommon';
    } else if (avg < 70){
      carta = 'bronze';
    } else if (avg < 75) {
      carta = 'silvercommon';
    } else if (avg < 80) {
      carta = 'silver';
    } else if (avg < 85) {
      carta = 'goldcommon';
    } else {
      carta = 'gold';
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1), () {
      _getSize();
      _getCard(data);
    });
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Image.asset('assets/images/Cartinhas/$carta.png', key: _cardKey),
        //Flag
        Positioned(
            left: _cardSize != null
                ? _cardSize!.width * 0.15
                : MediaQuery.sizeOf(context).width / 7,
            child: Image.asset('assets/images/Cartinhas/brasil.png',
                width: _cardSize != null
                    ? _cardSize!.width * 0.22
                    : MediaQuery.sizeOf(context).width / 7,
                height: _cardSize != null
                    ? _cardSize!.width * 0.22
                    : MediaQuery.sizeOf(context).height / 15)),
        //Picture
        Positioned(
            right: _cardSize != null
                ? _cardSize!.width * 0.075
                : MediaQuery.sizeOf(context).width / 7,
            top: _cardSize != null
                ? _cardSize!.width * 0.235
                : MediaQuery.sizeOf(context).height / 15,
            child: Image.network(
              fotosBG[list.indexOf(dropdownValue)],
              width: _cardSize != null
                  ? _cardSize!.width * 0.6
                  : MediaQuery.sizeOf(context).width / 2.5,
              height: _cardSize != null
                  ? _cardSize!.width * 0.6
                  : MediaQuery.sizeOf(context).height / 4,
            )),
        //Overall
        Positioned(
            left: _cardSize != null
                ? _cardSize!.width * 0.20
                : MediaQuery.sizeOf(context).width / 7,
            top: _cardSize != null
                ? _cardSize!.width * 0.3
                : MediaQuery.sizeOf(context).height / 15,
            child: Text(media(data).toString(),
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.ropaSans().fontFamily,
                color: cartas[carta])))
      ],
    );
  }
}
