import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Classes/parent.dart';
import '../Classes/student.dart';
import '../Constants/phones.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key, required this.parent, required this.students});
  final Parent parent;
  final List<Student> students;

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajuda"),
      ),
      body: ListView.builder(
          //TODO: add support for other schools
          itemCount: cmbh.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: cmbh.entries.map((e) => Text(e.key)).toList()[index],
              subtitle: cmbh.entries.map((e) {
                if (e.value.length > 1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: e.value.map((e) => Text(e)).toList(),
                  );
                } else {
                  return Text(e.value.first);
                }
              }).toList()[index],
              trailing: IconButton(
                onPressed: () {
                  final entry = cmbh.entries.map((e) => e.value).toList()[index];
                  String tel = '';
                  if (entry.length > 1) {
                    showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                              icon: const Icon(Icons.warning_rounded),
                              title: const Text("Selecione um número para ligar",
                                  textAlign: TextAlign.center),
                              content: const Text("Clique fora do diálogo para cancelar",
                                  textAlign: TextAlign.center),
                              actions: <Widget>[
                                //TODO: handle DDD
                                Row(
                                  children: [
                                    const Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          tel = entry[0];
                                          launchUrl(Uri.parse("tel:+55(31)$tel"));
                                        },
                                        child: Row(
                                          children: [const Icon(Icons.call_rounded), Text(entry[0])],
                                        )),
                                    const Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          tel = entry[1];
                                          launchUrl(Uri.parse("tel:+55(31)$tel"));
                                        },
                                        child: Row(
                                          children: [const Icon(Icons.call_rounded), Text(entry[1])],
                                        )),
                                    const Spacer(),
                                  ],
                                )
                              ],
                            ));
                  }
                },
                icon: const Icon(Icons.call_rounded),
              ),
            );
          }),
    );
  }
}
