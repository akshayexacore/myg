import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:travel_claim/main.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/category.dart';
import 'package:travel_claim/models/claim_form.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/modules/advance_requests/controllers/advance_request_list_controller.dart';
import 'package:travel_claim/modules/claim/claim_confirmation_page.dart';
import 'package:travel_claim/modules/landing/landing_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';
import 'package:travel_claim/utils/local_storage_data_provider.dart';
import 'package:travel_claim/views/components/alertDialog.dart';
import 'package:travel_claim/views/components/app_dialog.dart';
import 'package:travel_claim/views/components/common.dart';
import 'package:travel_claim/views/const/appassets.dart';
import 'package:travel_claim/views/widgets.dart';

class AdvanceRequestController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isBusy = false.obs;
  var selectedBranch = Rxn<Branch>();
  var selectedTripType = Rxn<TripType>();
  final _repository = MygRepository();
  final _localRepository = LocalStorageDataProvider();
  TextEditingController textEditingControllerPurpose = TextEditingController();
  TextEditingController textEditingControllerAmount = TextEditingController();
  TextEditingController textEditingControllerRemarks = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  var categories = <Category>[].obs;
  var selectedCategories = <Category>[].obs;

  final formKey = GlobalKey<FormState>();

  var openedSections = [0].obs;

  @override
  void onInit() {
    super.onInit();
  }

  bool _validateBaseForm() {
    if (selectedTripType.value == null) {
      AppDialog.showToast("Please select a Trip type",isError: true);
      return false;
    }
    if (selectedBranch.value == null) {
      AppDialog.showToast("Please select a branch",isError: true);
      return false;
    }
    if (selectedCategories.isEmpty) {
      AppDialog.showToast("Please select at least one category",isError: true);
      return false;
    }
    return true;
  }

  Future<void> selectFromDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2023, 1),
        lastDate: DateTime(2050, 8),
        initialDate: DateTime.now());
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;


    }
  }

  bool _validateForm() {

    bool isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      return true;
    }else {
      AppDialog.showToast("Please fill all the mandatory fields",isError: true);
      return false;
    }
  }


  void save(BuildContext context) async {
    try {
      isBusy(true);
      if (_validateForm()) {

        var body = {
          "amount": textEditingControllerAmount.text,
          "remarks": textEditingControllerRemarks.text,
          "triptype_id":selectedTripType.value?.id,
          "trip_purpose": textEditingControllerPurpose.text,
          "branch_id":selectedBranch.value?.id
        };

        var response = await _repository.requestAdvance(body: body);
        if (response.success) {
          Get.back();
          if(Get.isRegistered<AdvanceRequestListController>()){
            Get.find<AdvanceRequestListController>().getAdvanceList();
          }
          show(context,
              contHeight: MediaQuery.sizeOf(context).height*0.35,
              autoDismiss: true,

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gapHC(30),
                  Image.asset(
                    AppAssets.sentpng
                    ,fit: BoxFit.fill,

                  ),
                  gapHC(30),
                  tcCustomhead("Your request for advance \n"
                      "has been sent", Colors.black87,
                      size: 21.0,
                      align: TextAlign.center, FontWeight.w500),

                  gapHC(20)
                ],
              ));
        } else {
          AppDialog.showToast(response.message.isNotEmpty ? response.message : "Oops! failed to submit request",isError: true);
        }
      }
    } catch (_) {
      print('advance saving error: ${_.toString()}');
    } finally {
      isBusy(false);
    }
  }
}
