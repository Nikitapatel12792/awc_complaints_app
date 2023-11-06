import 'dart:convert';
import 'dart:io';

import 'package:awc_complaints_app/Screens/ComplaintStatusScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:awc_complaints_app/Notifications/PushNotification.dart';
import 'package:awc_complaints_app/Screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:nb_utils/nb_utils.dart';

import 'Utill/Constant.dart';

/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
 AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
 FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

 String Notiid='';
 int badgeCount=0;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
     // 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  registerNotification();

  if (Platform.isAndroid) {
    print('android');
    device_type = 'Android';
  } else if (Platform.isIOS) {
    print('ios');
    device_type = 'Ios';
  }

  runApp(MyApp());
}

void registerNotification() async {
  // 1. Initialize the Firebase app
  await Firebase.initializeApp();
  FirebaseMessaging _messaging;
  // 2. Instantiate Firebase Messaging
  _messaging = FirebaseMessaging.instance;

  // 3. On iOS, this helps to take the user permissions
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    _messaging
        .getToken()
        .then((value) => {
      print('takoen '+value!),
      device_token = value, print(value)
    });

  } else {
    print('User declined or has not accepted permission');
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: "e-Aduan",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.lime,
            //  buttonColor: Colors.blue,
              textTheme: TextTheme(
                headline1:
                    TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              )),
          routes: {
            '/': (context) => SplashScreen(),
            '/complaintStatusScreen': (context) => ComplaintStatusScreen(Notiid, '1'),
          },
      )
    );
  }
}
//
// int _messageCount = 0;
//
// /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
// String constructFCMPayload(String token) {
//   _messageCount++;
//   return jsonEncode({
//     'token': token,
//     'data': {
//       'via': 'FlutterFire Cloud Messaging!!!',
//       'count': _messageCount.toString(),
//     },
//     'notification': {
//       'title': 'Hello FlutterFire!',
//       'body': 'This notification (#$_messageCount) was created via FCM!',
//     },
//   });
// }
