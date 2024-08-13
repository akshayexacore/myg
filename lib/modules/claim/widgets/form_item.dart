import 'package:flutter/material.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/modules/claim/widgets/count_widget.dart';
import 'package:travel_claim/modules/claim/widgets/date_picker.dart';
import 'package:travel_claim/modules/claim/widgets/dropdown_widget.dart';
import 'package:travel_claim/modules/claim/widgets/employee_selector.dart';
import 'package:travel_claim/modules/claim/widgets/file_picker.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/textInputField.dart';

import '../../../views/style/colors.dart';

class FormItem extends StatefulWidget {
  final Category category;
  final int index;
  ClaimFormData formData;
  final VoidCallback? onDelete;

  FormItem(
      {super.key,
      required this.category,
      required this.formData,
      required this.index,
      this.onDelete});

  @override
  State<FormItem> createState() => _FormItemState();
}

class _FormItemState extends State<FormItem> {

  TextEditingController textEditingControllerFrom = TextEditingController();
  TextEditingController textEditingControllerTo = TextEditingController();
  TextEditingController textEditingControllerOdoMeterFrom = TextEditingController();
  TextEditingController textEditingControllerOdoMeterTo = TextEditingController();
  TextEditingController textEditingControllerRemarks = TextEditingController();
  TextEditingController textEditingControllerAmount = TextEditingController();

  @override
  void initState() {
    textEditingControllerFrom.text = widget.formData.tripFrom ?? '';
    textEditingControllerTo.text = widget.formData.tripTo ?? '';
    textEditingControllerOdoMeterFrom.text = widget.formData.odoMeterStart ?? '';
    textEditingControllerOdoMeterTo.text = widget.formData.odoMeterEnd ?? '';
    textEditingControllerRemarks.text = widget.formData.remarks ?? '';
    textEditingControllerAmount.text = (widget.formData.amount ?? '').toString();
    widget.formData.fromDate ??= DateTime.now();
    if(widget.formData.toDate==null && widget.category.hasToDate){
      widget.formData.toDate = DateTime.now();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ts("${widget.index}.${widget.category.name} details", primaryColor,
                weight: FontWeight.w500),
            if (widget.onDelete != null)
              TextButton(
                  onPressed: widget.onDelete, child: ts("Remove", Colors.black))
          ],
        ),
        const Divider(),
        gapHC(10),
        if (widget.category.hasTripFrom) ts("From", Colors.black),
        if (widget.category.hasTripFrom) gapHC(3),
        if (widget.category.hasTripFrom)
           TextinputfieldContainer(
              showIcon: false,
              verticalPadding: 6,
              maxline: 1,
              controller: textEditingControllerFrom,
              textInputAction: TextInputAction.done,
              hintText: "From",
              onchange: (val) {
                widget.formData.tripFrom = val;
              },
               validate: (value) {
                 if (value == null|| value.isEmpty) {
                   return 'This is a mandatory field';
                 }
                 return null; // Valid input
               },
              isEnable: true,
              isObscure: false),
        if (widget.category.hasTripTo) gapHC(10),
        if (widget.category.hasTripTo) ts("To", Colors.black),
        if (widget.category.hasTripTo) gapHC(3),
        if (widget.category.hasTripTo)
           TextinputfieldContainer(
              showIcon: false,
              verticalPadding: 6,
              maxline: 1,
              controller: textEditingControllerTo,
              textInputAction: TextInputAction.done,
               validate: (value) {
                 if (value == null|| value.isEmpty) {
                   return 'This is a mandatory field';
                 }
                 return null; // Valid input
               },
              onchange: (val) {
                widget.formData.tripTo = val;
              },
              hintText: "To",
              isEnable: true,
              isObscure: false),
        if (widget.category.hasStartMeter || widget.category.hasEndMeter)
          odooMeterReading(),
        gapHC(10),
        buildDates(context),
        gapHC(10),
        buildUserCount(),
        gapHC(10),
        buildClass(),
        gapHC(10),
        ts("Remarks", Colors.black),
        gapHC(3),
        TextinputfieldContainer(
            showIcon: false,
            verticalPadding: 6,
            maxline: 3,
            controller: textEditingControllerRemarks,
            textInputAction: TextInputAction.done,
            onchange: (val) {
              widget.formData.remarks = val;
            },
            hintText: "Enter your remarks",
            isEnable: true,
            isObscure: false),
        gapHC(10),
        ts("Amount", Colors.black),
        gapHC(3),
        TextinputfieldContainer(
            showIcon: false,
            maxline: 1,
            controller: textEditingControllerAmount,
            textInputAction: TextInputAction.done,
            hintText: "Amount",
            validate: (value) {
              if (value == null || value.isEmpty || value=="0.0" || value =="0") {
                return 'This is a mandatory field';
              }
              return null; // Valid input
            },
            keybordType: TextInputType.number,
            inputFormattor: mfnInputDecFormatters(),
            onchange: (val) {
              widget.formData.amount = double.tryParse(val) ?? 0;
            },
            isEnable: true,
            isObscure: false),
        gapHC(10),
        FilePicker(onChanged: (list){
          widget.formData.files = list;
        },selectedFiles: widget.formData.files.isEmpty ? [] : widget.formData.files,)

      ],
    );
  }

  Widget odooMeterReading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.category.hasStartMeter)
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ts("Odometer reading before", Colors.black),
                gapHC(3),
                TextinputfieldContainer(
                    showIcon: false,
                    boxRadiusColor: primaryColor,
                    verticalPadding: 6,
                    maxline: 1,
                    controller: textEditingControllerOdoMeterFrom,
                    textInputAction: TextInputAction.done,
                    onchange: (val) {
                      widget.formData.odoMeterStart = val;
                    },
                    validate: (value) {
                      if (value == null|| value.isEmpty) {
                        return 'This is a mandatory field';
                      }
                      return null; // Valid input
                    },
                    hintText: "",
                    isEnable: true,
                    isObscure: false),
              ],
            ),
          ),
        if (widget.category.hasEndMeter) gapWC(20),
        if (widget.category.hasEndMeter)
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ts("Odometer reading after", Colors.black),
                gapHC(3),
                TextinputfieldContainer(
                    showIcon: false,
                    boxRadiusColor: primaryColor,
                    verticalPadding: 6,
                    maxline: 1,
                    controller: textEditingControllerOdoMeterTo,
                    textInputAction: TextInputAction.done,
                    onchange: (val) {
                      widget.formData.odoMeterEnd = val;
                    },
                    validate: (value) {
                      if (value == null|| value.isEmpty) {
                        return 'This is a mandatory field';
                      }
                      return null; // Valid input
                    },
                    hintText: "",
                    isEnable: true,
                    isObscure: false),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildDates(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DatePicker(
          title: widget.category.hasFromDate ? "Check-In" : "Date",
          selectedDate: widget.formData.fromDate,
          onChanged: (date) {
            widget.formData.fromDate = date;
          },
        ),
        if (widget.category.hasToDate)
          DatePicker(
            title: widget.category.hasFromDate ? "Check-Out" : "Date",
            selectedDate: widget.formData.toDate,
            onChanged: (date) {
              widget.formData.toDate = date;
            },
          ),
      ],
    );
  }

  Widget buildUserCount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tcustom("Number of employee", Colors.black, 14.0, FontWeight.w500),
        gapHC(3),
        CountWidget(count: (widget.formData.noOfEmployees ?? 1).toString(),onChanged: (value) {
          setState(() {
            widget.formData.noOfEmployees = int.tryParse(value) ?? 1;
          });
        }),
        if (widget.formData.noOfEmployees > 1)
          gapHC(12),
        if (widget.formData.noOfEmployees > 1)
          EmployeeSelector(maxSelection: widget.formData.noOfEmployees - 1,onChanged: (list){
            widget.formData.employees = list;
            print(list.length);
          },items: widget.formData.employees.isNotEmpty ? widget.formData.employees : [],)
      ],
    );
  }

  Widget buildClass() {
    return widget.category.classes != null &&
            widget.category.classes!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ts("Class", Colors.black),
              gapHC(3),
              DropDownWidget(
                selectedClass: widget.formData.selectedClass,
                items: widget.category.classes!,
                onChanged: (value) {
                  widget.formData.selectedClass = value;
                  widget.formData.classId = value.id;
                  widget.formData.policyId = value.policy?.id;
                },
              )
            ],
          )
        : const SizedBox.shrink();
  }
}
