import 'package:flutter/material.dart';
import 'package:travel_claim/views/style/colors.dart';

class SelectTag extends StatelessWidget {
  const SelectTag({
    super.key,
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;
  final Color darkAlias6 = const Color.fromRGBO(36, 37, 51, 0.06);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: primaryColor,
      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: primaryColor)),
      labelPadding: const EdgeInsets.only(left: 4.0,top: 0,bottom: 0,right: 6),
      label: Text(label,style: TextStyle(color: Colors.white,fontSize: 12),),
      deleteIcon: const CircleAvatar(
        radius: 10,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.close,
          size: 18,
          color: primaryColor,
        ),
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}