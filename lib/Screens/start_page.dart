import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sincomil/Widgets/nav_drawer.dart';
import 'package:sincomil/constants.dart';

import 'package:sincomil/Screens/payments_page.dart';
import 'package:sincomil/Screens/grades_page.dart';
import '../Classes/Parent.dart';
import '../Classes/Student.dart';
import 'home_page.dart';

class StartPage extends StatefulWidget {
  final Parent parent;
  final List<Student> data;
  final List<String> fotos;
  final String value;
  const StartPage({super.key, required this.parent, required this.data, required this.fotos, required this.value});

  @override
  State<StartPage> createState() => _StartPageState(parent, data, fotos, value);
}

class _StartPageState extends State<StartPage> {
  int _page = 0;
  _StartPageState(this.parent, this.data, this.fotos, this.value);
  final Parent parent;
  final List<Student> data;
  final List<String> fotos;
  String value;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
        title: titles.elementAt(_page),
        backgroundColor: navigationBarBG,
      ),
      body: <Widget>[
        HomePage(data: data, fotos: fotos
        ,list: initList(data), dropdrownValue: ''),
        PaymentsPage(data: data),
        GradesPage(data: data)
      ].elementAt(_page),
      drawer: NavDrawer(parent: parent, data: data, fotos: fotos),
      bottomNavigationBar: CurvedNavigationBar(
          items: const <Widget>[
            Icon(Icons.home_rounded, size: 30, color: whitePrimary),
            Icon(Icons.payments_rounded, size: 30, color: whitePrimary),
            Icon(Icons.bar_chart_rounded, size: 30, color: whitePrimary)
          ],
          onTap: (index) => {
                setState(() {
                  _page = index;
                })
              },
          letIndexChange: (index) => true,
          color: navigationBarBG,
          backgroundColor: whitePrimary,
          buttonBackgroundColor: navigationBarBG),
    );
  }
}

const List<Widget> titles = <Widget>[
  Text('Visualização de aluno'),
  Text('Pagamentos'),
  Text('Boletim Escolar')
];
