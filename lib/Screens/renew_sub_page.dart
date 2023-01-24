import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sincomil/Screens/renew_sub_form_page.dart';

import '../Classes/parent.dart';
import '../Classes/student.dart';

class RenewSubPage extends StatefulWidget {
  const RenewSubPage({super.key, required this.parent, required this.data});

  final Parent parent;
  final List<Student> data;

  @override
  State<RenewSubPage> createState() => _RenewSubPageState();
}

class _RenewSubPageState extends State<RenewSubPage> {
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
            //TODO: change color of requirement
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SlideInUp(child: RenewSubFormPage(parent: widget.parent, student: widget.data[index]))));
              },
              title: Text(widget.data[index].nomeGuerra),
              subtitle: const Text("toque para solicitar"),
              trailing: const Card(
                elevation: 2,
                color: Colors.orangeAccent,
                child: Padding(padding: EdgeInsets.all(5), child: Text("não solicitado")),
              ),
            );
          },
        ),
      ),
    );
  }
}
