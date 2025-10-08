import 'package:bounce/bounce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_select_nw/flutter_awesome_select_nw.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:select_searchable_list/select_searchable_list.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/modules/claim/controller/claim_controller.dart';
import 'package:travel_claim/modules/claim/widgets/form_item.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/utils/api_base_helper.dart';
import 'package:travel_claim/views/components/bg.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/components/image_dispalya.ssl.dart';
import 'package:travel_claim/views/components/textInputField.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class ClaimPage extends StatelessWidget {
  ClaimPage({Key? key}) : super(key: key);

  static const routeName = '/claim';

  final profileController = Get.find<ProfileController>();
  final claimController = Get.find<ClaimController>();
  final landingController = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        PenetrableTapRecognizer:
            GestureRecognizerFactoryWithHandlers<PenetrableTapRecognizer>(
          () => PenetrableTapRecognizer(),
          (instance) {
            instance.onTapDown = (_) => _handleGlobalGesture(context);
          },
        ),
      },
      behavior: HitTestBehavior.opaque,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: customAppBar("Add Expenses"),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: claimController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gapHC(28),
                      Container(
                        decoration: boxDecoration(primaryColor, 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ts("Employee ID", Colors.white,
                                      weight: FontWeight.w400),
                                  gapHC(3),
                                  Text(
                                    '${profileController.user.value.name} (${profileController.user.value.employeeId})',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ts("Base Location", Colors.white,
                                    weight: FontWeight.w400),
                                gapHC(3),
                                tssb(
                                  profileController
                                      .user.value.baseLocation?.name,
                                  Colors.white,
                                  FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      gapHC(24),
                      tssb("Claim Form", Colors.black, FontWeight.bold),
                      gapHC(8),
                      const Divider(),
                      gapHC(5),
                      ts("Type of trip", Colors.black),
                      // ts(claimController.selectedTripType.value?.name, Colors.black),
                      // ts(
                      //   landingController.tripTypes.isNotEmpty
                      //       ? landingController.tripTypes
                      //           .map((e) => e.id)
                      //           .join(', ')
                      //       : 'NA',
                      //   Colors.black,
                      // ),
                      gapHC(3),
                      Obx(() => DropdownButtonFormField2<TripType>(
                            //focusColor: Colors.white,
                            //dropdownColor: Colors.white,
                            decoration: dropdownDecoration.copyWith(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              focusColor: Colors.white,
                              prefixIconConstraints:
                                  BoxConstraints.tight(const Size(2, 0)),
                              prefixIcon: Container(
                                width: 0,
                              ),
                            ),
                            hint: Text(
                              "Type of trip",
                              style: hintTextStyle(),
                            ),
                            alignment: Alignment.centerLeft,
                            validator: (value) {
                              if (value == null) {
                                return 'This is a mandatory field';
                              }
                              return null; // Valid input
                            },
                            //underline: const SizedBox(),
                            buttonStyleData: const ButtonStyleData(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                elevation: 0,
                                overlayColor:
                                    WidgetStatePropertyAll(Colors.white)),
                            dropdownStyleData: const DropdownStyleData(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white),
                            ),
                            // Initial Value
                            value: landingController.tripTypes.contains(
                                    claimController.selectedTripType.value)
                                ? claimController.selectedTripType.value
                                : null,
                            isExpanded: false,
                            // Down Arrow Icon
                            iconStyleData: IconStyleData(
                                icon: Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 13,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                                iconSize: 13),
                            // Array list of items
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
                              debugPrint(value?.id.toString()??"");
                              claimController.selectedTripType(value);
                            },
                          )),
                      gapHC(15),
                      ts("Branch name", Colors.black),
                      gapHC(3),
                      Obx(() {
                        print(claimController.isBusy.value.toString());
                        Map<int, String> branchMap = {
                          for (var branch in landingController.branches)
                            branch.id: branch.name
                        };
                        return DropDownTextField(
                          style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          textEditingController: TextEditingController(),
                          title: 'Select branch',
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 13,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0.0),
                            hintText: "Select branch",
                            hintStyle: hintTextStyle(),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: primaryColor),
                            ),
                            focusColor: primaryColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: primaryColor),
                            ),
                          ),
                          hint: 'Select Category',
                          options: branchMap,
                          selectedOptions:
                              claimController.selectedBranch.isNotEmpty
                                  ? claimController.selectedBranch
                                      .map((e) => e.id)
                                      .toList()
                                  : null,
                          multiple: true,
                          onChanged: (selectedIds) {
                            debugPrint("ssssssssssss");
                            if (selectedIds != null && selectedIds.isNotEmpty) {
                              final matchedBranches =
                                  landingController.branches.where(
                                (branch) => selectedIds!.contains(branch.id),
                              );

                              claimController.selectedBranch.addAll(
                                matchedBranches.where(
                                  (branch) => !claimController.selectedBranch
                                      .any((b) => b.id == branch.id),
                                ),
                              );
                            }
                            // if (selectedIds != null && selectedIds.isNotEmpty) {
                            //   claimController.selectedBranch(selectedIds);

                            //   // claimController.selectedBranch(
                            //   //     landingController.branches.firstWhereOrNull(
                            //   //   (element) => element.id == selectedIds!.first,
                            //   // ));
                            // }
                          },
                          validator: (value) {
                            if (claimController.selectedTripType.value?.name
                                        .toLowerCase() !=
                                    "others" &&
                                (value == null || value.isEmpty)) {
                              return 'This is a mandatory field';
                            }
                            return null;
                          },
                        );

                        //debugPrint(_controller.selectedCategory.value?.name);
                        return SmartSelect<Branch>.multiple(
                          title: 'Select branch',
                          selectedValue: claimController.selectedBranch.value,
                          modalFilter: true,
                          modalFilterAuto: true,
                          modalFilterHint: 'Search branch',
                          modalConfig: const S2ModalConfig(
                            maxHeightFactor: 0.8,
                            type: S2ModalType.bottomSheet,
                          ),
                          onChange: (selected) {
                            claimController.selectedBranch(selected.value);
                          },
                          validation: (chosen) {
                            if (chosen.isEmpty)
                              return 'This is a mandatory field';
                            return '';
                          },
                          choiceItems: landingController.branches
                              .map((element) => S2Choice<Branch>(
                                  value: element, title: element.name))
                              .toList(),
                          modalType: S2ModalType.bottomSheet,
                          tileBuilder: (context, state) {
                            print(
                                'smart validation res: ${state.selected.isNotValid}');
                            return GestureDetector(
                              onTap: state.showModal,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 13),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                    boxShadow: null),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (claimController
                                                .selectedBranch.value ==
                                            null)
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Select branch",
                                                style: hintTextStyle(),
                                              )),
                                        if (claimController
                                                .selectedBranch.value !=
                                            null)
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                claimController.selectedBranch
                                                    .value[0]!.name,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 12,
                                          color: Colors.black.withOpacity(0.7),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }),
                      /*gapHC(3),
                      Obx(() => DropdownButtonFormField<Branch>(
                            focusColor: Colors.white,
                            dropdownColor: Colors.white,
                            decoration: dropdownDecoration,
                            validator: (value) {
                              if (value == null) {
                                return 'This is a mandatory field';
                              }
                              return null; // Valid input
                            },
                            hint: ts("Branch", Colors.grey.shade400),
                            value: claimController.selectedBranch.value,
                            isExpanded: true,
                            // Down Arrow Icon
                            icon: const Icon(Icons.arrow_forward_ios_rounded,
                                size: 13),
        
                            // Array list of items
                            items: landingController.branches.map((b) {
                              return DropdownMenuItem(
                                value: b,
                                child: ts(
                                  b.name,
                                  Colors.black,
                                ),
                              );
                            }).toList(),
                            onChanged: (Branch? value) {
                              claimController.selectedBranch(value);
                            },
                          )),*/
                      gapHC(15),
                      ts("Purpose of trip", Colors.black),
                      gapHC(3),
                      TextinputfieldContainer(
                          showIcon: false,
                          onSubmitted: () {},
                          verticalPadding: 6,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This is a mandatory field';
                            }
                            return null; // Valid input
                          },
                          textInputAction: TextInputAction.done,
                          controller:
                              claimController.textEditingControllerPurpose,
                          maxline: 3,
                          hintText: "Enter your purpose",
                          isEnable: true,
                          isObscure: false),
                      gapHC(20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        decoration: boxBaseDecoration(greyLight, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tssb("Categories", Colors.black, FontWeight.bold),
                            gapHC(12),
                            Obx(
                              () {
                                return GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // 2 columns
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: 7.7 / 2,
                                    ),
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount:
                                        claimController.categories.length,
                                    itemBuilder: (context, index) {
                                      return Obx(() {
                                        return GestureDetector(
                                          onTap: () {
                                            claimController.addOrRemoveCategory(
                                                claimController
                                                    .categories[index]);
                                          },
                                          child: Container(
                                            height: 44,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 4),
                                            decoration: boxBaseDecoration(
                                                Colors.white, 6),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 24.0,
                                                  width: 24.0,
                                                  child: Checkbox(
                                                    activeColor: Colors.green,
                                                    value: claimController
                                                        .isCategorySelected(
                                                            claimController
                                                                    .categories[
                                                                index]),
                                                    hoverColor: Colors.black,
                                                    focusColor: Colors.black,
                                                    onChanged: (bool? value) {
                                                      claimController
                                                          .addOrRemoveCategory(
                                                              claimController
                                                                      .categories[
                                                                  index]);
                                                    },
                                                  ),
                                                ),
                                                gapWC(4),
                                                CachedNetworkImage(
                                                  imageUrl: claimController
                                                      .categories[index]
                                                      .imageUrl,
                                                  height: 18,
                                                  width: 18,
                                                ),
                                                // CustomSslImageDispaly(url: claimController
                                                //           .categories[index]
                                                //           .imageUrl),
                                                gapWC(4),
                                                Expanded(
                                                    child: tchcus(
                                                        claimController
                                                            .categories[index]
                                                            .name,
                                                        Colors.black,
                                                        12.0,
                                                        height: 0.99)),
                                                gapWC(4),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                            )
                          ],
                        ),
                      ),
                      gapHC(10),
                      Obx(() {
                        print(
                            'opened sections: ${claimController.openedSections.toString()}');
                        if (claimController.selectedCategories.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        return ExpandedTileList.separated(
                          key: ValueKey(claimController.selectedCategories
                              .map(
                                (element) => "${element.id}-${element.name}",
                              )
                              .toList()
                              .join("")),
                          itemCount: claimController.selectedCategories.length,
                          maxOpened: 1,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                          initiallyOpenedControllersIndexes:
                              claimController.openedSections,
                          itemBuilder: (context, index, con) {
                            return ExpandedTile(
                              theme: ExpandedTileThemeData(
                                headerColor: greyLight,
                                headerPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 9),
                                headerSplashColor: greyLight,
                                contentSeparatorColor: Colors.white,
                                contentBackgroundColor: Colors.white,
                                headerBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: greyLight)),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              controller: con,
                              title: tss(
                                  claimController
                                      .selectedCategories[index].name,
                                  Colors.black,
                                  15.0),
                              leading: Image.network(
                                claimController
                                    .selectedCategories[index].imageUrl,
                                height: 25,
                                width: 25,
                              ),
                              //  CustomSslImageDispaly(url: claimController
                              //       .selectedCategories[index].imageUrl),

                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: primaryColor.withOpacity(0.8),
                                size: 24,
                              ),
                              trailingRotation: 180,
                              contentseparator: 12,
                              content: Column(
                                children: [
                                  Obx(() {
                                    if (claimController.isFormAddBusy.isTrue) {
                                      // do nothing
                                    }
                                    return ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, formIndex) {
                                          return FormItem(
                                            category: claimController
                                                .selectedCategories[index],
                                            formData: claimController
                                                .selectedCategories[index]
                                                .items[formIndex],
                                            index: formIndex + 1,
                                            onDelete: formIndex > 0
                                                ? () {
                                                    claimController
                                                        .selectedCategories[
                                                            index]
                                                        .items
                                                        .removeAt(formIndex);
                                                    claimController
                                                        .emitFormChange();
                                                  }
                                                : null,
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                              color: greyLight,
                                              height: 30,
                                            ),
                                        itemCount: claimController
                                            .selectedCategories[index]
                                            .items
                                            .length);
                                  }),
                                  gapHC(20),
                                  Bounce(
                                    onTap: () {
                                      claimController.addNewFormItem(
                                          claimController
                                              .selectedCategories[index]);
                                    },
                                    child: Container(
                                      decoration: boxOutlineCustom(
                                          Colors.white, 10.0, primaryColor),
                                      height: 46,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 9, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          tssb("Add more", Colors.black,
                                              FontWeight.w500),
                                          gapWC(2),
                                          const Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  gapHC(10)
                                ],
                              ),
                              onTap: () {
                                print("is open: ${con.isExpanded}");
                                if (con.isExpanded) {
                                  claimController.openedSections([index]);
                                  /*Future.delayed(Duration(milliseconds: 500)).then((value) {
                                    claimController.scrollToWidget(claimController.selectedCategories[index].items.first);
                                  },);*/
                                } else {
                                  claimController.openedSections.remove(index);
                                }
                              },
                              onLongTap: () {
                                debugPrint("looooooooooong tapped!!");
                              },
                            );
                          },
                        );
                      }),
                      Obx(() {
                        return SizedBox(
                          height: claimController.selectedCategories.isEmpty
                              ? 0
                              : 20,
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 12, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 6,
                        blurRadius: 6,
                        offset:
                            const Offset(5, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Obx(() {
                        if (claimController.isDraftBusy.isTrue) {
                          return const SpinKitThreeBounce(
                            color: primaryColor,
                            size: 20,
                          );
                        }
                        return Custombutton(
                            onTap: claimController.saveToDrafts,
                            buttonName: "Save draft",
                            buttonColor: Colors.white,
                            buttonBorderColor: Colors.grey.shade400,
                            buttonTextColor: primaryColor);
                      })),
                      gapWC(20),
                      Expanded(child: Obx(() {
                        if (claimController.isBusy.isTrue) {
                          return const SpinKitThreeBounce(
                            color: primaryColor,
                            size: 20,
                          );
                        }
                        return Custombutton(
                            onTap: claimController.continueToPreview,
                            buttonName: "Continue",
                            buttonColor: primaryColor,
                            buttonTextColor: Colors.white);
                      })),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _handleGlobalGesture(context) {
    FocusScope.of(context).unfocus();
  }
}

class PenetrableTapRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
