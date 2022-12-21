import 'package:flutter/material.dart';
import '../Classes/Student.dart';

class GradesPage extends StatefulWidget {
  final List<Student> data;
  const GradesPage({super.key, required this.data});

  @override
  State<GradesPage> createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return ListView();
  }
}