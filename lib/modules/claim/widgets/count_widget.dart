import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/style/colors.dart';

class CountWidget extends StatefulWidget {
  const CountWidget({super.key, required this.onChanged, required this.count});
  final ValueChanged<String> onChanged;
  final String count;
  @override
  State<CountWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends State<CountWidget> {
  late TextEditingController txtNoOfEmployee;
  @override
  void initState() {
    txtNoOfEmployee = TextEditingController(text: widget.count ?? "1");
    txtNoOfEmployee.addListener(() {
      widget.onChanged.call(txtNoOfEmployee.text);
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Bounce(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            var txtVal = mfnInt(txtNoOfEmployee.text);
            txtVal = txtVal == 1 ? 1 : txtVal - 1;
            txtNoOfEmployee.text = txtVal.toString();
          },
          child: Container(
            height: 45,
            padding: const EdgeInsets.all(12),
            decoration: boxBaseDecorationC(primaryColor, 10, 0.0, 10, 0.0),
            child: const Center(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                )),
          ),
        ),
        gapWC(8),
        Container(
          width: 80,
          child: Center(
            child: TextFormField(
              enabled: true,
              inputFormatters: mfnInputDecFormatters(),
              controller: txtNoOfEmployee,
              textAlign: TextAlign.center,
              // keyboardType:keybordType=="txtKeybrd"?TextInputType.text: TextInputType.number,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                //focusColor:Colors.grey.shade100 ,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.0),
                  borderSide: BorderSide(
                      width: 1, color: Colors.grey.shade300), //<-- SEE HERE
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(1.0),
                  borderSide: BorderSide(
                      width: 1, color: Colors.grey.shade300), //<-- SEE HERE
                ),
              ),
            ),
          ),
        ),
        gapWC(8),
        Bounce(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            txtNoOfEmployee.text =
                (mfnInt(txtNoOfEmployee.text) + 1)
                    .toString();
          },
          child: Container(
            height: 45,
            padding: const EdgeInsets.all(12),
            decoration: boxBaseDecorationC(primaryColor, 0, 10.0, 0, 10.0),
            child: const Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}
