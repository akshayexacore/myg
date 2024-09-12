import 'dart:ui';

import 'package:appspector/appspector.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:travel_claim/firebase_options.dart';
import 'package:travel_claim/modules/notification/controllers/firebase_notification_controller.dart';
import 'package:travel_claim/modules/splash/splash_page.dart';
import 'package:travel_claim/routes/routes.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_claim/views/style/colors.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

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
      gestures: const [GestureType.onTap,GestureType.onVerticalDragStart],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        disableBackButton: true,
        closeOnBackButton: false,
        overlayWholeScreen: true,
        overlayWidgetBuilder: (progress) {
          return Center(
            child: Container(
              width: MediaQuery.sizeOf(context).width*0.8,
              height: 120,
              color: Colors.white,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12,),
                  Text(
                    'Uploading file...',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: textColor,fontSize: 16),
                  )
                ],
              ),
            ),
          );
        },
        child: GetMaterialApp(
          title: 'MyG Travel Claim',
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
    ..androidApiKey = "android_Y2M2YzVjMmUtYjUxOC00MzA4LWE5ZDEtNDk4MjZiYTcwMWQ2"
  ;

  // If you don't want to start all monitors you can specify a list of necessary ones
  config.monitors = [Monitors.http, Monitors.logs, Monitors.screenshot];

  AppSpectorPlugin.run(config);
}


