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

  var openedSections = [0].obs;

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
    if(claimFrom.value!.storageId.isNotEmpty) {
      openedSections([]);
    }
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
    int index = selectedCategories.indexOf(category);
    if (selectedCategories.contains(category)) {
      List<int> newItems = [];
      for (var element in openedSections) {
        if(element == index){}
        else if(element>index){
          newItems.add(element - 1);
        }else{
          newItems.add(element);
        }
      }
      openedSections(newItems);
      selectedCategories.remove(category);
    } else {
      if (category.items.isEmpty) {
        category.items.add(ClaimFormData());
      }
      selectedCategories.add(category);
      if(selectedCategories.length == 1){
        openedSections([0]);
      }
    }
  }

  void addNewFormItem(Category category) {
    isFormAddBusy(true);
    var claim = ClaimFormData();
    category.items.add(claim);
    isFormAddBusy(false);
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      scrollToWidget(claim);
    },);

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
              branch: selectedBranch.value,
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
          AppDialog.showToast("Saved to drafts");
        } else {
          AppDialog.showToast("Opps! failed to save to drafts",isError: true);
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
      AppDialog.showToast("Please select a Trip type",isError: true);
      return false;
    }
    if (selectedTripType.value?.name.toLowerCase() != "others" && selectedBranch.value == null) {
      AppDialog.showToast("Please select a branch",isError: true);
      return false;
    }
    if (selectedCategories.isEmpty) {
      AppDialog.showToast("Please select at least one category",isError: true);
      return false;
    }
    return true;
  }

  bool _validateForm() {

    bool isFormValid = formKey.currentState!.validate();
    bool areFilesValid = _validateFiles();
    bool isDateEmpty=_validateDates(
      
    );
    print("isDateEmpty$isDateEmpty");

    if (isFormValid && areFilesValid) {
      if (selectedCategories.isEmpty) {
        AppDialog.showToast("Please select at least one category",isError: true);
        return false;
      }
      else if(isDateEmpty){
        AppDialog.showToast("Please fill all the mandatory fields",isError: true);
         return false;
    }
      return true;
   
    }
    else {
      AppDialog.showToast("Please fill all the mandatory fields",isError: true);
      return false;
    }
  }

  bool _validateFiles(){
    bool valid = true;
    selectedCategories.forEach((element) {
      print('here 1');
      element.items.forEach((form) {
        print('here 2');
        if(form.files.isEmpty && element.name.toLowerCase()!='food'){
          form.fileError = "This is a mandatory field";
          print('here');
          emitFormUpdate();
          emitFormChange();
          valid = false;
        }
      },);
    },);

    return valid;
  }
  bool _validateDates(){
    bool valid = true;
    selectedCategories.forEach((element) {
      print('here 1');
      element.items.forEach((form) {
        print('here 2');
        if(element.hasFromDate){
          if(form.fromDate==null ){
            form.isFrmdateEmpty=true;
          emitFormUpdate();
          emitFormChange();
          valid = true;}else{
            form.isFrmdateEmpty=false;
            emitFormUpdate();
          emitFormChange();
          valid = false;
          }
          if(form.toDate==null ){
            form.isToDateIsEmpty=true;
          emitFormUpdate();
          emitFormChange();
          valid = true;
          }
          else{
             form.isToDateIsEmpty=false;
            emitFormUpdate();
          emitFormChange();
          valid = false;
          }
         
        }else{
          if(form.fromDate==null ){form.isFrmdateEmpty=true;
          emitFormUpdate();
          emitFormChange();
          valid = true;}else{
            form.isFrmdateEmpty=false;
            emitFormUpdate();
          emitFormChange();
          valid = false;
          }
        }
      },);
    },);

    return valid;
  }

  void save() async {
    print("claimFrom.value!${claimFrom.value!}");
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

          if(claimFrom.value!.storageId.isNotEmpty) {
            _localRepository.delete(claimFrom.value!.storageId);
          }

          Get.until((route) => Get.currentRoute == LandingPage.routeName);
          AppDialog.showToast("Claim submitted successfully.");
        } else {
          AppDialog.showToast(response.message.isNotEmpty ? response.message : "Oops! failed to submit claim",isError: true);
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
    final context = claim.formKey.currentContext;//selectedCategories.first.items.first.formKey.currentContext;
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
