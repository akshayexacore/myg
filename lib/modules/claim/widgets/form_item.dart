
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/modules/claim/widgets/count_widget.dart';
import 'package:travel_claim/modules/claim/widgets/date_picker.dart';
import 'package:travel_claim/modules/claim/widgets/dropdown_widget.dart';
import 'package:travel_claim/modules/claim/widgets/employee_selector.dart';
import 'package:travel_claim/modules/claim/widgets/file_picker.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/resources/myg_repository.dart';
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
  TextEditingController textEditingControllerOdoMeterFrom =
      TextEditingController();
  TextEditingController textEditingControllerOdoMeterTo =
      TextEditingController();
  TextEditingController textEditingControllerRemarks = TextEditingController();
  TextEditingController textEditingControllerAmount = TextEditingController();

  var isUpdated = false.obs;
  var eligibleAmount = 0.0.obs;
  var max = 0.0.obs;
  var totalKms = 0.0.obs;

  @override
  void initState() {

    //Logger().i(widget.formData.toJson());
    textEditingControllerFrom.text = widget.formData.tripFrom ?? '';
    textEditingControllerTo.text = widget.formData.tripTo ?? '';
    textEditingControllerOdoMeterFrom.text =
        widget.formData.odoMeterStart ?? '';
    textEditingControllerOdoMeterTo.text = widget.formData.odoMeterEnd ?? '';
    textEditingControllerRemarks.text = widget.formData.remarks ?? '';
    textEditingControllerAmount.text =
        (widget.formData.amount==0 || widget.formData.amount== null ? '' : widget.formData.amount!.toStringAsFixed(2)).toString();
    widget.formData.fromDate ??= DateTime.now();
    if (widget.formData.toDate == null && widget.category.hasToDate) {
      widget.formData.toDate = DateTime.now();
    }

    if(widget.category.classes!=null && widget.category.classes!.length == 1 && !widget.category.hasClass && widget.formData.selectedClass == null){
      widget.formData.selectedClass = widget.category.classes!.first;
      widget.formData.classId = widget.category.classes!.first.id;
      widget.formData.policyId = widget.category.classes!.first.policy?.id;
    }

    if(widget.formData.selectedClass!=null){
      print('grade from draft: ${widget.category.classes!.first.policy?.gradeAmount}');
      eligibleAmount(widget.category.classes!.first.policy?.gradeAmount);
      widget.formData.eligibleAmount = eligibleAmount.value;
      max.value = eligibleAmount.value;
      isUpdated.toggle();
    }

    if(widget.formData.employees.isNotEmpty){
      widget.formData.employees.removeWhere((element) => element.id == Get.find<ProfileController>().user.value.id,);
      calculateClass();
    }

    isUpdated.listen((p0) {
      print('amount: ${widget.formData.selectedClass?.policy?.gradeAmount}');
      if (widget.formData.selectedClass != null &&
          widget.formData.selectedClass?.policy?.gradeAmount != null &&
          widget.formData.amount != null) {
        print('amount: ${eligibleAmount.value}');
        max.value = eligibleAmount.value;
        totalKms.value = 0;
        if (widget.category.hasStartMeter) {
          double start =
              double.tryParse(widget.formData.odoMeterStart ?? '0') ?? 0;
          double end =
              double.tryParse(widget.formData.odoMeterEnd ?? '0') ?? 0;
          if (start == 0 && end == 0) {
            return;
          }

          if(start>=0 && end>0) {
            totalKms.value = end - start;

            max.value = totalKms.value *
                widget.formData.selectedClass!.policy!.gradeAmount!;

            if(mounted) {
              textEditingControllerAmount.text = max.toStringAsFixed(2);
            }
            widget.formData.amount = max.value;
          }
        }
    }},);

    eligibleAmount.listen((p0) {
      widget.formData.eligibleAmount = eligibleAmount.value;
    },);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    return Column(
      key: widget.formData.formKey,
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
                if (value == null || value.isEmpty) {
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
                if (value == null || value.isEmpty) {
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
            hintText: "Enter amount",
            validate: (value) {
              if (value == null ||
                  value.isEmpty ||
                  value == "0.0" ||
                  value == "0") {
                return 'This is a mandatory field';
              }
              return null; // Valid input
            },
            keybordType: TextInputType.number,
            inputFormattor: mfnInputDecFormatters(),
            onEditingComplete: (){
              final text = textEditingControllerAmount.text;
              if (text.isNotEmpty) {
                final double? value = double.tryParse(text);
                if (value != null) {
                  textEditingControllerAmount.text = value.toStringAsFixed(2);
                }
              }
              FocusScope.of(context).unfocus();
            },
            onchange: (val) {
              widget.formData.amount = double.tryParse(val) ?? 0;
              isUpdated.toggle();
            },
            isEnable: widget.category.hasStartMeter ? false : true,
            isObscure: false),
        Obx(() {
          debugPrint(isUpdated.value.toString()); // do not remove
          if (widget.formData.selectedClass != null &&
              widget.formData.selectedClass?.policy?.gradeAmount != null &&
              widget.formData.amount != null && !widget.category.hasStartMeter) {

            if (widget.formData.amount! > max.value) {
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "(Eligible amount ${max.value.toStringAsFixed(2)} INR ${widget.category.hasStartMeter ? 'for ${totalKms.value} Kms @ ${widget.formData.selectedClass!.policy!.gradeAmount!} INR/Km' : ''})",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          }
          return const SizedBox.shrink();
        }),
        gapHC(12),
        FilePicker(
          onChanged: (list) {
            widget.formData.files = list;
            widget.formData.fileError = '';
          },
          selectedFiles:
              widget.formData.files.isEmpty ? [] : widget.formData.files,
          errorMsg: widget.formData.fileError,
        )
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
                ts("Odometer reading beforedddd", Colors.black),
                gapHC(3),
                TextinputfieldContainer(
                    showIcon: false,
                    boxRadiusColor: primaryColor,
                    verticalPadding: 6,
                    maxline: 1,
                    controller: textEditingControllerOdoMeterFrom,
                    textInputAction: TextInputAction.done,
                    keybordType: TextInputType.number,
                    suffix: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Km",style: TextStyle(color: Colors.black54),),
                      ],
                    ),
                    onchange: (val) {
                      widget.formData.odoMeterStart = val;
                      isUpdated.toggle();
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This is a mandatory field';
                      }
                      return null; // Valid input
                    },
                    hintText: "Enter reading",
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
                    suffix: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Km",style: TextStyle(color: Colors.black54),),
                      ],
                    ),
                    keybordType: TextInputType.number,
                    controller: textEditingControllerOdoMeterTo,
                    textInputAction: TextInputAction.done,
                    onchange: (val) {
                      widget.formData.odoMeterEnd = val;
                      isUpdated.toggle();
                    },
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This is a mandatory field';
                      }
                      return null; // Valid input
                    },
                    hintText: "Enter reading",
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
          title: widget.category.hasFromDate ? "Check-in date" : "Date",
          selectedDate: widget.formData.fromDate,
          lastDate: DateTime.now().subtract(Duration(days: widget.category.noOfDays)),
          onChanged: (date) {
            widget.formData.fromDate = date;
          },
        ),
        if (widget.category.hasToDate)
          DatePicker(
            title: widget.category.hasFromDate ? "Check-out date" : "Date",
            selectedDate: widget.formData.toDate,
            lastDate: DateTime.now().subtract(Duration(days: widget.category.noOfDays)),
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
        CountWidget(
            count: (widget.formData.noOfEmployees ?? 1).toString(),
            onChanged: (value) {
              setState(() {
                widget.formData.noOfEmployees = int.tryParse(value) ?? 1;

                if((widget.formData.noOfEmployees - 1)<widget.formData.employees.length){
                  widget.formData.employees.removeLast();
                  if(widget.formData.employees.isNotEmpty){
                    calculateClass();
                  }else{
                      eligibleAmount(widget.formData.selectedClass?.policy?.gradeAmount);
                  }
                  isUpdated.toggle();
                }
                print('employee: ${widget.formData.noOfEmployees}');
              });
            }),
        if (widget.formData.noOfEmployees > 1) gapHC(12),
        if (widget.formData.noOfEmployees > 1)
          EmployeeSelector(
            maxSelection: widget.formData.noOfEmployees - 1,
            onChanged: (list) {
              widget.formData.employees = list;
              if(!widget.category.hasStartMeter && widget.formData.employees.isNotEmpty) {
                calculateClass();
              }

              if(list.isEmpty){
                eligibleAmount(widget.formData.selectedClass?.policy?.gradeAmount);
              }
              print(list.length);
            },
            items: widget.formData.employees.isNotEmpty
                ? widget.formData.employees
                : [],
          )
      ],
    );
  }

  Widget buildClass() {
    return widget.category.hasClass
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ts(widget.category.name.toLowerCase().contains('fuel')? 'Vehicle type' : "Class", Colors.black),
              gapHC(3),
              DropDownWidget(
                selectedClass: widget.formData.selectedClass,
                hint: widget.category.name.toLowerCase().contains('fuel')? 'Select Vehicle type' : "Select Class",
                items: widget.category.classes!,
                onChanged: (value) {
                  widget.formData.selectedClass = value;
                  widget.formData.classId = value.id;
                  widget.formData.policyId = value.policy?.id;
                  if(widget.formData.employees.isEmpty){
                    eligibleAmount(value.policy?.gradeAmount);
                  }
                  isUpdated.toggle();
                },
              )
            ],
          )
        : const SizedBox.shrink();
  }

  void calculateClass() async {
    try {
      var body = {
        'category_id': widget.category.id,
        'grade_ids': [Get.find<ProfileController>().user.value.grade,...widget.formData.employees.map((e) => e.grade,)]
      };
      var response = await MygRepository().getClassCalculation(body: body);
      if (response.success) {
        eligibleAmount.value = response.amount;
        widget.formData.eligibleAmount = response.amount;
        isUpdated.toggle();
      }
    }catch(_){
      print(_.toString());
    }
  }
}
