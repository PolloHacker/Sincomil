import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sincomil/Classes/Student.dart';
import 'package:sincomil/Classes/nav_handler.dart';
import 'package:sincomil/constants.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class HomePage extends StatefulWidget {
  final Student data;
  final String foto;
  const HomePage({super.key, required this.data, required this.foto});

  @override
  State<HomePage> createState() => _HomePageState(data, foto);
}

class _HomePageState extends State<HomePage> {
  _HomePageState(this.data, this.foto);
  final Student data;
  String foto;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String dropdownValue = list.first;

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
                foto = await const NavHandler().getPic(context, data.nome, data.numero);
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

            )
          ),
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
                child: Image.network(foto)),
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
                            const Text("Código único", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.codigo, style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Nome", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.nome, style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Nome de Guerra", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.nomeGuerra, style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Número", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.numero.toString(), style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("E-mail", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.email, style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Telefone", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.telefone, style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Data de Nascimento", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.nascimento, style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("CPF", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.cpf.toString(), style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Nacionalidade", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.nacionalidade, style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Naturalidade", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.naturalidade, style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Raça/Cor/Etnia", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.cor, style: const TextStyle(fontSize: 20)),
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Sexo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.sexo, style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Aluno Órfão", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.orphan ? 'Sim': 'Não', style: const TextStyle(fontSize: 20)),
                          ]),
                      const Divider(color: dividerColor),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Aluno Especial", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text(data.especial ? 'Sim': 'Não', style: const TextStyle(fontSize: 20)),
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
