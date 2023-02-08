import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sincomil/Classes/Student/student_entity.dart';
import 'package:sincomil/Constants/constants.dart';

List<String> initList(List data) {
  final List<String> list = [];
  for (var i = 0; i < data.length; i++) {
    list.add(data[i].nome);
  }
  return list;
}

class HomePage extends StatelessWidget {
  HomePage(
      {super.key,
      required this.data,
      required this.fotos,
      required this.list,
      required this.dropdownValue});

  final List<StudentEntity> data;
  final List<String> fotos;
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final List<String> list;
  final String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderOnForeground: false,
      child: ListView(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
            alignment: Alignment.center,
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: buttonColor, width: 5),
                    borderRadius: BorderRadius.circular(20)),
                child: Image.network(
                    fotos.elementAt(list.indexOf(dropdownValue)))),
          ),
          Card(
            elevation: 5.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                    leading: const Text('Código único',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(data[list.indexOf(dropdownValue)].codigo,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Nome',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(data[list.indexOf(dropdownValue)].nome,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Nome de Guerra',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(data[list.indexOf(dropdownValue)].nomeGuerra,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Número',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(
                        data[list.indexOf(dropdownValue)].numero.toString(),
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('E-mail',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(data[list.indexOf(dropdownValue)].email,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('telefone',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(data[list.indexOf(dropdownValue)].telefone,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Data de Nascimento',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(data[list.indexOf(dropdownValue)].nascimento,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('CPF',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(
                        data[list.indexOf(dropdownValue)].cpf.toString(),
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Identidade',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(
                        data[list.indexOf(dropdownValue)].identidade.toString(),
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Nacionalidade',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(
                        data[list.indexOf(dropdownValue)].nacionalidade,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('UF',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(data[list.indexOf(dropdownValue)].uf,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Naturalidade',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(
                        data[list.indexOf(dropdownValue)].naturalidade,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Raça/Cor/Etnia',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(data[list.indexOf(dropdownValue)].cor,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Sexo',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(data[list.indexOf(dropdownValue)].sexo,
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Aluno órfão',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(
                        data[list.indexOf(dropdownValue)].orphan
                            ? "Sim"
                            : "Não",
                        style: const TextStyle(fontSize: 16))),
                ListTile(
                    leading: const Text('Aluno especial',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    trailing: Text(
                        data[list.indexOf(dropdownValue)].especial
                            ? "Sim"
                            : "Não",
                        style: const TextStyle(fontSize: 16))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
