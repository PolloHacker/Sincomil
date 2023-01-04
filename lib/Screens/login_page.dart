import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sincomil/Classes/nav_handler.dart';
import 'package:sincomil/Screens/start_page.dart';
import 'package:sincomil/Widgets/login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../Constants/constants.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = const FlutterSecureStorage();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  dynamic grades;
  bool remember = false;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                              splashRadius: 10.0,
                              value: remember,
                              onChanged: (value) {
                                setState(() {
                                  remember = value!;
                                });
                              }),
                          const Text("Lembre-se de mim",
                              style: TextStyle(color: buttonColor))
                        ],
                      ),
                      Container(
                          height: 50,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            onPressed: () async {
                              final String email = nameController.text;
                              final String pass = passwordController.text;
                              List read = [];
                              try {
                                read = await const NavHandler()
                                    .check(context, email, pass);
                              } catch (error) {
                                const snackBar = SnackBar(
                                    content: Text("Email ou senha inválidos."));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              final parent = read[0];
                              final data = read[1];
                              final List<String> nomes = [];
                              final List<int> numeros = [];
                              for (var i = 0; i < data.length; i++) {
                                nomes.add(data[i].nome);
                              }
                              for (var i = 0; i < data.length; i++) {
                                numeros.add(data[i].numero);
                              }
                              if (remember) {
                                await storage.write(
                                    key: "KEY_USERNAME", value: email);
                                await storage.write(
                                    key: "KEY_PASSWORD", value: pass);
                              }

                              if (!mounted) return;
                              final fotos = await const NavHandler()
                                  .getPic(context, nomes, numeros);
                              if (!mounted) return;
                              grades = await const NavHandler()
                                  .getGrades(context, nomes);
                              if (!mounted) return;
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SlideInUp(
                                          child: StartPage(
                                        parent: parent,
                                        data: data,
                                        fotos: fotos,
                                        list: initList(data),
                                        grades: grades,
                                        value: data[0].nome,
                                      ))));
                            },
                            style: ElevatedButton.styleFrom(
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
