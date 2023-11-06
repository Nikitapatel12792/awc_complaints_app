import 'package:awc_complaints_app/Notifications/PushNotification.dart';
import 'package:awc_complaints_app/Screens/ComplaintStatusScreen.dart';
import 'package:awc_complaints_app/Screens/Home.dart';
import 'package:awc_complaints_app/Screens/Login.dart';
import 'package:awc_complaints_app/Utill/Constant.dart';
import 'package:awc_complaints_app/Utill/SessionManager.dart';
import 'package:awc_complaints_app/Utill/UserDataConstant.dart';
import 'package:awc_complaints_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nb_utils/nb_utils.dart';


class SplashScreen extends StatefulWidget {
  String route='/SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String mesg = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SessionManeger.getDetails("user_id").then((value) {
      setState(() {
        // print("user " + value);
        user_id = value;
      });
    });


    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print(message.data.toString());
        print(message.notification.toString());
        print(message.data['action_id'].toString());
        Notiid=message.data['action_id'].toString();
        int count=int.parse(message.data['badge']);
        FlutterAppBadger.updateBadgeCount(count+1);
        Navigator.pushNamed(context, '/complaintStatusScreen',
            arguments: ComplaintStatusScreen(message.data['action_id'].toString(),'1' ));

        // Navigator.pushNamed(context, '/complaintStatusScreen',
        //     arguments: Home(1,));
      }else{
        init();
      }
    }
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;

      FlutterAppBadger.updateBadgeCount(1);

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,

            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
              //  channel!.description!,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');

      print(message.data.toString());
      print(message.notification.toString());
      print(message.data['action_id'].toString());
      Notiid=message.data['action_id'].toString();
      FlutterAppBadger.updateBadgeCount(-1);
      Navigator.pushNamed(context, '/complaintStatusScreen',
          arguments: ComplaintStatusScreen(message.data['action_id'].toString(), '1'));

    });





  }

  init() async {
    SessionManeger.getDetails("user_id").then((value) {
      setState(() {
        // print("user " + value);
        user_id = value;
      });
    });
    await Future.delayed(Duration(milliseconds: 2000));

    SessionManeger.getDetails("user_id").then((value) {
      if (value != null) {
        Home(0).launch(context, isNewTask: true);
      } else if (value == null) {
        Login().launch(context, isNewTask: true);
      }
    });
    // Home().launch(context, isNewTask: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          "assets/login_backgroun.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
