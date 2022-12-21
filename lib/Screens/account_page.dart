import 'package:flutter/material.dart';
import '../Classes/Student.dart';

class AccountPage extends StatefulWidget {
  final List<Student> data;
  final List<String> fotos;
  const AccountPage({super.key, required this.data, required this.fotos});

  @override
  State<AccountPage> createState() => _AccountPageState(this.data, this.fotos);
}

class _AccountPageState extends State<AccountPage> {
  final List<Student> data;
  final List<String>fotos;

  _AccountPageState(this.data, this.fotos);

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return ListView(
      children: <Widget>[
        Container(

        )
      ],
    );
  }
}