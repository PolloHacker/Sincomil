import 'package:flutter/material.dart';

import '../Classes/Parent.dart';
import '../Classes/Student.dart';

class SettingsPage extends StatefulWidget {
  final Parent parent;
  final List<Student> data;

  const SettingsPage({super.key, required this.parent, required this.data});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return ListView(

    );
  }
}