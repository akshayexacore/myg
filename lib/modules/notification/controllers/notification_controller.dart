import 'package:get/get.dart';
import 'package:travel_claim/models/claim_history.dart';
import 'package:travel_claim/models/notification.dart';
import 'package:travel_claim/modules/claim_approval/claim_detail_approval_page.dart';
import 'package:travel_claim/modules/history/history_detail_page.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/modules/special_approval/special_detail_approval_page.dart';
import 'package:travel_claim/resources/myg_repository.dart';

class NotificationController extends GetxController {
  var isBusy = false.obs;

  var notifications = <AppNotification>[].obs;

  final _repository = MygRepository();
  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  getNotifications({bool isSilent = false}) async {
    try {
      if(!isSilent) {
        isBusy(true);
      }

      var response = await _repository.getNotifications();
      notifications(response.notifications);
    } catch (_) {
      print('notifications get error: ${_.toString()}');
    } finally {
      if(!isSilent) {
        isBusy(false);
      }
    }
  }

  void onTap(AppNotification notification){
    if(notification.viewType.toLowerCase() == "User_View".toLowerCase()){
      Get.toNamed(HistoryDetailPage.routeName,arguments: ClaimHistory(tripClaimId: notification.tripClaimId));
    }else if(notification.viewType.toLowerCase() == "Approver_View".toLowerCase()){
      Get.toNamed(ClaimDetailApprovalPage.routeName,arguments: ClaimHistory(tripClaimId: notification.tripClaimId));
    }else if(notification.viewType.toLowerCase() == "SpecialApprover_View".toLowerCase()){
      Get.toNamed(SpecialDetailApprovalPage.routeName,arguments: ClaimHistory(tripClaimId: notification.tripClaimId));
    }

    notification.status = 'read';
    isBusy(true);
    isBusy(false);
  }
}
