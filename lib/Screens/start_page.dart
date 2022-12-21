import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sincomil/Classes/Student.dart';
import 'package:sincomil/Widgets/nav_drawer.dart';
import 'package:sincomil/constants.dart';

import 'package:sincomil/Screens/payments_page.dart';
import 'package:sincomil/Screens/grades_page.dart';
import 'account_page.dart';
import 'home_page.dart';

class StartPage extends StatefulWidget {
  final List<Student> data;
  final List<String> fotos;
  const StartPage({super.key, required this.data, required this.fotos});

  @override
  State<StartPage> createState() => _StartPageState(data, fotos);
}

class _StartPageState extends State<StartPage> {
  int _page = 0;
  _StartPageState(this.data, this.fotos);
  final List<Student> data;
  final List<String> fotos;
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
        HomePage(data: data, fotos: fotos, list: const [], dropdrownValue: ''),
        PaymentsPage(data: data),
        GradesPage(data: data)
      ].elementAt(_page),
      drawer: const NavDrawer(),
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
