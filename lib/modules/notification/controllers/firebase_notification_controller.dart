import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:travel_claim/modules/landing/controllers/landing_controller.dart';
import 'package:travel_claim/views/style/colors.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  /*showNotification(
    message.data.hashCode,
    message.data['title'],
    message.data['body'],
  );*/
}

void showNotification(int hashCode, String title, String body,
    {Map<String, dynamic>? payload}) {
  flutterLocalNotificationsPlugin.show(
      hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            color: primaryColor,
            enableLights: channel.enableLights,
            channelDescription: channel.description,
            sound: channel.sound,
            playSound: channel.playSound,
            enableVibration: channel.enableVibration,
            importance: channel.importance,
            icon: "@drawable/ic_notification",
            //largeIcon: const DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
            styleInformation: const MediaStyleInformation(
                htmlFormatContent: true, htmlFormatTitle: true)),
      ),
      payload: json.encode(payload));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'main_channel', // id
    'All Myg Travel claim Notifications', // title
    description: 'Myg Travel claim Default Notifications',
    enableLights: true,
    playSound: true,
    enableVibration: true,
    importance: Importance.max,
    showBadge: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FirebaseNotificationController {
  Future<void> initialize() async {
    await Firebase.initializeApp();
    _requestPermissions();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    // handle when app in active state
    foregroundNotification();

    // handle when app running in background state
    backgroundNotification();

    // handle when app completely closed by the user
    //terminateNotification();
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_notification');
    var initializationSettingsIOS = const DarwinInitializationSettings(
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          if (details.payload != null) {
            try {
              // todo actions on click on a notifications
            } catch (_) {}
          }
        },
        );
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
      await androidImplementation?.requestNotificationsPermission();
    }
  }

  foregroundNotification() async {
   try{
     await FirebaseMessaging.instance.getToken();
   }catch(_){}
    FirebaseMessaging.onMessage.listen(
      (message) async {
        print(message.data);
        if(Get.isRegistered<LandingController>()) {
          Get.find<LandingController>().getNotificationCount();
        }
        showNotification(message.notification!.hashCode,
            message.notification!.title!, message.notification!.body!,
            payload: message.data);
      },
    );
  }

backgroundNotification() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        if(Get.isRegistered<LandingController>()) {
          Get.find<LandingController>().getNotificationCount();
        }
      },
    );
  }

}
