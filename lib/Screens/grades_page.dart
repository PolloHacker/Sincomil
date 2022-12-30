import 'package:flutter/material.dart';
import '../Classes/Student.dart';

class GradesPage extends StatelessWidget {
  final List data;
  const GradesPage({super.key, required this.data});


  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return Material(
      elevation: 0,
      borderOnForeground: false,
      child: ListView(
        children: <Widget>[

        ],
      ),
    );
  }
}