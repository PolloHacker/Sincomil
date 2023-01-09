import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/constants.dart';
import '../Provider/app_settings.dart';

class PortraitCard extends StatefulWidget {
  const PortraitCard(
      {super.key,
      required this.dropdownValue,
      required this.cards,
      required this.selected,
      required this.expanded});
  final String dropdownValue;
  final List<String> cards;
  final List<bool> selected;
  final List<bool> expanded;

  @override
  State<PortraitCard> createState() => _PortraitCardState();
}

class _PortraitCardState extends State<PortraitCard> {
  void _changeIndex(int index, String nome) {
    final settings = Provider.of<AppSettings>(context, listen: false);
    settings.changeIndex(index, nome);
  }

  void _changePortrait(String portrait, String nome) {
    final settings = Provider.of<AppSettings>(context, listen: false);
    settings.changePortrait(portrait, nome);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: allCards
          .asMap()
          .entries
          .map((e) => GestureDetector(
                onTap: () {
                  if (widget.cards.contains(e.value.name)) {
                    _changeIndex(e.key, widget.dropdownValue);
                    setState(() {
                      widget.selected[e.key] = !widget.selected[e.key];
                      for (var i = 0; i < widget.selected.length; i++) {
                        if (e.key != i) {
                          widget.selected[i] = false;
                        }
                      }
                    });
                    _changePortrait(e.value.name, widget.dropdownValue);
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Você não possui esta carta.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                onLongPress: () {
                  setState(() {
                    widget.expanded[e.key] = !widget.expanded[e.key];
                    for (var i = 0; i < widget.expanded.length; i++) {
                      if (e.key != i) {
                        widget.expanded[i] = false;
                      }
                    }
                  });
                },
                child: AnimatedSwitcher(
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    duration: const Duration(milliseconds: 800),
                    child: widget.cards.contains(e.value.name)
                        ? widget.selected[e.key]
                            ? widget.expanded[e.key]
                                ? Card(
                                    key: UniqueKey(),
                                    elevation: 10,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.asset('assets/images/Cartinhas/${e.value.name}.png',
                                            width: MediaQuery.sizeOf(context).width * 0.483),
                                        Expanded(child: Text(e.value.description, textAlign: TextAlign.center))
                                      ],
                                    ))
                                : Card(
                                    key: UniqueKey(),
                                    elevation: 10,
                                    child: Image.asset('assets/images/Cartinhas/${e.value.name}.png',
                                        width: MediaQuery.sizeOf(context).width * 0.483),
                                  )
                            : widget.expanded[e.key]
                                ? Card(
                                    key: UniqueKey(),
                                    elevation: 0,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.asset('assets/images/Cartinhas/${e.value.name}.png',
                                            width: MediaQuery.sizeOf(context).width * 0.483),
                                        Expanded(child: Text(e.value.description, textAlign: TextAlign.center))
                                      ],
                                    ))
                                : Card(
                                    key: UniqueKey(),
                                    elevation: 0,
                                    child: Image.asset('assets/images/Cartinhas/${e.value.name}.png',
                                        width: MediaQuery.sizeOf(context).width * 0.483),
                                  )
                        : widget.expanded[e.key]
                            ? Card(
                                key: UniqueKey(),
                                elevation: 0,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Stack(
                                      children: [
                                        Image.asset('assets/images/Cartinhas/${e.value.name}.png',
                                            width: MediaQuery.sizeOf(context).width * 0.483),
                                        Positioned.fill(
                                            child: ClipRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                            child: Container(
                                              decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                                              child: Container(),
                                            ),
                                          ),
                                        ))
                                      ],
                                    ),
                                    Expanded(child: Text(e.value.description, textAlign: TextAlign.center))
                                  ],
                                ),
                              )
                            : Card(
                                key: UniqueKey(),
                                elevation: 0,
                                child: Stack(
                                  children: [
                                    Image.asset('assets/images/Cartinhas/${e.value.name}.png',
                                        width: MediaQuery.sizeOf(context).width * 0.483),
                                    Positioned.fill(
                                        child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                        child: Container(
                                          decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.5)),
                                          child: Container(),
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              )),
              ))
          .toList(),
    );
  }
}
