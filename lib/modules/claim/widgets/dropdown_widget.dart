import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget({super.key, required this.onChanged, required this.selectedClass, required this.items});
  final ValueChanged<CategoryClass> onChanged;
  CategoryClass? selectedClass;
  final List<CategoryClass> items;
  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      focusColor: Colors.white,
      dropdownColor: Colors.white,
      decoration: dropdownDecoration,
      validator: (value) {
        if (value == null) {
          return 'This is a mandatory field';
        }
        return null; // Valid input
      },
      hint: ts("Class", Colors.grey.shade400),
      // Initial Value
      value: widget.selectedClass,
      isExpanded: true,
      // Down Arrow Icon
      icon: const Icon(Icons.arrow_forward_ios_rounded,
          size: 13),

      // Array list of items
      items: widget.items
          .map((CategoryClass item) {
        return DropdownMenuItem(
          value: item,
          child: ts(
            item.name,
            Colors.black,
          ),
        );
      }).toList(),
      onChanged: (dynamic value) {
        setState(() {
          widget.selectedClass = value;
          widget.onChanged.call(value);
        });
      },
    );
  }
}
