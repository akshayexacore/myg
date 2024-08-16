import 'package:get/get.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/resources/myg_repository.dart';


class ClaimApprovalListController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;

  var items = <ClaimHistory>[].obs;
  final _repository = MygRepository();

  @override
  void onInit() {
    getApprovalList();
    super.onInit();
  }

  getApprovalList({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }
      items.clear();
      var response = await _repository.getClaimsForApproval();
        items(response.claims);
    } catch (_) {
      print('approval claims get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }
}
