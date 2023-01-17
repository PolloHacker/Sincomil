import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sincomil/Classes/parent.dart';
import 'package:sincomil/Classes/student.dart';
import 'package:sincomil/Widgets/expandable_list_tile.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key, required this.parent, required this.data});

  final Parent parent;
  final List<Student> data;

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  bool _pwd = false;
  TextEditingController oldPwdController = TextEditingController();
  bool _showOldPwd = false;
  TextEditingController newPwdController = TextEditingController();
  bool _showNewPwd = false;
  TextEditingController confPwdController = TextEditingController();
  bool _showConfPwd = false;

  bool _showPwd = false;

  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Coloque seu dedo no sensor digital',
        options: const AuthenticationOptions(stickyAuth: true, biometricOnly: true),
      );
      setState(() {
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      setState(() {
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  SnackBar checkPass() {
    final SnackBar snackBar;
    if (oldPwdController.text == widget.parent.password) {
      if (newPwdController.text.length > 6) {
        if (newPwdController.text == confPwdController.text) {
          snackBar = const SnackBar(content: Text("Sua senha foi atualizada"));
        } else {
          snackBar = const SnackBar(content: Text("As senhas não correspondem"));
        }
      } else {
        snackBar = const SnackBar(content: Text("A senha é muito curta"));
      }
    } else {
      snackBar = const SnackBar(content: Text("Senha incorreta"));
    }
    return snackBar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informações pessoais"),
      ),
      body: Material(
        elevation: 0,
        borderOnForeground: false,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.account_circle_rounded),
              title: Row(
                children: [const Text("Nome"), const Spacer(), Text(widget.parent.nome)],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email_rounded),
              title: Row(
                children: [const Text("E-mail"), const Spacer(), Text(widget.parent.email)],
              ),
            ),
            _pwd
                ? Card(
                    elevation: 4,
                    child: ListTile(
                      title: Column(
                        children: [
                          const Text("Mudar senha"),
                          Container(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: TextField(
                                controller: oldPwdController,
                                obscureText: !_showOldPwd,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _showOldPwd ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _showOldPwd = !_showOldPwd;
                                        });
                                      },
                                    ),
                                    labelText: 'Sua senha atual'),
                              )),
                          Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextField(
                                controller: newPwdController,
                                obscureText: !_showNewPwd,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _showNewPwd ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _showNewPwd = !_showNewPwd;
                                        });
                                      },
                                    ),
                                    labelText: 'Sua nova senha'),
                              )),
                          Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextField(
                                controller: confPwdController,
                                obscureText: !_showConfPwd,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _showConfPwd ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _showConfPwd = !_showConfPwd;
                                        });
                                      },
                                    ),
                                    labelText: 'Digite novamente'),
                              )),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _pwd = false;
                                });
                              },
                              child: const Text("Cancelar")),
                          ElevatedButton(
                              onPressed: () {
                                final SnackBar snackBar;
                                if (oldPwdController.text.isNotEmpty &&
                                    newPwdController.text.isNotEmpty &&
                                    confPwdController.text.isNotEmpty) {
                                  snackBar = checkPass();
                                } else {
                                  snackBar = const SnackBar(content: Text("Há campos vazios."));
                                }
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              },
                              child: const Text("Confirmar"))
                        ],
                      ),
                    ),
                  )
                : ListTile(
                    leading: const Icon(Icons.lock_outline_rounded),
                    title: Row(
                      children: [
                        const Text("Senha"),
                        const Spacer(),
                        Text(_showPwd
                            ? widget.parent.password
                            : widget.parent.password.replaceAll(RegExp(r'[a-zA-Z0-9]'), '*')),
                        IconButton(
                            icon: Icon(_showPwd ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                            onPressed: () async {
                              await _authenticateWithBiometrics();
                              if (_authorized == 'Authorized') {
                                setState(() {
                                  _showPwd = !_showPwd;
                                });
                              }
                            })
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _pwd = true;
                      });
                    },
                  ),
            ListTile(
              leading: const Icon(Icons.fact_check_rounded),
              title: Row(
                children: [const Text("CPF"), const Spacer(), Text(widget.parent.cpf.replaceRange(2, 12, '*.***.***-'))],
              ),
            ),
            Card(
              elevation: 4,
              child: ExpandableListTile(
                title: Row(children: const [
                  Icon(Icons.supervisor_account_rounded),
                  Spacer(flex: 1),
                  Text('Alunos sob tutela'),
                  Spacer(flex: 2),
                ]),
                child: Column(
                  children: widget.data
                      .map((e) =>
                          ListTile(leading: const Icon(Icons.supervised_user_circle_rounded), title: Text(e.nome)))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
