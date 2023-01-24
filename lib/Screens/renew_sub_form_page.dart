import 'package:flutter/material.dart';

import '../Classes/parent.dart';
import '../Classes/student.dart';

class RenewSubFormPage extends StatefulWidget {
  const RenewSubFormPage({super.key, required this.parent, required this.student});
  final Parent parent;
  final Student student;

  @override
  State<RenewSubFormPage> createState() => _RenewSubFormPageState();
}

class _RenewSubFormPageState extends State<RenewSubFormPage> {
  List<TextEditingController> aluControllers = List.empty(growable: true);
  List<TextEditingController> parentControllers = List.empty(growable: true);
  Map<String, String>? aluMap;
  Map<String, String>? parentMap;

  @override
  void initState() {
    aluMap = widget.student.asMap();
    parentMap = widget.parent.asMap();
    for (int i = 0; i < aluMap!.length; i++) {
      aluControllers.add(TextEditingController(text: aluMap!.entries.elementAt(i).value));
    }
    for (int i = 0; i < parentMap!.length; i++) {
      parentControllers.add(TextEditingController(text: parentMap!.entries.elementAt(i).value));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Renovação de Matrícula"),
        //TODO: Send Data to server
        actions: [IconButton(onPressed: () {
          const snackBar = SnackBar(
            content: Text('A solicitação foi enviada'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop("Data sent");
        }, icon: const Icon(Icons.send_rounded))],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text("Informações do aluno", textAlign: TextAlign.center, style: TextStyle(fontSize: 32)),
                  ),
                  Column(
                    children: aluMap!.entries
                        .map((e) => Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextField(
                              controller: aluControllers[
                                  aluMap!.entries.toList().indexWhere((element) => element.key == e.key)],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: e.key,
                              ),
                            )))
                        .toList(),
                  )
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child:
                        Text("Informações do responsável", textAlign: TextAlign.center, style: TextStyle(fontSize: 32)),
                  ),
                  Column(
                    children: parentMap!.entries
                        .map((e) => Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: TextField(
                              controller: parentControllers[
                                  parentMap!.entries.toList().indexWhere((element) => element.key == e.key)],
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: e.key,
                              ),
                            )))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
