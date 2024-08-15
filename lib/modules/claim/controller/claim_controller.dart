import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_claim/main.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/modules/claim/claim_confirmation_page.dart';
import 'package:travel_claim/modules/landing/landing_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/local_storage_data_provider.dart';
import 'package:travel_claim/views/components/app_dialog.dart';
import 'package:travel_claim/views/widgets.dart';

class ClaimController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isBusy = false.obs;
  var isDraftBusy = false.obs;
  var isFormAddBusy = false.obs;
  var isFormUpdateBusy = false.obs;
  var isCategoryBusy = false.obs;
  var selectedBranch = Rxn<Branch>();
  var selectedTripType = Rxn<TripType>();
  var claimFrom = Rxn<ClaimForm>();
  final _repository = MygRepository();
  final _localRepository = LocalStorageDataProvider();
  TextEditingController textEditingControllerPurpose = TextEditingController();

  var categories = <Category>[].obs;
  var selectedCategories = <Category>[].obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    claimFrom(Get.arguments);
    if (claimFrom.value != null) {
      initializeForEdit();
    }
    getCategories();
    super.onInit();
  }

  void initializeForEdit() {
    selectedTripType(claimFrom.value!.tripType);
    selectedBranch(claimFrom.value!.branch);
    textEditingControllerPurpose.text = claimFrom.value!.purpose;
    selectedCategories(claimFrom.value!.categories);
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
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      if (category.items.isEmpty) {
        category.items.add(ClaimFormData());
      }
      selectedCategories.add(category);
    }
  }

  void addNewFormItem(Category category) {
    isFormAddBusy(true);
    category.items.add(ClaimFormData());
    isFormAddBusy(false);
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
        if (claimFrom.value == null) {
          claimFrom(ClaimForm(
              tripType: selectedTripType.value!,
              branch: selectedBranch.value!,
              createdAt: DateTime.now(),
              purpose: textEditingControllerPurpose.text,
              categories: selectedCategories));
        } else {
          claimFrom.value!.tripType = selectedTripType.value!;
          claimFrom.value!.branch = selectedBranch.value!;
          claimFrom.value!.purpose = textEditingControllerPurpose.text;
          claimFrom.value!.categories = selectedCategories;
          claimFrom(claimFrom.value);
        }

        bool response = await _localRepository.saveOrUpdate(claimFrom.value!);
        if (response) {
          Get.until((route) => Get.currentRoute == LandingPage.routeName);
          AppDialog.showSnackBar("Success", "Saved to drafts");
        } else {
          AppDialog.showToast("Opps! failed to save to drafts");
        }
      }
    } catch (_) {
      print('draft saving error: ${_.toString()}');
    } finally {
      isDraftBusy(false);
    }
  }

  bool _validateBaseForm() {
    if (selectedTripType.value == null) {
      AppDialog.showSnackBar("Oops", "Please select a Trip type");
      return false;
    }
    if (selectedBranch.value == null) {
      AppDialog.showSnackBar("Oops", "Please select a branch");
      return false;
    }
    if (selectedCategories.isEmpty) {
      AppDialog.showSnackBar("Oops", "Please select at least one category");
      return false;
    }
    return true;
  }

  bool _validateForm() {
    if (formKey.currentState!.validate()) {
      if (selectedCategories.isEmpty) {
        AppDialog.showSnackBar("Oops", "Please select at least one category");
        return false;
      }
      return true;
    }else {
      AppDialog.showSnackBar("Oops", "Please fill all the mandatory fields");
      return false;
    }
  }

  void save() async {
    try {
      isBusy(true);
      if (_validateForm()) {
        if (claimFrom.value == null) {
          claimFrom(ClaimForm(
              tripType: selectedTripType.value!,
              branch: selectedBranch.value!,
              createdAt: DateTime.now(),
              purpose: textEditingControllerPurpose.text,
              categories: selectedCategories));
        } else {
          claimFrom.value!.tripType = selectedTripType.value!;
          claimFrom.value!.branch = selectedBranch.value!;
          claimFrom.value!.purpose = textEditingControllerPurpose.text;
          claimFrom.value!.categories = selectedCategories;
          claimFrom(claimFrom.value);
        }

        var response =
            await _repository.saveClaim(body: claimFrom.value!.toApiJson());
        if (response.success) {

          if(claimFrom.value!.storageId.isNotEmpty) {
            _localRepository.delete(claimFrom.value!.storageId);
          }

          Get.until((route) => Get.currentRoute == LandingPage.routeName);
          AppDialog.showSnackBar("Success", "Claim submitted successfully.");
        } else {
          AppDialog.showToast(response.message.isNotEmpty ? response.message : "Oops! failed to submit claim");
        }
      }
    } catch (_) {
      print('saving error: ${_.toString()}');
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
}
