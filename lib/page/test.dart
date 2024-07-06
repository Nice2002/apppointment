import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  DateTime? _startDate;
  DateTime? _endDate;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      _startDate = (args.value as PickerDateRange).startDate;
      _endDate = (args.value as PickerDateRange).endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final minSelectableDate = today.add(Duration(days: 3));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: SfDateRangePicker(
          onSelectionChanged: _onSelectionChanged,
          // selectionMode: DateRangePickerSelectionMode.range,
          minDate: minSelectableDate,
        ),
      ),
    );
  }
}
