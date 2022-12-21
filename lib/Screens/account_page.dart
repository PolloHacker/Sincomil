import 'package:flutter/material.dart';
import '../Classes/Student.dart';

class AccountPage extends StatefulWidget {
  final Student data;
  const AccountPage({super.key, required this.data});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return ListView();
  }
}