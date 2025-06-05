import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/models/employee.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/modules/claim_approval/controllers/claim_approval_list_controller.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/local_storage_data_provider.dart';
import 'package:travel_claim/views/components/app_dialog.dart';


class ClaimDetailApprovalController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;
  var isUpdateBusy = false.obs;

  var claim = Rxn<ClaimHistory>();


  final _repository = MygRepository();

  TextEditingController textEditingControllerConfirmRemarks = TextEditingController();

  var selectedApprover = Rxn<Employee>();
  var approverList = <Employee>[].obs;

  onSelectApprover(val) {
    selectedApprover.value = val;
  }

  @override
  void onInit() {
    claim(Get.arguments);
    if(claim.value!.categories == null || claim.value!.categories!.isEmpty){
      getDetails();
    }else{
      getDetails(isSilent: true);
    }
    getApprovers();
    super.onInit();
  }

  getDetails({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }
      var response = await _repository.getClaimDetail(claim.value!.tripClaimId);
        claim(response.claim);
    } catch (_) {
      print('detail claims get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }

  getApprovers({bool isSilent = false}) async {
    try {
      var response = await _repository.getApprovers();
        approverList(response.employee);
    } catch (_) {
      print('approvers get error: ${_.toString()}');
    } finally {
    }
  }

  void reloadClaim(){
    getDetails();
    if(Get.isRegistered<ClaimApprovalListController>()){
      Get.find<ClaimApprovalListController>().getApprovalList();
    }
  }


void onChangeCheckBox(int catIndex, int itemIndex, bool val) {
  final currentClaim = claim.value;

  if (currentClaim != null) {
    // 1. Copy the target item with updated value
    final updatedItem = currentClaim
        .categories![catIndex]
        .items[itemIndex]
        .copyWith(isEnableSendApproval: val);

    // 2. Copy the items list and replace the updated item
    final updatedItems = [...currentClaim.categories![catIndex].items];
    updatedItems[itemIndex] = updatedItem;

    // 3. Copy the category with updated items
    final updatedCategory =
        currentClaim.categories![catIndex].copyWith(items: updatedItems);

    // 4. Copy the categories list and replace the updated category
    final updatedCategories = [...currentClaim.categories!];
    updatedCategories[catIndex] = updatedCategory;

    // 5. Copy the full claim object with updated categories
    final updatedClaim = currentClaim.copyWith(categories: updatedCategories);

    // 6. Reassign to trigger GetX UI update
    claim.value = updatedClaim;
  }
}

  rejectSingle(ClaimFormData claim,{bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isUpdateBusy(true);
      }
      var body = {
        "trip_claim_details_id":claim.id,
        "remarks":textEditingControllerConfirmRemarks.text
      };
       var response = await _repository.rejectSingleClaimItem(body: body);
       if(response.success){
         Get.back();
         AppDialog.showToast(response.message.isNotEmpty ? response.message : "Rejected the item");
         reloadClaim();
         _clearForm();
       }else{
         AppDialog.showToast(response.message.isNotEmpty ? response.message : "Something went wrong",isError: true);
       }
    } catch (_) {
      print('reject single error: ${_.toString()}');
      AppDialog.showToast("Something went wrong, Try again.",isError: true);
    } finally {
      if(!isSilent) {
        isUpdateBusy(false);
      }
    }
  }

  sentForApproval(ClaimFormData claim,{bool isSilent = false}) async {
    try {

      if(selectedApprover.value == null){
        AppDialog.showToast("Please select an approver",isError: true);
        return;
      }

      if(!isSilent) {
        isUpdateBusy(true);
      }
      var body = {
        "trip_claim_details_id":claim.id,
        "approver_id":selectedApprover.value?.employeeId,
        "remarks": textEditingControllerConfirmRemarks.text,
      };
       var response = await _repository.sentForSpecialApproval(body: body);
       if(response.success){
         Get.back();
         AppDialog.showToast(response.message.isNotEmpty ? response.message : "Removed the item");
         reloadClaim();
         _clearForm();
       }else{
         AppDialog.showToast(response.message.isNotEmpty ? response.message : "Something went wrong",isError: true);
       }
    } catch (_) {
      print('sentForApproval error: ${_.toString()}');
      AppDialog.showToast("Something went wrong, Try again.",isError: true);
    } finally {
      if(!isSilent) {
        isUpdateBusy(false);
      }
    }
  }

  _clearForm(){
    selectedApprover.value = null;
    textEditingControllerConfirmRemarks.clear();
  }


  approveOrRejectAll({bool isSilent = false,bool isReject  = false}) async {
    try {

      if(!isSilent) {
        isUpdateBusy(true);
      }

      var body = {
        "trip_claim_id":claim.value!.tripClaimId,
        "status": isReject ? "Rejected" : "Approved",
        "remarks": textEditingControllerConfirmRemarks.text,
      };
      var response = await _repository.approveOrRejectAll(body: body);
      if(response.success){
        Get.back();
        AppDialog.showToast(response.message.isNotEmpty ? response.message : "${isReject ? "Rejected" : "Approved"} the claim");
        reloadClaim();
        _clearForm();
      }else{
        AppDialog.showToast(response.message.isNotEmpty ? response.message : "Something went wrong",isError: true);
      }
    } catch (_) {
      print('approveOrRejectAll error: ${_.toString()}');
      AppDialog.showToast("Something went wrong, Try again.",isError: true);
    } finally {
      if(!isSilent) {
        isUpdateBusy(false);
      }
    }
  }
}
