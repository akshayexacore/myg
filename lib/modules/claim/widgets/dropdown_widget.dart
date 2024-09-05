import 'package:bounce/bounce.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget({super.key, required this.onChanged, required this.selectedClass, required this.items, this.hint = 'Class'});
  final ValueChanged<CategoryClass> onChanged;
  CategoryClass? selectedClass;
  final List<CategoryClass> items;
  final String hint;
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
    return DropdownButtonFormField2(
      decoration: dropdownDecoration.copyWith(contentPadding: const EdgeInsets.symmetric(horizontal: 16),focusColor: Colors.white,prefixIconConstraints:
      BoxConstraints.tight(
          const Size(2, 0)),
        prefixIcon: Container(
          width: 0,
        ),),
      validator: (value) {
        if (value == null) {
          return 'This is a mandatory field';
        }
        return null; // Valid input
      },
      hint: ts(widget.hint, Colors.grey.shade400),
      // Initial Value
      value: widget.selectedClass,
      isExpanded: false,
      buttonStyleData: const ButtonStyleData(
          decoration: BoxDecoration(
              borderRadius:   BorderRadius.all(Radius.circular(10)),
              color: Colors.white
          ),
          padding: EdgeInsets.symmetric(horizontal: 0),
          elevation: 0,
          overlayColor: WidgetStatePropertyAll(Colors.white)
      ),
      dropdownStyleData: const DropdownStyleData(
        decoration: BoxDecoration(
            borderRadius:   BorderRadius.all(Radius.circular(10)),
            color: Colors.white
        ),
      ),
      iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Icon(Icons.arrow_forward_ios_rounded,
              size: 13,color: Colors.black.withOpacity(0.6),),
          ),
          iconSize: 13
      ),
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
