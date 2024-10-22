import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sincomil/Classes/Student/student_entity.dart';
import 'package:sincomil/Provider/app_settings.dart';
import 'package:sincomil/Screens/Portraits/card_collection_page.dart';
import 'package:sincomil/Screens/Parent/help_page.dart';
import 'package:sincomil/Screens/Auth/login_page.dart';
import 'package:sincomil/Screens/Parent/personal_info_page.dart';
import 'package:sincomil/Screens/settings_page.dart';

import '../../Classes/Student/grades_entity.dart';
import '../../Classes/Parent/parent_entity.dart';
import '../../Screens/Resub/renew_sub_page.dart';

class NavDrawer extends StatelessWidget {
  final ParentEntity parent;
  final List<StudentEntity> data;
  final List<String> fotos;
  final List<String> list;
  final List<GradesEntity> notas;

  const NavDrawer(
      {super.key,
      required this.parent,
      required this.data,
      required this.fotos,
      required this.list,
      required this.notas});

  @override
  Widget build(BuildContext context) {
    final cardSettings = Provider.of<AppSettings>(context, listen: false);
    return Drawer(
      child: Material(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(parent.nome, style: const TextStyle(color: Colors.white)),
              accountEmail: Text(parent.email, style: const TextStyle(color: Colors.white)),
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                image: const DecorationImage(scale: 1, image: AssetImage("assets/images/sincomil-banner.png")),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_rounded),
              title: const Text('Informações pessoais'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SlideInUp(child: PersonalInfoPage(parent: parent, data: data))));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail_rounded),
              title: const Text('Renovação de matrícula'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SlideInUp(child: RenewSubPage(parent: parent, data: data))));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SlideInUp(child: SettingsPage(parent: parent, data: data))));
              },
            ),
            if (cardSettings.useCard == "true")
              ListTile(
                leading: const Icon(Icons.collections),
                title: const Text('Coleção de cartas'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SlideInUp(
                              child: CardColection(
                            students: data,
                            fotos: fotos,
                            list: list,
                            notas: notas,
                          ))));
                },
              ),
            ListTile(
              leading: const Icon(Icons.help_rounded),
              title: const Text('Ajuda'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SlideInUp(child: HelpPage(parent: parent, students: data))));
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Exit'),
              leading: const Icon(Icons.logout_rounded),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage())),
            ),
          ],
        ),
      ),
    );
  }
}
