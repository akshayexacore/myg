import 'package:get/get.dart';
import 'package:travel_claim/modules/advance/advance_request_page.dart';
import 'package:travel_claim/modules/advance/controller/advance_request_controller.dart';
import 'package:travel_claim/modules/advance_requests/advance_detail_page.dart';
import 'package:travel_claim/modules/advance_requests/advance_request_list_page.dart';
import 'package:travel_claim/modules/advance_requests/controllers/advance_detail_controller.dart';
import 'package:travel_claim/modules/advance_requests/controllers/advance_request_list_controller.dart';
import 'package:travel_claim/modules/claim/claim_confirmation_page.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/modules/claim/controller/claim_controller.dart';
import 'package:travel_claim/modules/claim_approval/claim_approval_list_page.dart';
import 'package:travel_claim/modules/claim_approval/claim_detail_approval_page.dart';
import 'package:travel_claim/modules/claim_approval/controllers/claim_approval_list_controller.dart';
import 'package:travel_claim/modules/claim_approval/controllers/claim_detail_approval_controller.dart';
import 'package:travel_claim/modules/drafts/controllers/draft_controller.dart';
import 'package:travel_claim/modules/drafts/draft_page.dart';
import 'package:travel_claim/modules/history/claim_resubmit_confirmation_page.dart';
import 'package:travel_claim/modules/history/claim_resubmit_page.dart';
import 'package:travel_claim/modules/history/controllers/history_controller.dart';
import 'package:travel_claim/modules/history/controllers/history_detail_controller.dart';
import 'package:travel_claim/modules/history/history_detail_page.dart';
import 'package:travel_claim/modules/history/history_page.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/modules/landing/controllers/profile_controller.dart';
import 'package:travel_claim/modules/landing/landing_page.dart';
import 'package:travel_claim/modules/login/controllers/auth_controller.dart';
import 'package:travel_claim/modules/login/controllers/login_controller.dart';
import 'package:travel_claim/modules/login/login_page.dart';
import 'package:travel_claim/modules/notification/controllers/notification_controller.dart';
import 'package:travel_claim/modules/notification/notification_screen.dart';
import 'package:travel_claim/modules/notification/notification_screen.dart';
import 'package:travel_claim/modules/profile/profile_page.dart';
import 'package:travel_claim/modules/profile/profile_page.dart';
import 'package:travel_claim/modules/special_approval/controllers/special_approval_list_controller.dart';
import 'package:travel_claim/modules/special_approval/controllers/special_detail_approval_controller.dart';
import 'package:travel_claim/modules/special_approval/special_approval_list_page.dart';
import 'package:travel_claim/modules/special_approval/special_detail_approval_page.dart';
import 'package:travel_claim/modules/splash/controllers/splash_controller.dart';
import 'package:travel_claim/modules/splash/splash_page.dart';

class Routes {
  static var getPages = [
    GetPage(
        name: SplashPage.routeName,
        page: () => SplashPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SplashController());
          Get.lazyPut(() => AuthController());
        })),
    GetPage(
        name: LoginPage.routeName,
        page: () => LoginPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LoginController());
          Get.lazyPut(() => AuthController());
        })),
    GetPage(
        name: LandingPage.routeName,
        page: () => LandingPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => LandingController());
          Get.lazyPut(() => ProfileController());
        })),
    GetPage(
        name: ProfilePage.routeName,
        page: () => ProfilePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ProfileController());
        })),
    GetPage(
        name: NotificationScreen.routeName,
        page: () => NotificationScreen(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => NotificationController());
        })),
    GetPage(
        name: ClaimPage.routeName,
        page: () => ClaimPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ClaimController());
          Get.lazyPut(() => DraftController());
        })),
    GetPage(
        name: ClaimConfirmationPage.routeName,
        page: () => ClaimConfirmationPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ClaimController());
        })),
    GetPage(
        name: DraftPage.routeName,
        page: () => DraftPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => DraftController());
        })),
    GetPage(
        name: HistoryPage.routeName,
        page: () => HistoryPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HistoryController());
        })),
    GetPage(
        name: HistoryDetailPage.routeName,
        page: () => HistoryDetailPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HistoryDetailController());
        })),
    GetPage(
        name: ClaimResubmitPage.routeName,
        page: () => ClaimResubmitPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HistoryDetailController());
        })),
    GetPage(
        name: ClaimResubmitConfirmationPage.routeName,
        page: () => ClaimResubmitConfirmationPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => HistoryDetailController());
        })),
    GetPage(
        name: ClaimApprovalListPage.routeName,
        page: () => ClaimApprovalListPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ClaimApprovalListController());
        })),
    GetPage(
        name: ClaimDetailApprovalPage.routeName,
        page: () => ClaimDetailApprovalPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => ClaimDetailApprovalController());
          Get.lazyPut(() => ProfileController());
        })),
    GetPage(
        name: SpecialApprovalListPage.routeName,
        page: () => SpecialApprovalListPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SpecialApprovalListController());
        })),
    GetPage(
        name: SpecialDetailApprovalPage.routeName,
        page: () => SpecialDetailApprovalPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => SpecialDetailApprovalController());
        })),
    GetPage(
        name: AdvanceRequestPage.routeName,
        page: () => AdvanceRequestPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AdvanceRequestController());
        })),
    GetPage(
        name: AdvanceRequestListPage.routeName,
        page: () => AdvanceRequestListPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AdvanceRequestListController());
        })),
    GetPage(
        name: AdvanceDetailPage.routeName,
        page: () => AdvanceDetailPage(),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => AdvanceDetailController());
        })),
  ];
}
