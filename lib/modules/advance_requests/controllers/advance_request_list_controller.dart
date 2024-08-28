import 'package:get/get.dart';
import 'package:travel_claim/models/advance.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/resources/myg_repository.dart';


class AdvanceRequestListController extends GetxController with GetSingleTickerProviderStateMixin{
  var isBusy = false.obs;

  var items = <AdvanceHistory>[].obs;
  final _repository = MygRepository();

  @override
  void onInit() {
    getAdvanceList();
    super.onInit();
  }

  getAdvanceList({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }
      items.clear();
      var response = await _repository.getAdvanceRequests();
        items(response.advances);
    } catch (_) {
      print('advances get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }
}
