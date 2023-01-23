import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Classes/parent.dart';
import '../Classes/student.dart';
import '../Constants/phones.dart';
import '../Widgets/expandable_list_tile.dart';

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
          itemCount: cmrj.length,
          itemBuilder: (context, index) {
            return ExpandableListTile(
              title: cmrj.entries.map((e) => Text(e.key)).toList()[index],
                child: Column(
                  children: cmrj.entries.map((i) =>
                      i.value.asMap().entries.map((e) =>
                          ListTile(title: Text(e.value),
                            trailing: IconButton(
                              onPressed: () {
                                if (e.value.contains("@")) {
                                  launchUrl(Uri.parse("mailto:${e.value}"));
                                } else {
                                  launchUrl(Uri.parse("tel:${e.value}"));
                                }
                              },
                              icon: Icon(e.value.contains("@") ? Icons.email_rounded : Icons.phone_rounded)
                            ),)
                      ).toList()
                  ).toList()[index],
                ));
          }),
    );
  }
}
