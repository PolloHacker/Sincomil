import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sincomil/Classes/Student.dart';
import 'package:sincomil/Classes/nav_handler.dart';
import 'package:sincomil/constants.dart';

List<String> initList(List<Student> data) {
  final List<String> list = [];
  for (var i = 0; i < data.length; i++) {
    list.add(data[i].nome);
  }
  return list;
}

class HomePage extends StatefulWidget {
  final List<Student> data;
  final List<String> fotos;
  final List<String> list;
  final String dropdrownValue;
  const HomePage(
      {super.key,
      required this.data,
      required this.fotos,
      required this.list,
      required this.dropdrownValue});

  @override
  State<HomePage> createState() =>
      _HomePageState(data, fotos, list, dropdrownValue);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.data, this.fotos, this.list, this.dropdownValue);
  final List<Student> data;
  List<String> fotos;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  List<String> list;
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    list = initList(data);
    dropdownValue = list.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: DropdownButton(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) async {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )),
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
            alignment: Alignment.center,
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: buttonColor, width: 5),
                    borderRadius: BorderRadius.circular(20)),
                child: Image.network(fotos.elementAt(list.indexOf(dropdownValue)))),
          ),
          Card(
            color: whiteSecondary,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                color: whitePrimary,
                padding: const EdgeInsets.all(20),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Código único",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data[list.indexOf(dropdownValue)].codigo,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Nome",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data[list.indexOf(dropdownValue)].nome,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Nome de Guerra",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data[list.indexOf(dropdownValue)].nomeGuerra,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Número",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(
                                data[list.indexOf(dropdownValue)]
                                    .numero
                                    .toString(),
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("E-mail",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data[list.indexOf(dropdownValue)].email,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Telefone",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data[list.indexOf(dropdownValue)].telefone,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Data de Nascimento",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data[list.indexOf(dropdownValue)].nascimento,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("CPF",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(
                                data[list.indexOf(dropdownValue)]
                                    .cpf
                                    .toString(),
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Nacionalidade",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(
                                data[list.indexOf(dropdownValue)].nacionalidade,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Naturalidade",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data[list.indexOf(dropdownValue)].naturalidade,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Raça/Cor/Etnia",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data[list.indexOf(dropdownValue)].cor,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Sexo",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data[list.indexOf(dropdownValue)].sexo,
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Aluno Órfão",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(
                                data[list.indexOf(dropdownValue)].orphan
                                    ? 'Sim'
                                    : 'Não',
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Aluno Especial",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(
                                data[list.indexOf(dropdownValue)].especial
                                    ? 'Sim'
                                    : 'Não',
                                style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
