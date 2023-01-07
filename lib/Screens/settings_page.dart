import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sincomil/Constants/shared_constants.dart';
import 'package:sincomil/Provider/app_settings.dart';
import '../Classes/parent.dart';
import '../Classes/student.dart';

class SettingsPage extends StatefulWidget {
  final Parent parent;
  final List<Student> data;

  const SettingsPage({super.key, required this.parent, required this.data});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final storage = const FlutterSecureStorage();
  late String user;
  late String password;
  bool themeControl = false;
  bool fingerControl = false;
  bool cardControl = false;

  @override
  void initState() {
    readInfo();
    super.initState();
  }

  void readInfo() async {
    user = await storage.read(key: "KEY_USERNAME") ?? "";
    password = await storage.read(key: "KEY_PASSWORD") ?? "";
  }

  Future<bool> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    themeControl = sharedPreferences.getBool("is_dark") ?? false;
    fingerControl = sharedPreferences.getBool("use_finger") ?? false;
    cardControl = sharedPreferences.getBool(usePortraits) ?? false;
    return themeControl;
  }

  void _toggleTheme() {
    final settings = Provider.of<AppSettings>(context, listen: false);
    settings.toggleTheme();
  }

  void _toggleSecurity() {
    final settings = Provider.of<AppSettings>(context, listen: false);
    settings.toggleSecurity();
  }

  void _toggleCard() {
    final settings = Provider.of<AppSettings>(context, listen: false);
    settings.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTheme(),
        builder: (context, AsyncSnapshot<bool> theme) {
          if (theme.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Configurações"),
              ),
              body: Material(
                child: SettingsList(
                  sections: [
                    SettingsSection(
                      title: const Text('Common'),
                      tiles: <SettingsTile>[
                        SettingsTile.navigation(
                          leading: const Icon(Icons.language),
                          title: const Text('Idioma'),
                          value: const Text('Português'),
                          onPressed: (context) {},
                        ),
                        SettingsTile.switchTile(
                          leading: const Icon(Icons.portrait_rounded),
                            initialValue: cardControl,
                            onToggle: (value) {
                              setState(() {
                                cardControl = value;
                              });
                              _toggleCard();
                            },
                            title: const Text('Usar cartas')),
                        SettingsTile.switchTile(
                          onToggle: (value) {
                            setState(() {
                              themeControl = value;
                            });
                            _toggleTheme();
                          },
                          leading: themeControl
                              ? const Icon(Icons.dark_mode_rounded)
                              : const Icon(Icons.sunny),
                          title: const Text('Tema escuro'),
                          initialValue: themeControl,
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: const Text('Segurança'),
                      tiles: <SettingsTile>[
                        SettingsTile.switchTile(
                            onToggle: (value) {
                              setState(() {
                                fingerControl = value;
                              });
                              _toggleSecurity();
                            },
                            leading: const Icon(Icons.fingerprint_rounded),
                            title: const Text('Usar impressão digital'),
                            initialValue: fingerControl),
                        SettingsTile(
                            leading: const Icon(Icons.delete_rounded),
                            title: const Text('Esquecer informações de login'),
                            description: const Text(
                                'Apagar usuário e senha da memória do dispositivo.'),
                            onPressed: (context) => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      icon: const Icon(Icons.warning_rounded),
                                      title: const Text(
                                          "Você deseja apagar as informações de login?",
                                          textAlign: TextAlign.center),
                                      content: const Text(
                                          "Apagar essas informações impede o login automático.",
                                      textAlign: TextAlign.center),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop('Cancel'),
                                            child: const Text("Cancelar")),
                                        TextButton(
                                          onPressed: () {
                                            storage.delete(key: "KEY_USERNAME");
                                            storage.delete(key: "KEY_PASSWORD");
                                            Navigator.of(context)
                                                .pop('OK');
                                            final snackBar = SnackBar(
                                              content: const Text('As informações foram apagadas.'),
                                              action: SnackBarAction(
                                                label: 'Desfazer',
                                                onPressed: () {
                                                  // Some code to undo the change.
                                                  storage.write(key: "KEY_USERNAME", value: user);
                                                  storage.write(key: "KEY_PASSWORD", value: password);
                                                },
                                              ),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          },
                                          child: const Text(
                                            "OK",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      ],
                                    )))
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
