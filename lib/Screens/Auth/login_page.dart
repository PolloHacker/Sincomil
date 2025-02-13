import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sincomil/DataSource/nav_handler.dart';
import 'package:sincomil/Screens/start_page.dart';
import 'package:sincomil/Widgets/Commons/login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../Classes/Parent/parent_entity.dart';
import '../../Classes/Student/student_entity.dart';
import '../../Widgets/Commons/date_picker.dart';
import '../Student/home_page.dart';

const List<String> colegios = <String>[
  'Selecione o Colégio',
  'Colégio Militar Do Rio De Janeiro',
  'Colégio Militar De Porto Alegre',
  'Colégio Militar De Fortaleza',
  'Colégio Militar De Belo Horizonte',
  'Colégio Militar De Salvador',
  'Colégio Militar De Curitiba',
  'Colégio Militar De Recife',
  'Colégio Militar De Manaus',
  'Colégio Militar De Brasília',
  'Colégio Militar De Campo Grande',
  'Colégio Militar De Juiz De Fora',
  'Colégio Militar De Santa Maria',
  'Colégio Militar De Belém',
  'Colégio Militar De São Paulo',
  'Colégio Militar De Manaus EAD',
  'Colégio Militar Da Vila Militar'
];

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = const FlutterSecureStorage();

  bool forgot = false;
  bool signUp = false;
  bool pushing = false;

  //normal login controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //forgot pass controller
  TextEditingController cpfController = TextEditingController();
  String datePass = "";

  //sign up controllers
  TextEditingController cpfUpController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String dropdownValue = colegios.first;
  String dateRegister = "";

  dynamic grades;
  bool remember = false;
  bool _showPwd = false;

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
                forgot
                    ? forgotPass()
                    : signUp
                        ? register()
                        : logIn()
              ],
            )));
  }

  callBackPass(String date) {
    datePass = date;
  }

  callBackRegister(String date) {
    dateRegister = date;
  }

  Widget forgotPass() {
    return SlideInRight(
        child: Card(
      elevation: 5.0,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: cpfController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), prefixIcon: Icon(Icons.perm_identity_rounded), labelText: 'Seu CPF'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: DatePicker(callback: callBackPass),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                setState(() {
                  forgot = false;
                });
              },
              child: const Text('Cancelar'),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                const NavHandler().recoverPass(cpfController.text, datePass).then((value) {
                  final SnackBar snackBar;
                  if (value) {
                    snackBar = const SnackBar(content: Text("Senha resetada."));
                  } else {
                    snackBar = const SnackBar(content: Text("Erro ao resetar senha."));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              },
              child: const Text('Recuperar senha'))
        ],
      ),
    ));
  }

  Widget register() {
    return SlideInRight(
        child: Card(
      elevation: 5.0,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: cpfUpController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), prefixIcon: Icon(Icons.perm_identity_rounded), labelText: 'Seu CPF'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), prefixIcon: Icon(Icons.email_rounded), labelText: 'Seu e-mail'),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: DatePicker(callback: callBackRegister),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down_rounded),
              elevation: 16,
              underline: Container(
                height: 2,
                color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({MaterialState.pressed}),
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: colegios.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  signUp = false;
                });
              },
              child: const Text('Cancelar'),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  const NavHandler()
                      .register(emailController.text, cpfUpController.text, dateRegister, dropdownValue)
                      .then((value) {
                    final SnackBar snackBar;
                    if (value) {
                      snackBar = const SnackBar(content: Text("Usuário registrado."));
                    } else {
                      snackBar = const SnackBar(content: Text("Erro ao registrar usuário."));
                    }
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                child: Text('Solicitar cadastro',
                    style: TextStyle(
                        color: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.foregroundColor
                            ?.resolve({MaterialState.pressed}))),
              ))
        ],
      ),
    ));
  }

  Widget logIn() {
    return SlideInLeft(
        child: Card(
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
              obscureText: !_showPwd,
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _showPwd ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _showPwd = !_showPwd;
                    });
                  },
                ),
                labelText: 'Sua senha',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                forgot = true;
              });
              //forgot password screen
            },
            child: Text('Esqueceu a senha?',
                style: TextStyle(
                    color: Theme.of(context)
                        .elevatedButtonTheme
                        .style
                        ?.foregroundColor
                        ?.resolve({MaterialState.pressed}))),
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
              Text("Lembre-se de mim",
                  style: TextStyle(
                      color: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.foregroundColor
                          ?.resolve({MaterialState.pressed})))
            ],
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    pushing = true;
                  });
                  final String email = nameController.text;
                  final String pass = passwordController.text;
                  List read = [];
                  try {
                    read = await const NavHandler().check(email, pass);
                  } catch (error) {
                    const snackBar = SnackBar(content: Text("Email ou senha inválidos."));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    setState(() {
                      pushing = false;
                    });
                  }
                  final ParentEntity parent = read[0];
                  final List<StudentEntity> data = read[1];
                  final List<String> nomes = [];
                  final List<int> numeros = [];
                  for (var i = 0; i < data.length; i++) {
                    nomes.add(data[i].nome);
                  }
                  for (var i = 0; i < data.length; i++) {
                    numeros.add(data[i].numero);
                  }
                  if (remember) {
                    await storage.write(key: "KEY_USERNAME", value: email);
                    await storage.write(key: "KEY_PASSWORD", value: pass);
                  }

                  final fotos = await const NavHandler().getPic(nomes, numeros);

                  final fotosBG = await const NavHandler().getPickBG(nomes, numeros);
                  grades = await const NavHandler().getGrades(nomes);

                  final payments = await const NavHandler().getPayments(parent.id);
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
                            fotosBG: fotosBG,
                            payments: payments,
                          ))));
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                child: pushing
                    ? const CircularProgressIndicator()
                    : Text('Login',
                        style: TextStyle(
                            color: Theme.of(context)
                                .elevatedButtonTheme
                                .style
                                ?.foregroundColor
                                ?.resolve({MaterialState.pressed}))),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Novo por aqui?'),
              TextButton(
                child: Text(
                  'Cadastre-se',
                  style: TextStyle(
                      color: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.foregroundColor
                          ?.resolve({MaterialState.pressed})),
                ),
                onPressed: () {
                  setState(() {
                    signUp = true;
                  });
                  //signup screen
                },
              )
            ],
          ),
        ],
      ),
    ));
  }
}
