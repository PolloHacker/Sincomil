import 'package:flutter/material.dart';

class ExpandableListTile extends StatefulWidget {
  final Widget title;
  Widget? subtitle;
  final Widget child;

  ExpandableListTile({super.key, required this.title, this.subtitle, required this.child});

  @override
  State<ExpandableListTile> createState() => _ExpandableListTileState();
}

class _ExpandableListTileState extends State<ExpandableListTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: ListTile(
          title: widget.title,
          subtitle: widget.subtitle,
        ),
        children: [
          widget.child,
        ]);
  }
}
