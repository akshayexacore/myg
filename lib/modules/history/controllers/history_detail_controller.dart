import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/modules/history/claim_resubmit_confirmation_page.dart';
import 'package:travel_claim/modules/history/claim_resubmit_page.dart';
import 'package:travel_claim/modules/history/controllers/history_controller.dart';
import 'package:travel_claim/modules/history/history_page.dart';
import 'package:travel_claim/modules/landing/landing_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/app_enums.dart';
import 'package:travel_claim/views/components/app_dialog.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/components/customButton.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/style/colors.dart';


class HistoryDetailController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;
  var isReSubmitBusy = false.obs;
  var isUpdateBusy = false.obs;
  var isRemoveBusy = false.obs;
  var isFormAddBusy = false.obs;
  var isFormUpdateBusy = false.obs;
  var claim = Rxn<ClaimHistory>();
  var reSubmittedCategories = <Category>[].obs;
  final formKey = GlobalKey<FormState>();
  final _repository = MygRepository();

  var canGoToHistory = true;

  @override
  void onInit() {
    claim(Get.arguments);
    if(claim.value!.categories == null || claim.value!.categories!.isEmpty){
      getDetails();
      canGoToHistory = false;
    }else{
      getDetails(isSilent: true);
    }
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

  removeSingle(BuildContext context, ClaimFormData claim) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: boxDecoration(Colors.white, 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            //  mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppAssets.reject),
                              gapHC(20),
                              tcCustomhead(
                                  "Are you sure you want to \n"
                                      "remove the claim item?",
                                  Colors.black87,
                                  size: 21.0,
                                  align: TextAlign.center,
                                  FontWeight.w500),
                              gapHC(30),
                            ],
                          ),
                          gapHC(30),
                          Row(
                            children: [
                              Expanded(
                                  child: Custombutton(
                                      onTap: () {
                                        Get.back();
                                      },
                                      buttonName: "Cancel",
                                      buttonColor: Colors.white,
                                      buttonBorderColor: Colors.grey.shade400,
                                      buttonTextColor: Colors.black)),
                              gapWC(20),
                              Expanded(
                                  child: Obx((){
                                    if (isRemoveBusy.isTrue) {
                                      return const SpinKitDoubleBounce(
                                        color: primaryColor,
                                      );
                                    }
                                    return Custombutton(
                                        onTap: ()=> _removeSingle(claim),
                                        buttonName: "Yes, remove",
                                        buttonColor: primaryColor,
                                        buttonTextColor: Colors.white);
                                  })),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ));
      },
    );
  }

  _removeSingle(ClaimFormData claimItem,{bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isRemoveBusy(true);
      }
      var body = {
        "trip_claim_details_id":claimItem.id,
      };
      var response = await _repository.removeSingleClaimItem(body: body);
      if(response.success){
        Get.back();
        AppDialog.showToast(response.message.isNotEmpty ? response.message : "Removed the item");
        if(Get.isRegistered<HistoryController>()){
          Get.find<HistoryController>().getHistory();
        }

        if(claim.value!.categories!.isEmpty || claim.value!.categories!.length == 1){
          Get.back();
        }else{
          getDetails();
        }

      }else{
        AppDialog.showToast(response.message.isNotEmpty ? response.message : "Something went wrong",isError: true);
      }
    } catch (_) {
      print('remove single error: ${_.toString()}');
      AppDialog.showToast("Something went wrong, Try again.",isError: true);
    } finally {
      if(!isSilent) {
        isRemoveBusy(false);
      }
    }
  }

  void gotoResubmit(){
    List<Category> cats = claim.value!.categories!.where((element) {
      return element.items.where((e) => e.status == ClaimStatus.rejected && e.rejectionCount < 2,).isNotEmpty;
    },).toList();

    if(cats.isEmpty){
      AppDialog.showToast("No claims to resubmit");
      return;
    }

    reSubmittedCategories(cats.map((e) => Category.fromJson(e.toJson()),).toList());
    Get.toNamed(ClaimResubmitPage.routeName);
  }

  void emitFormUpdate() {
    isFormUpdateBusy(true);
    isFormUpdateBusy(false);
  }

  void emitFormChange() {
    isFormAddBusy(true);
    isFormAddBusy(false);
  }

  bool _validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    }else {
      AppDialog.showToast("Please fill all the mandatory fields",isError: true);
      return false;
    }
  }

  void gotoResubmitPreview(){
    Get.toNamed(ClaimResubmitConfirmationPage.routeName);
  }

  void resubmit()async{
    try {
      isReSubmitBusy(true);
      if (_validateForm()) {

        var body = {
          "claim_details": reSubmittedCategories
            .expand((category) => category.items)
            .toList().map((v) => v.toApiJson()).toList()
        };

        var response = await _repository.resubmitClaim(body: body);
        if (response.success) {
          if(canGoToHistory) {
            Get.until((route) => Get.currentRoute == HistoryPage.routeName);
          }else{
            Get.until((route) => Get.currentRoute == LandingPage.routeName);
          }
          if(Get.isRegistered<HistoryController>()){
            Get.find<HistoryController>().getHistory();
          }
          AppDialog.showToast("Claim re-submitted successfully.");
        } else {
          AppDialog.showToast(response.message.isNotEmpty ? response.message : "Oops! failed to re-submit claim",isError: true);
        }
      }
    } catch (_) {
      print('ReSubmit error: ${_.toString()}');
    } finally {
      isReSubmitBusy(false);
    }
  }
}
