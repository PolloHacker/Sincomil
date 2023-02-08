import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.callback});
  final Function callback;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController dateController = TextEditingController();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String selectedDate = '';


  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      selectedDate = args.value.toString();
      widget.callback(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_month_rounded),
                  labelText: 'Data de Nascimento'),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          insetPadding: const EdgeInsets.all(20),
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: Material(
                                elevation: 0,
                                borderRadius: BorderRadius.circular(10),
                                child: SfDateRangePicker(
                                  showActionButtons: true,
                                  confirmText: 'Confirmar',
                                  cancelText: 'Cancelar',
                                  onSelectionChanged: _onSelectionChanged,
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                  initialSelectedDate: DateTime.now(),
                                  onCancel: () =>
                                      Navigator.of(context).pop('Cancel'),
                                  onSubmit: (object) {
                                    setState(() {
                                      dateController.text = formatter.format(
                                          DateTime.parse(object.toString()));
                                    });
                                    Navigator.of(context).pop('Submit');
                                  },
                                ),
                              )),
                        ));
              },
            )
          ],
        ));
  }
}
