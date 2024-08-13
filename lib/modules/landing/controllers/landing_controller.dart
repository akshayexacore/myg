import 'package:get/get.dart';
import 'package:travel_claim/models/branch.dart';
import 'package:travel_claim/models/trip_type.dart';
import 'package:travel_claim/resources/myg_repository.dart';

class LandingController extends GetxController
    with GetSingleTickerProviderStateMixin {

  var isBranchBusy = false.obs;
  var branches = <Branch>[].obs;

  var isTripTypeBusy = false.obs;
  var tripTypes = <TripType>[].obs;

  final _repository = MygRepository();

  @override
  void onInit() {
    getBranches();
    geTripTypes();
    super.onInit();
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


}
