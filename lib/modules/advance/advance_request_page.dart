import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:select_searchable_list/select_searchable_list.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/modules/advance/controller/advance_request_controller.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/style/colors.dart';


class AdvanceRequestPage extends StatelessWidget {
  AdvanceRequestPage({Key? key}) : super(key: key);

  static const routeName = '/advance_request';

  final profileController = Get.find<ProfileController>();
  final advanceController = Get.find<AdvanceRequestController>();
  final landingController = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar("Request Advance"),
          body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: SingleChildScrollView(
              child: Form(
                key: advanceController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*ts("Date", Colors.black),
                        gapHC(2),
                        Obx(
                              () => GestureDetector(
                            onTap: () {
                              advanceController.selectFromDate(context);
                            },
                            child: Container(
                              height: 45,
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              decoration: boxOutlineCustom(
                                  Colors.white, 10, Colors.grey.shade400),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ts(
                                        setDate(
                                            6,
                                            advanceController.selectedDate.value
                                            as DateTime),
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
                        ),
                        gapHC(10),*/
                        gapHC(2),
                        ts("Type of trip", Colors.black),
                        gapHC(4),

                        Obx(() => DropdownButtonFormField2<TripType>(
                          decoration: dropdownDecoration.copyWith(contentPadding: const EdgeInsets.symmetric(horizontal: 16),focusColor: Colors.white,prefixIconConstraints:
                          BoxConstraints.tight(
                              const Size(2, 0)),
                            prefixIcon: Container(
                              width: 0,
                            ),),
                          hint: Text("Type of trip", style: hintTextStyle(),),
                          validator: (value) {
                            if (value == null) {
                              return 'This is a mandatory field';
                            }
                            return null; // Valid input
                          },
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
                          value: advanceController.selectedTripType.value,
                          isExpanded: false,
                          iconStyleData: IconStyleData(
                              icon: Padding(
                                padding: const EdgeInsets.only(right: 0),
                                child: Icon(Icons.arrow_forward_ios_rounded,
                                  size: 13,color: Colors.black.withOpacity(0.6),),
                              ),
                              iconSize: 13
                          ),
                          items: landingController.tripTypes.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: ts(
                                e.name,
                                Colors.black,
                              ),
                            );
                          }).toList(),
                          onChanged: (TripType? value) {
                            advanceController.selectedTripType(value);
                          },
                        )),
                        gapHC(10),
                        ts("Branch name", Colors.black),
                        gapHC(2),
                        Obx(() {
                          print(advanceController.isBusy.value.toString());
                          Map<int, String> branchMap = {for (var branch in landingController.branches) branch.id: branch.name};
                          return DropDownTextField(
                            style: const TextStyle(fontSize: 14.0, color: Colors.black,fontWeight: FontWeight.w500),
                            textEditingController: TextEditingController(),
                            title: 'Select branch',
                            decoration: InputDecoration(
                              suffixIcon:  Icon(Icons.arrow_forward_ios_rounded,
                                size: 13,color: Colors.black.withOpacity(0.6),),
                              contentPadding:const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical:0.0
                              ),
                              hintText: "Select branch",
                              hintStyle: hintTextStyle(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:  BorderSide(color: Colors.grey.shade400),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:  const BorderSide(color: primaryColor),
                              ),
                              focusColor: primaryColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:  const BorderSide(color: primaryColor),
                              ),

                            ),
                            hint: 'Select Category',
                            options: branchMap,
                            selectedOptions: advanceController.selectedBranch.value!=null ? [advanceController.selectedBranch.value!.id] : null,
                            multiple: false,
                            onChanged: (selectedIds) {
                              if(selectedIds!=null && selectedIds.isNotEmpty) {
                                advanceController.selectedBranch(landingController.branches.firstWhereOrNull((element) => element.id == selectedIds!.first,));
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This is a mandatory field';
                              }
                              return null;
                            },
                          );
                        }),
                        gapHC(10),
                        ts("Purpose of trip", Colors.black),
                        gapHC(2),
                        Container(
                          child: TextinputfieldContainer(
                              showIcon: false,
                              verticalPadding: 6,
                              textInputAction: TextInputAction.done,
                              controller: advanceController.textEditingControllerPurpose,
                              maxline: 3,
                              hintText: "Enter your purpose",
                              validate: (value) {
                                if (value == null ||
                                    value.isEmpty) {
                                  return 'This is a mandatory field';
                                }
                                return null; // Valid input
                              },
                              isEnable: true,
                              isObscure: false),
                        ),
                        gapHC(10),
                        ts("Remark", Colors.black),
                        gapHC(2),
                        Container(
                          child: TextinputfieldContainer(
                              showIcon: false,
                              verticalPadding: 6,
                              controller: advanceController.textEditingControllerRemarks,
                              maxline: 3,
                              hintText: "Enter your remarks",
                              textInputAction: TextInputAction.done,
                              isEnable: true,
                              isObscure: false),
                        ),

                        gapHC(10),
                        ts("Amount", Colors.black),
                        gapHC(2),
                        TextinputfieldContainer(
                            showIcon: false,
                            maxline: 1,
                            controller: advanceController.textEditingControllerAmount,
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
                              final text = advanceController.textEditingControllerAmount.text;
                              if (text.isNotEmpty) {
                                final double? value = double.tryParse(text);
                                if (value != null) {
                                  advanceController.textEditingControllerAmount.text = value.toStringAsFixed(2);
                                }
                              }
                              FocusScope.of(context).unfocus();
                            },
                            onchange: (val) {

                            },
                            isEnable: true,
                            isObscure: false),
                        gapHC(30),
                        //const Divider(),
                        //gapHC(10),
                        Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Obx((){
                                if (advanceController.isBusy.isTrue) {
                                  return const SpinKitThreeBounce(
                                    color: primaryColor,
                                    size: 20,
                                  );
                                }
                                return Custombutton(onTap: (){
                                  advanceController.save(context);
                                }, buttonName: "Send",
                                    buttonColor: primaryColor, buttonTextColor: Colors.white);
                              }),
                            ),

                          ],
                        )


                      ],
                    ),
                    gapHC(20),
                  ],
                ),
              ),
            ),),
        ));
  }
}
