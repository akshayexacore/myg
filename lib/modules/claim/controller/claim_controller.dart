import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_claim/global/globalValues.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/models/draft_list_model.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/modules/claim/claim_confirmation_page.dart';
import 'package:travel_claim/modules/drafts/controllers/draft_controller.dart';
import 'package:travel_claim/modules/landing/landing_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/local_storage_data_provider.dart';
import 'package:travel_claim/views/components/app_dialog.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:travel_claim/views/widgets.dart';

class ClaimController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isBusy = false.obs;
  var isDraftBusy = false.obs;
  var isFormAddBusy = false.obs;
  var isFormUpdateBusy = false.obs;
  var isCategoryBusy = false.obs;
 var selectedBranch = <Branch>[].obs;

  var selectedTripType = Rxn<TripType>();
  var claimFrom = Rxn<ClaimForm>();
  var claimFromDraft = Rxn<DraftListModel>();
  final _repository = MygRepository();
  final _localRepository = LocalStorageDataProvider();
  TextEditingController textEditingControllerPurpose = TextEditingController();
  var categories = <Category>[].obs;
  var selectedCategories = <Category>[].obs;
  final formKey = GlobalKey<FormState>();
  var openedSections = [0].obs;
  var claim = Rxn<ClaimHistory>();
  final _controller = Get.find<DraftController>();
  @override
  void onInit() {
    claimFromDraft(Get.arguments);
    if (claimFromDraft.value != null) {
      initializeForEdit();
    }
    getCategories();
    super.onInit();
  }

  void initializeForEdit() async{
    await getDetails();
    selectedTripType(claim.value!.tripTypeDetails);
    selectedBranch(claim.value!.visitBranchDetail);
    textEditingControllerPurpose.text = claim.value!.tripPurpose;
    if (claim.value?.categories != null) {
  for (var category in claim.value!.categories!) {
    if (category.items != null) {
      category.items = category.items!.map((item) {
        return item.copyWith(
          files: normalizeFiles(item.files),
        );
      }).toList();
    }
  }
}
    selectedCategories(claim.value!.categories);
    if (claim.value?.tripClaimId.isNotEmpty==true) {
      openedSections([]);
    }
  }
  getDetails({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }
      var response = await _repository.getDraftDetail(claimFromDraft.value?.tripClaimId??"");
      
        claim(response.claim);
        // debugPrint(claim.value)
    } catch (_) {
      print('detail claims get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }
  Future<bool> showGetXBackConfirmation() async {
  bool? result = await Get.dialog<bool>(
    AlertDialog(
      title: const Text("Confirm Exit"),
      content: const Text("Are you sure you want to leave this page? Unsaved changes may be lost."),
      actions: [
        Row(
          children: [
            Expanded(
              child:  Custombutton(
                              onTap:  () => Get.back(result: true),
                              buttonName: "Discard",
                              buttonColor: Colors.white,
                              buttonBorderColor: Colors.grey.shade400,
                              buttonTextColor: primaryColor),
              // TextButton(
              //   onPressed: () => Get.back(result: true),
              //   child: const Text("Discard"),
              // ),
            ),
            SizedBox(width: 10,),

               Expanded(
                 child: Custombutton(
                           
                                onTap: () {
                                  saveToDrafts();
                                },
                                buttonName: "Save",
                                buttonColor: primaryColor,
                                buttonTextColor: Colors.white),
               )
          ],
        ),
     
        // AppButton(
        //   onPressed:,
        //   child: const Text("Save"),
        // ),
      ],
    ),
    barrierDismissible: false,
  );

  return result ?? false;
}
  getCategories({bool isSilent = false}) async {
    try {
      if (!isSilent) {
        isCategoryBusy(true);
      }
      var response = await _repository.getCategories();
      if (response.success) {
        categories(response.categories);
      }
    } catch (_) {
      print('category error: ${_.toString()}');
    } finally {
      if (!isSilent) {
        isCategoryBusy(false);
      }
    }
  }

  bool isCategorySelected(Category category) {
    return selectedCategories.contains(category);
  }

  void addOrRemoveCategory(Category category) {
    debugPrint("category$category");
    int index = selectedCategories.indexOf(category);
     debugPrint("index$index");
     debugPrint("index${selectedCategories.contains(category)}");
    if (selectedCategories.contains(category)) {
      List<int> newItems = [];
      for (var element in openedSections) {
        if (element == index) {
        } else if (element > index) {
          newItems.add(element - 1);
        } else {
          newItems.add(element);
        }
      }
      openedSections(newItems);
      selectedCategories.remove(category);
    } else {
      if (category.items?.isEmpty==true) {
        category.items?.add(ClaimFormData());
      }debugPrint("category$category");
      
      selectedCategories.add(category);
      debugPrint("ssssss$selectedCategories");
      if (selectedCategories.length == 1) {
        openedSections([0]);
      }
    }
  }

  void addNewFormItem(Category category) {
    isFormAddBusy(true);
    var claim = ClaimFormData();
    category.items?.add(claim);
    isFormAddBusy(false);
    Future.delayed(const Duration(milliseconds: 500)).then(
      (value) {
        scrollToWidget(claim);
      },
    );
  }

  void emitFormUpdate() {
    isFormUpdateBusy(true);
    isFormUpdateBusy(false);
  }

  void emitFormChange() {
    isFormAddBusy(true);
    isFormAddBusy(false);
  }

  void saveToDrafts() async {
    try {
      isDraftBusy(true);
      if (_validateBaseForm()) {
        print("is valid${claim.value }");

        if (claim.value == null) {
          claimFrom(ClaimForm(
              tripType: selectedTripType.value ?? TripType(),
              branch: selectedBranch.value,
              createdAt: DateTime.now(),
              purpose: textEditingControllerPurpose.text,
              categories: selectedCategories));
        } else {
             if (claimFrom.value == null) {
            claimFrom(ClaimForm()); // <- default empty form to avoid null
          }

          final form = claimFrom.value!;
          form.tripType = selectedTripType.value ?? TripType();
          form.branch = selectedBranch.value ?? [];
          form.purpose = textEditingControllerPurpose.text;
          form.categories = selectedCategories.value;
          claimFrom(form);
           print("is claim  ${claim.value }");
          // claimFrom.value?.tripType = selectedTripType.value ?? TripType();
          
          // claimFrom.value?.branch = selectedBranch.value ?? [];
          
          // claimFrom.value?.purpose = textEditingControllerPurpose.text;
          // claimFrom.value?.categories = selectedCategories.value;
          //     print("is claim  ${claim.value }");
          // // claimFrom(claimFrom.value);
          //  print("is claupdated    im  ${claim.value }");
        
        }
      print("is daaaaa${claim.value?.tripClaimId}");
      if (claimFrom.value == null) {
  throw Exception("Claim form data is missing. Cannot save draft.");
}

       var response = claim.value?.tripClaimId!=null? await _repository.updateDraft(body: claimFrom.value!.toApiJson(),id:claim.value?.tripClaimId??"" ): await _repository.saveDraft(body: claimFrom.value!.toApiJson());
        print("is response${response}");
        if (response.success) {
          Get.until((route) => Get.currentRoute == LandingPage.routeName);
          AppDialog.showToast("Saved to drafts");
        } else {
          AppDialog.showToast("Opps! failed to save to drafts", isError: true);
        }
      }
    } catch (_) {
       AppDialog.showToast(_.toString(), isError: true);
      print('draft saving error: ${_.toString()}');
    } finally {
      isDraftBusy(false);
    }
  }

  bool _validateBaseForm() {
    if (selectedTripType.value == null) {
      AppDialog.showToast("Please select a Trip type", isError: true);
      return false;
    }
    if (selectedTripType.value?.name.toLowerCase() != "others" &&
        selectedBranch.value == null) {
      AppDialog.showToast("Please select a branch", isError: true);
      return false;
    }
    if (selectedCategories.isEmpty) {
      AppDialog.showToast("Please select at least one category", isError: true);
      return false;
    }
    return true;
  }

  bool _validateForm() {
    bool isFormValid = formKey.currentState!.validate();
    bool areFilesValid = _validateFiles();
    bool isDateEmpty = _validateDates();


    if (isFormValid && areFilesValid) {
      if (selectedCategories.isEmpty) {
        AppDialog.showToast("Please select at least one category",
            isError: true);
        return false;
      } else if (isDateEmpty) {
        AppDialog.showToast("Please fill all the mandatory fields",
            isError: true);
        return false;
      }
      return true;
    } else {
      AppDialog.showToast("Please fill all the mandatory fields",
          isError: true);
      return false;
    }
  }

  bool _validateFiles() {
    bool valid = true;
    selectedCategories.forEach(
      (element) {
        element.items?.forEach(
          (form) {
            if (form.files?.isEmpty==true &&
                element.name?.toLowerCase() != 'food' &&
                element.name?.toLowerCase() != 'cab' &&
                element.name?.toLowerCase() != 'two-wheeler' &&
                element.name?.toLowerCase() != 'four-wheeler') {
              form.fileError = "This is a mandatory field";
              print('here');
              emitFormUpdate();
              emitFormChange();
              valid = false;
            }
          },
        );
      },
    );

    return valid;
  }

  bool _validateDates() {
    bool valid = true;
    selectedCategories.forEach(
      (element) {
        print('here 1');
        element.items?.forEach(
          (form) {
            print('here 2');
            if (element?.hasFromDate==true) {
              if (form.fromDate == null) {
                form.isFrmdateEmpty = true;
                emitFormUpdate();
                emitFormChange();
                valid = true;
              } else {
                form.isFrmdateEmpty = false;
                emitFormUpdate();
                emitFormChange();
                valid = false;
              }
              if (form.toDate == null) {
                form.isToDateIsEmpty = true;
                emitFormUpdate();
                emitFormChange();
                valid = true;
              } else {
                form.isToDateIsEmpty = false;
                emitFormUpdate();
                emitFormChange();
                valid = false;
              }
            } else {
              if (form.fromDate == null) {
                form.isFrmdateEmpty = true;
                emitFormUpdate();
                emitFormChange();
                valid = true;
              } else {
                form.isFrmdateEmpty = false;
                emitFormUpdate();
                emitFormChange();
                valid = false;
              }
            }
          },
        );
      },
    );

    return valid;
  }

  void save() async {
    try {
      isBusy(true);
      if (_validateForm()) {
        if (claimFrom.value == null) {
          claimFrom(ClaimForm(
              tripType: selectedTripType.value!,
              branch: selectedBranch.value,
              createdAt: DateTime.now(),
              purpose: textEditingControllerPurpose.text,
              categories: selectedCategories));
        } else {
          claimFrom.value!.tripType = selectedTripType.value!;
          claimFrom.value!.branch = selectedBranch.value;
          claimFrom.value!.purpose = textEditingControllerPurpose.text;
          claimFrom.value!.categories = selectedCategories;
          claimFrom(claimFrom.value);
        }

        var response =
            await _repository.saveClaim(body: claimFrom.value!.toApiJson());
        if (response.success) {
          if(claim.value?.tripClaimId!=null){
            await _repository.deleteDraft(body:{"trip_claim_id":claim.value?.tripClaimId});

          }
          // if (claimFrom.value!.storageId?.isNotEmpty??false) {
          //   _localRepository.delete(claimFrom.value!.storageId);
          // }

          Get.until((route) => Get.currentRoute == LandingPage.routeName);
          AppDialog.showToast("Claim submitted successfully.");
        } else {
          AppDialog.showToast(
              response.message.isNotEmpty
                  ? response.message
                  : "Oops! failed to submit claim",
              isError: true);
        }
      }
    } catch (_) {
      print('saving error: ${_.toString()}');
      AppDialog.showToast(_.toString());
    } finally {
      isBusy(false);
    }
  }

  void continueToPreview() async {
    try {
      isBusy(true);
      if (_validateForm()) {
        Get.toNamed(ClaimConfirmationPage.routeName);
        print('saving nave:');
      }
    } catch (_) {
      print('saving error: ${_.toString()}');
    } finally {
      isBusy(false);
    }
  }

  void scrollToWidget(ClaimFormData claim) {
    final context = claim.formKey
        .currentContext; //selectedCategories.first.items.first.formKey.currentContext;
    print('scrolling check');
    if (context != null) {
      print('scrolling');
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
        alignment: 0.0,
      );
    }
  }
}
