import 'dart:convert';

import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Language/app_localizations.dart';
import 'package:awc_complaints_app/Model/ComplaintDetaileResponse.dart';
import 'package:awc_complaints_app/Screens/ComplaintStatusScreen.dart';
import 'package:awc_complaints_app/Screens/FullScreenImage.dart';
import 'package:awc_complaints_app/Utill/CircularProgress.dart';
import 'package:awc_complaints_app/Utill/CommonUtil.dart';
import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:awc_complaints_app/Utill/SessionManager.dart';
import 'package:awc_complaints_app/Utill/UserDataConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplaintDetails extends StatefulWidget {
  String complaint_id;
  String complainStatusText;
  String complaintStatus;

  ComplaintDetails(this.complaint_id, this.complainStatusText, this.complaintStatus);

  @override
  _ComplaintDetailsState createState() => _ComplaintDetailsState(complaint_id);
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  String buildingName = "";
  String locationName = "";
  String? descrion;
  String? complaint_img;
  String? complaint_id;

 // final GlobalKey<State> _globalKey = new GlobalKey<State>();

   _ComplaintDetailsState(this.complaint_id);
//  _ComplaintDetailsState( this.complaint_id);

  Future? futureDetailApi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      //complaint_id=widget.complaint_id;
      futureDetailApi = complaintDetails(user_id!,widget.complaint_id);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('click');
      print(message.notification!.title);
      print(message.notification!.body);
      print(message.data.toString());
      print(message.data['action_id']);
      // var res=   jsonEncode(message.data);
      FlutterAppBadger.updateBadgeCount(-1);
      print('Dashboard');
      if (message.data['action_id'] != null) {
        ComplaintStatusScreen(message.data['action_id'].toString(),'')
            .launch(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //  fetchComplaintDetailApi();
    var appLocalization = AppLocalizations.of(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0.0,
            leadingWidth: 25,
            centerTitle: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: MyColors.lightBlue,
              ),
              onPressed: () {
                Navigator.pop(context,"");
              },
            ),
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Aduan",
                    style: TextStyle(color: MyColors.lightBlue, fontSize: 30)),
                Container(
                  height: 28,
                  decoration: new BoxDecoration(
                    color: widget.complaintStatus == "1"
                        ? orangeColor
                        : widget.complaintStatus == "2"
                            ? openColorCode
                            : closeColorCode,
                    borderRadius: new BorderRadius.circular(
                      20.0,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                      child: Text(
                        widget.complainStatusText,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            )),
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Image.asset(
                  'assets/frame_img.png',
                  width: MediaQuery.of(context).size.width,
                )),
            FutureBuilder(
              future: futureDetailApi,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgress();
                  default:
                    if (snapshot.hasData) {
                      ComplaintDetaileResponse response = snapshot.data;
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FullScreenImage(response.data!.complaintDetails!.image.toString())));
                              },
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          response.data!.complaintDetails!.image.toString(),
                                      placeholder: (context, url) =>
                                          new Center(child: CircularProgress()),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),

                                    //   Image.network(
                                    //       response.data.complaintDetails.image,
                                    //       height: 200,
                                    //       width: double.infinity,
                                    //       fit: BoxFit.cover),
                                  )),
                            ),
                            Visibility(
                                visible: response.data!.complaintDetails!
                                            .referenceNo ==
                                        ""
                                    ? false
                                    : true,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Text(
                                    //appLocalization.translate('building_name');
                                    "Nombor aduan",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.blueColor),
                                  ),
                                )),
                            Visibility(
                              visible:
                                  response.data!.complaintDetails!.referenceNo ==
                                          ""
                                      ? false
                                      : true,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                child: Text(
                                  response.data!.complaintDetails!.referenceNo.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                              child: Text(
                                //appLocalization.translate('building_name');
                                "Nama Bangunan",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.blueColor),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              child: Text(
                                response.data!.complaintDetails!.buildingName.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                              child: Text(
                                //appLocalization.translate('building_name');
                                "Lokasi aduan",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.blueColor),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              child: Text(
                                response
                                    .data!.complaintDetails!.locationOfComplaint.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                              child: Text(
                                //appLocalization.translate('details_of_complaint');
                                "Perincian aduan",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.blueColor),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
                              child: Text(
                                response.data!.complaintDetails!.description.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 80),
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
                                  Navigator.pop(context,"");
                                });
                              },
                            )),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                }
              },
            )
          ],
        ));
  }
}
