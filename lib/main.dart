import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:appspector/appspector.dart';
import 'package:travel_claim/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_claim/views/style/colors.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_claim/firebase_options.dart';
import 'package:travel_claim/modules/splash/splash_page.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:travel_claim/modules/notification/controllers/firebase_notification_controller.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await FirebaseNotificationController().initialize();
  runAppSpector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onVerticalDragStart],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        disableBackButton: true,
        closeOnBackButton: false,
        overlayWholeScreen: true,
        overlayWidgetBuilder: (progress) {
          return Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 120,
              color: Colors.white,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Uploading file...',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor, fontSize: 16),
                  )
                ],
              ),
            ),
          );
        },
        child: GetMaterialApp(
          title: 'myClaim',
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: SplashPage.routeName,
          getPages: Routes.getPages,
          builder: FToastBuilder(),
        ),
      ),
    );
  }
}

void runAppSpector() {
  final config = Config()
    ..iosApiKey = "Your iOS API_KEY"
    ..androidApiKey =
        "android_Y2M2YzVjMmUtYjUxOC00MzA4LWE5ZDEtNDk4MjZiYTcwMWQ2";

  // If you don't want to start all monitors you can specify a list of necessary ones
  config.monitors = [Monitors.http, Monitors.logs, Monitors.screenshot];

  AppSpectorPlugin.run(config);
}
