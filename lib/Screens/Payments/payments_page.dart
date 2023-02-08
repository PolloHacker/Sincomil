import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sincomil/Screens/Payments/print_pdf_page.dart';
import 'package:sincomil/Widgets/Commons/expandable_list_tile.dart';

import '../../Classes/Parent/payments_entity.dart';
import '../../Classes/Student/student_entity.dart';
import '../../Constants/constants.dart';

class PaymentsPage extends StatefulWidget {
  final List<StudentEntity> data;
  final List<PaymentsEntity> payments;
  final String dropdownValue;
  final List<String> list;
  const PaymentsPage(
      {super.key, required this.data, required this.payments, required this.dropdownValue, required this.list});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  String mensalidadeValue = 'Selecione';
  String sitPg = 'Todos';
  List<PaymentsEntity> rows = [];

  @override
  void initState() {
    super.initState();
    mensalidadeValue = tipoMens[0];
    sitPg = situacaoPagamento[0];
  }

  @override
  Widget build(BuildContext context) {
    rows = getCount();
    return Material(
        elevation: 0,
        borderOnForeground: false,
        child: ListView.builder(
            itemCount: rows.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(flex: 1),
                        DropdownButton(
                          value: mensalidadeValue,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Theme.of(context)
                                .elevatedButtonTheme
                                .style
                                ?.foregroundColor
                                ?.resolve({MaterialState.pressed}),
                          ),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              mensalidadeValue = value!;
                            });
                          },
                          items: tipoMens.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const Spacer(flex: 2),
                        DropdownButton(
                            value: sitPg,
                            icon: const Icon(Icons.arrow_drop_down_rounded),
                            elevation: 16,
                            underline: Container(
                              height: 2,
                              color: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.foregroundColor
                                  ?.resolve({MaterialState.pressed}),
                            ),
                            items: situacaoPagamento.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                sitPg = value!;
                              });
                            }),
                        const Spacer(flex: 1),
                      ],
                    )
                  ],
                );
              } else {
                final payment =
                    widget.payments.where((element) => element.aluno == widget.dropdownValue).toList()[index - 1];
                return ExpandableListTile(
                    title: Text(payment.aluno, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    subtitle: Text('Referente à mensalidade ${payment.mensalidade}', style: const TextStyle(fontSize: 16)),
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: getChildren(index - 1, rows),
                      ),
                    ));
              }
            }));
  }

  List<PaymentsEntity> getCount() {
    List<PaymentsEntity> filteredPayments =
        widget.payments.where((element) => element.aluno == widget.dropdownValue).toList();

    if (mensalidadeValue != tipoMens[0]) {
      filteredPayments = filteredPayments.where((element) => element.tipo == mensalidadeValue).toList();
    }

    if (sitPg == situacaoPagamento[1]) {
      filteredPayments = filteredPayments.where((element) => element.valorPg != '-').toList();
    } else if (sitPg == situacaoPagamento[2]) {
      final formatter = DateFormat('dd/MM/yyyy');
      filteredPayments = filteredPayments
          .where((element) =>
              element.dtPagamento != '-' &&
              formatter.parse(element.dtPagamento).isAfter(formatter.parse(element.vencimento)))
          .toList();
    } else if (sitPg == situacaoPagamento[3]) {
      filteredPayments = filteredPayments.where((element) => element.valorPg == '-').toList();
    }
    return filteredPayments;
  }

  List<Widget> getChildren(int index, List<PaymentsEntity> rows) {
    final actions = rows[index].asMap().entries.skip(2).map((e) {
      return Row(
        children: [
          Text(titulos[e.key], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(e.value, style: const TextStyle(fontSize: 18))
        ],
      );
    }).toList();

    actions.add(Row(
      children: [
        const Spacer(flex: 1),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PdfPreviewPage(
                      title: rows[index].mensalidade, tipo: rows[index].tipo, aluno: rows[index].aluno)));
            },
            icon: const Icon(Icons.print)),
        const Spacer(flex: 2),
        IconButton(onPressed: () {}, icon: const Icon(Icons.list_alt_rounded)),
        const Spacer(flex: 1),
      ],
    ));
    return actions;
  }
}
