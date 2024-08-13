import 'package:flutter/material.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class DatePicker extends StatefulWidget {
  final String title;
  DateTime? selectedDate;
  final ValueChanged<DateTime> onChanged;
  DatePicker({super.key, required this.title, required this.onChanged,this.selectedDate});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ts(widget.title, Colors.black),
        gapHC(3),
        GestureDetector(
          onTap: () {
            selectDate(context);
          },
          child: Container(
            height: 45,
            width: MediaQuery.sizeOf(context).width * 0.4,
            decoration:
            boxOutlineCustom(Colors.white, 10, Colors.grey.shade400),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ts(
                      setDate(
                          6,
                          widget.selectedDate ?? DateTime.now()),
                      Colors.black),
                  const Icon(
                    Icons.calendar_month,
                    color: primaryColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2023, 1),
        lastDate: DateTime(2050, 8),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != widget.selectedDate) {
      setState(() {
        widget.selectedDate = pickedDate;
      });

      widget.onChanged.call(pickedDate);
    }
  }
}
