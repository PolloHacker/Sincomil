import 'package:flutter/material.dart';
import 'package:sincomil/Classes/Student.dart';
import 'package:sincomil/Classes/nav_handler.dart';
import 'package:sincomil/Screens/start_page.dart';
import 'package:sincomil/Widgets/login.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                title(),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Por favor, faça o login',
                      style: TextStyle(fontSize: 20),
                    )),
                Card(
                  color: whitePrimary,
                  elevation: 5.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: 'Seu e-mail',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock_rounded),
                            labelText: 'Sua senha',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //TODO: add forgot password screen
                          //forgot password screen
                        },
                        child: const Text('Esqueceu a senha?',
                            style: TextStyle(color: buttonColor)),
                      ),
                      Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              final String email = nameController.text;
                              final String pass = passwordController.text;
                              final data = await const NavHandler().check(context, email, pass);
                              if (!mounted) return;
                              final foto = await const NavHandler().getPic(context, data.nome, data.numero);
                              if (!mounted) return;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      StartPage(data: data, foto: foto)));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                minimumSize: const Size.fromHeight(50)),
                            child: const Text('Login'),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Novo por aqui?'),
                          TextButton(
                            child: const Text(
                              'Cadastre-se',
                              style: TextStyle(color: buttonColor),
                            ),
                            onPressed: () {
                              //TODO: add signup screen
                              //signup screen
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
