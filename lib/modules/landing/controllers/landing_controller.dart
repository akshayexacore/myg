import 'package:get/get.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/modules/splash/controllers/update_controller.dart';
import 'package:travel_claim/resources/myg_repository.dart';

class LandingController extends GetxController
    with GetSingleTickerProviderStateMixin {
 final updateController = Get.put(UpdateController());
  var isBranchBusy = false.obs;
  var branches = <Branch>[].obs;

  var isTripTypeBusy = false.obs;
  var tripTypes = <TripType>[].obs;
  var notifications = 0.obs;

  final _repository = MygRepository();

  @override
  void onInit() {
    versionCheck();
    getNotificationCount();
    getBranches();
    geTripTypes();
    super.onInit();
  }

  versionCheck() async {
      await updateController.checkVersion();
  }


  getBranches({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBranchBusy(true);
      }
      var response = await _repository.getBranches();
      if (response.success) {
        branches(response.branches);
      }
    } catch (_) {
      print('branch error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBranchBusy(false);
      }
    }
  }


  geTripTypes({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isTripTypeBusy(true);
      }
      var response = await _repository.getTripTypes();
      if (response.success) {
        tripTypes(response.tripTypes);
      }
    } catch (_) {
      print('trip error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isTripTypeBusy(false);
      }
    }
  }

  getNotificationCount({bool isSilent = false}) async {
    try {
      var response = await _repository.getNotificationCount();
      if (response.success) {
        notifications(response.notifications);
      }
    } catch (_) {
      print('notification count error: ${_.toString()}');
    } finally {
    }
  }


}
