import 'package:flutter/material.dart';

class ExpandableListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const ExpandableListTile({super.key, required this.title, required this.subtitle, required this.child});

  @override
  State<ExpandableListTile> createState() => _ExpandableListTileState();
}

class _ExpandableListTileState extends State<ExpandableListTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: ListTile(
          title: Text(widget.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          subtitle: Text(widget.subtitle, style: const TextStyle(fontSize: 16)),
        ),
        children: [
          widget.child,
        ]);
  }
}
