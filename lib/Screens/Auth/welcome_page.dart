import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sincomil/Classes/Parent/payments.dart';
import 'package:sincomil/Constants/constants.dart';
import 'package:sincomil/Screens/start_page.dart';

import '../../DataSource/nav_handler.dart';
import '../Student/home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late AnimationController _controller;

  final storage = const FlutterSecureStorage();
  dynamic parent;
  dynamic data;
  dynamic grades;
  final List<String> nomes = [];
  final List<int> numeros = [];
  List<String> fotos = [];
  List<String> fotosBG = [];
  List<Payments> payments = [];

  Future<List<String>> _readFromStorage() async {
    var email = await storage.read(key: "KEY_USERNAME") ?? '';
    var pass = await storage.read(key: "KEY_PASSWORD") ?? '';
    return [email, pass];
  }

  Future<void> pushData() async {
    final dt = await _readFromStorage();
    final read = await const NavHandler().check(dt[0], dt[1]);
    parent = read[0];
    data = read[1];

    for (var i = 0; i < data.length; i++) {
      nomes.add(data[i].nome);
    }
    for (var i = 0; i < data.length; i++) {
      numeros.add(data[i].numero);
    }
    fotos = await const NavHandler().getPic(nomes, numeros);
    fotos = fotos.sublist(0, data.length);

    fotosBG = await const NavHandler().getPickBG(nomes, numeros);
    fotosBG = fotosBG.sublist(0, data.length);
    grades = await const NavHandler().getGrades(nomes);
    grades = grades.sublist(0, data.length);
    payments = await const NavHandler().getPayments(parent.id);

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // custom code here
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
                    payments: payments))));
      }
    });

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: pushData(),
        builder: (context, AsyncSnapshot data) {
          if (data.connectionState == ConnectionState.done) {
            return Material(
              elevation: 0,
              borderOnForeground: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  FadeInDown(
                      duration: const Duration(seconds: 1), child: Image.asset("assets/images/sincomil-logo.png")),
                  const Spacer(),
                  FadeInUp(
                      controller: (controller) => _controller = controller,
                      delay: const Duration(seconds: 1),
                      child: Text("Bem vindo, ${parent.nome}.", style: const TextStyle(fontSize: 30))),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            );
          } else {
            return Material(
              elevation: 0,
              borderOnForeground: false,
              child: Center(
                child: Column(
                  children: const [
                    Spacer(),
                    CircularProgressIndicator(color: buttonColor),
                    Text(
                      "Recebendo dados",
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }
        });
  }
}
