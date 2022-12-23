import 'package:flutter/material.dart';
import 'package:sincomil/Classes/Student.dart';
import 'package:sincomil/Screens/settings_page.dart';
import 'package:sincomil/constants.dart';

import '../Classes/Parent.dart';

class NavDrawer extends StatelessWidget {
  final Parent parent;
  final List<Student> data;
  final List<String> fotos;

  const NavDrawer({super.key, required this.parent, required this.data, required this.fotos});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(parent.nome),
            accountEmail: Text(parent.email),
            decoration: const BoxDecoration(
              color: buttonColor,
              image: DecorationImage(
                  scale: 0.95,
                  image: AssetImage("assets/images/sincomil-banner.png")),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text('Informações pessoais'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail_rounded),
            title: const Text('Renovação de matrícula'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SettingsPage(parent: parent, data: data)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_rounded),
            title: const Text('Ajuda'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.description_rounded),
            title: const Text('About'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app_rounded),
            onTap: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ],
      ),
    );
  }
}
