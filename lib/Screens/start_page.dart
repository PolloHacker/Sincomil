import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sincomil/Classes/Student.dart';
import 'package:sincomil/constants.dart';

import 'package:sincomil/Screens/payments_page.dart';
import 'package:sincomil/Screens/grades_page.dart';
import 'account_page.dart';
import 'home_page.dart';

class StartPage extends StatefulWidget {
  final Student data;
  final String foto;
  const StartPage({super.key, required this.data, required this.foto});

  @override
  State<StartPage> createState() => _StartPageState(data, foto);
}

class _StartPageState extends State<StartPage> {
  int _page = 0;
  _StartPageState(this.data, this.foto);
  final Student data;
  final String foto;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: titles.elementAt(_page),
        backgroundColor: navigationBarBG,
      ),
      body: <Widget>[
        HomePage(data: data, foto: foto),
        PaymentsPage(data: data),
        GradesPage(data: data),
        AccountPage(data: data),
      ].elementAt(_page),
      bottomNavigationBar: CurvedNavigationBar(
          items: const <Widget>[
            Icon(Icons.home_rounded, size: 30, color: whitePrimary),
            Icon(Icons.payments_rounded, size: 30, color: whitePrimary),
            Icon(Icons.bar_chart_rounded, size: 30, color: whitePrimary),
            Icon(Icons.account_circle_rounded, size: 30, color: whitePrimary)
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
  Text('Boletim Escolar'),
  Text('Perfil')
];
