import 'package:flutter/material.dart';
import '../Classes/Student.dart';

class PaymentsPage extends StatefulWidget {
  final Student data;
  const PaymentsPage({super.key, required this.data});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {

  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return ListView();
  }
}