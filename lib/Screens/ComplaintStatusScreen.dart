import 'dart:convert';

import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Language/app_localizations.dart';
import 'package:awc_complaints_app/Model/NotificationDetailsResponse.dart';
import 'package:awc_complaints_app/Screens/ComplaintDetails.dart';
import 'package:awc_complaints_app/Screens/Home.dart';
import 'package:awc_complaints_app/Utill/CircularProgress.dart';
import 'package:awc_complaints_app/Utill/ConnectionCheck.dart';
import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:awc_complaints_app/Utill/UserDataConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

class ComplaintStatusScreen extends StatefulWidget {
  String routeName = '/complaintStatusScreen';

  //static const routeName = '/complaintStatusScreen';
  String id;
  String type;

  ComplaintStatusScreen(this.id, this.type);

  @override
  _ComplaintStatusScreenState createState() => _ComplaintStatusScreenState();
}

class _ComplaintStatusScreenState extends State<ComplaintStatusScreen> {
  Future<NotificationDetailsResponse>? _futureNotificationDetails;

  @override
  void initState() {
    super.initState();
    FlutterAppBadger.updateBadgeCount(-1);

    setState(() {
      _futureNotificationDetails = notification_detailsApi(user_id!, widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            leadingWidth: 25,
            elevation: 0.0,
            centerTitle: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: MyColors.lightBlue,
              ),
              onPressed: () {
                if (widget.type == '1') {
                  Home(0).launch(context, isNewTask: true);
                } else {
                  Navigator.pop(context, "1");
                }
              },
            ),
            backgroundColor: Colors.white,
            title: Text("Pemberitahuan",
                style: TextStyle(color: MyColors.lightBlue, fontSize: 30)),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                    bottom: 0,
                    child: Image.asset(
                      'assets/frame_img.png',
                      width: MediaQuery.of(context).size.width,
                    )),
                FutureBuilder<NotificationDetailsResponse>(
                  future: _futureNotificationDetails,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return CircularProgress();
                      default:
                        if (snapshot.hasData) {
                          NotificationDetailsResponse response = snapshot.data;
                          if (response.status == "success") {
                            return SingleChildScrollView(
                              child: Center(
                                  child: Column(
                                children: <Widget>[
                                  Container(
                                    // color: Colors.grey[200],
                                    padding: EdgeInsets.all(50),
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        CachedNetworkImage(
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                          imageUrl: response.data!
                                              .notifications!.complaintImage
                                              .toString(),
                                          placeholder: (context, url) =>
                                              new Center(
                                                  child: CircularProgress()),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        ),
                                        SizedBox(height: 40.0),
                                        Text(
                                          parse(response.data!.notifications!
                                                  .complaintTitle)
                                              .documentElement!
                                              .text
                                          // 'Terima kasih',
                                          ,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: MyColors.blueColor,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          parse(response.data!.notifications!
                                                  .description)
                                              .documentElement!
                                              .text,
                                          style: TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        Container(
                                          // color: MyColors.blueColor,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                new BorderRadius.circular(20.0),
                                            color: MyColors.blueColor,
                                          ),
                                          child: Text(
                                            response.data!.notifications!
                                                .complaintNumber
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: 50,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 0.0),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            disabledBackgroundColor:
                                                Colors.grey,
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                            backgroundColor:
                                                MyColors.primaryColor),
                                        child: Text(
                                          // appLocalization.translate('key');
                                          'Lihat butiran aduan',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ComplaintDetails(
                                                          response
                                                              .data!
                                                              .notifications!
                                                              .complaintId
                                                              .toString(),
                                                          response
                                                              .data!
                                                              .notifications!
                                                              .complaintStatusTxt.toString(),
                                                          response
                                                              .data!
                                                              .notifications!
                                                              .complaintStatusTxt.toString())));
                                        },
                                      )),
                                  SizedBox(height: 30),
                                  Center(
                                      child: TextButton(

                                    child: Text(
                                      //  appLocalization.translate('back');
                                      'Kembali',
                                      style: TextStyle(
                                          fontSize: 22,
                                          decoration: TextDecoration.underline,
                                          color: MyColors.lightBlue),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (widget.type == '1') {
                                          Home(0)
                                              .launch(context, isNewTask: true);
                                        } else {
                                          finish(context);
                                        }
                                      });
                                    },
                                  )),
                                ],
                              )),
                            );
                          } else {
                            return Center(
                              child: Text(response.message.toString()),
                            );
                          }
                        } else {
                          return Center(
                            child: Text('Something Went wrong'),
                          );
                        }
                    }
                  },
                ),
              ],
            ),
          )),
      onWillPop: () async {
        if (widget.type == '1') {
          Home(0).launch(context, isNewTask: true);
        } else {
          finish(context);
        }

        // Navigator.pop(context, "1");
        return false;
      },
    );
  }

  Future<NotificationDetailsResponse> notification_detailsApi(
    String user_id,
    String notification_id,
  ) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'notification_details'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': user_id,
        'notification_id': notification_id,
        'apikey': URLS.ApiKey
      }),
    );
    print(response.body);
    print("userid " + user_id);
    print("notification_id " + notification_id);

    print(response.request!.url);
    if (response.statusCode == 200) {
      NotificationDetailsResponse notificationDetailsResponse =
          NotificationDetailsResponse.fromJson(jsonDecode(response.body));
      return notificationDetailsResponse;
    } else {
      throw Exception("Failed to Load");
    }
  }
}
