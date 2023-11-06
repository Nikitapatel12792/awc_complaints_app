import 'dart:convert';
import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Model/NotificationResponse.dart';
import 'package:awc_complaints_app/Screens/ComplaintStatusScreen.dart';
import 'package:awc_complaints_app/Utill/CircularProgress.dart';
import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:awc_complaints_app/Utill/UserDataConstant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<State> globalKey = new GlobalKey<State>();

  final items = List<String>.generate(30, (i) => "Item $i");
  List? notificationList;

  Future ?_futureNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterAppBadger.removeBadge();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('click');
      print(message.notification!.title);
      print(message.notification!.body);
      print(message.data.toString());
      print(message.data['action_id']);
      // var res=   jsonEncode(message.data);

      print('Dashboard');
      if (message.data['action_id'] != null) {
        ComplaintStatusScreen(message.data['action_id'].toString(),'0')
            .launch(context);
      }
    });


    setState(() {
      _futureNotification = notifications(user_id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 25,
          centerTitle: false,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: MyColors.lightBlue,
            ),
            onPressed: () {
              Navigator.pop(context, "");
            },
          ),
          backgroundColor: Colors.white,
          title: Text('Pemberitahuan',
              style: TextStyle(color: MyColors.lightBlue, fontSize: 30)),
          // actions: <Widget>[
          //   IconButton(
          //       icon: Icon(
          //         Icons.notifications_rounded,
          //         size: 25,
          //         color: MyColors.lightBlue,
          //       ),
          //       onPressed: () {
          //         Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => NotificationScreen()));
          //       }
          //       )
          // ],
        ),
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Image.asset(
                  'assets/frame_img.png',
                  width: MediaQuery.of(context).size.width,
                )),
            FutureBuilder(
              future: _futureNotification,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgress();
                  default:
                    if (snapshot.hasData) {
                      NotificationResponse notificationResponse = snapshot.data;
                      return notificationResponse.status == "success"
                          ? ListView.builder(
                              itemCount:
                                  notificationResponse.data!.notifications ==
                                          null
                                      ? 0
                                      : notificationResponse
                                          .data!.notifications!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8.0),
                                    decoration: BoxDecoration(
                                        color: MyColors.lightGreyColor,
                                        border: Border.all(
                                            color: MyColors.greyColor),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              notificationResponse
                                                  .data!
                                                  .notifications![index]
                                                  .complaintDate.toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: MyColors.blueColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                            Container(
                                              height: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: notificationResponse
                                                      .data!
                                                      .notifications![
                                                  index]
                                                      .complaintStatus ==
                                                      1
                                                      ? orangeColor
                                                      : notificationResponse
                                                      .data!
                                                      .notifications![
                                                  index]
                                                      .complaintStatus ==
                                                      2
                                                      ? openColorCode
                                                      : closeColorCode,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                                ),

                                                onPressed: () {
                                                  // if (notificationResponse.data.notifications[index].complaintStatus == "2") {
                                                  // } else {
                                                  goToSecondScreen(
                                                      notificationResponse
                                                          .data!
                                                          .notifications![index]
                                                          .id
                                                          .toString(),
                                                      );
                                                  //}
                                                },
                                                child: Text(
                                                  notificationResponse
                                                      .data!
                                                      .notifications![index]
                                                      .complaintStatusTxt.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          parse(notificationResponse
                                                  .data!
                                                  .notifications![index]
                                                  .complaintText)
                                              .documentElement!
                                              .text.toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ));
                              })
                          : Center(
                              child: Text(
                                notificationResponse.message.toString(),
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                    } else {
                      return Center(
                        child: Text('Somthing went wrong'),
                      );
                    }
                }
              },
            ),
          ],
        ));
  }

  void goToSecondScreen(
      String id,
    ) async {
    var result = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new ComplaintStatusScreen(
              id,'0'
              ),
        ));
    print(result);
    setState(() {
      _futureNotification = notifications(user_id!);
    });
  }
}
