import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sincomil/Screens/Resub/renew_sub_form_page.dart';

import '../../Classes/Parent/parent.dart';
import '../../Classes/Student/student.dart';

class RenewSubPage extends StatefulWidget {
  const RenewSubPage({super.key, required this.parent, required this.data});

  final Parent parent;
  final List<Student> data;

  @override
  State<RenewSubPage> createState() => _RenewSubPageState();
}

class _RenewSubPageState extends State<RenewSubPage> {
  List<String> situation = List.empty(growable: true);

  void callback(Student stu, String value) {
    setState(() {
      situation[widget.data.indexOf(stu)] = value;
    });
  }

  @override
  void initState() {
    if (situation.isEmpty) {
      situation = List.filled(widget.data.length, "TODO");
    }
    // TODO: see if any student has pending requests or is already subscribed
    super.initState();
  }

  //TODO: Implement FutureBuilder to see data on server and return the good results
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Renovação de matrícula'),
      ),
      body: Material(
        elevation: 0,
        borderOnForeground: false,
        child: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (BuildContext context, int index) {
            // TODO: handle student requests
            return ListTile(
              onTap: situation[index] == "TODO"
                  ? () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SlideInUp(
                              child: RenewSubFormPage(
                                  parent: widget.parent, student: widget.data[index], callback: callback))));
                    }
                  : () {},
              title: Text(widget.data[index].nomeGuerra),
              subtitle: situation[index] == "TODO" ? const Text("toque para solicitar") : Container(),
              trailing: Card(
                elevation: 2,
                color: situation[index] == "TODO"
                    ? Colors.orangeAccent
                    : situation[index] == "DOING"
                        ? Colors.lightGreen
                        : Colors.green,
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: situation[index] == "TODO"
                        ? const Text("não solicitado")
                        : situation[index] == "DOING"
                            ? const Text("em andamento")
                            : const Text("rematriculado")),
              ),
            );
          },
        ),
      ),
    );
  }
}
