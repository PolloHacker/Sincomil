import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget title() {
  return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/sincomil-logo.png"),
          const Text('Versão 1.8.24')
        ],
      ));
}
