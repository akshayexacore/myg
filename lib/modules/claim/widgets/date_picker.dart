import 'package:flutter/material.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class DatePicker extends StatefulWidget {
  final String title;
  DateTime? selectedDate;
  DateTime lastDate;
  final ValueChanged<DateTime> onChanged;
  DatePicker({super.key, required this.title, required this.onChanged,this.selectedDate,required this.lastDate});

  @override
  State<DatePicker> createState() => _DatePickerState();
}


class _DatePickerState extends State<DatePicker> {

  @override
  void initState() {
    if(widget.selectedDate!=null){
      if(widget.selectedDate!.isBefore(widget.lastDate)){
        widget.lastDate  = widget.selectedDate!;
      }
    }
    super.initState();
  }
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
                          widget.selectedDate ?? DateTime.now()
                          ),
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
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: primaryColor,
              hintColor: primaryColorLight,
              colorScheme: const ColorScheme.light(primary: primaryColor),
              buttonTheme: const ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child!,
          );
        },
        firstDate: widget.lastDate,
        lastDate: DateTime.now(),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != widget.selectedDate) {
      setState(() {
        widget.selectedDate = pickedDate;
      });

      widget.onChanged.call(pickedDate);
    }
  }
}
