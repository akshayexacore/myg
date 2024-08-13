import 'package:get/get.dart';
import 'package:travel_claim/modules/claim/claim_confirmation_page.dart';
import 'package:travel_claim/modules/claim/claim_page.dart';
import 'package:travel_claim/modules/claim/controller/claim_controller.dart';
import 'package:travel_claim/modules/drafts/controllers/draft_controller.dart';
import 'package:travel_claim/modules/drafts/draft_page.dart';
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
  ];
}
