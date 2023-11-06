import 'dart:convert';

import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Language/app_localizations.dart';
import 'package:awc_complaints_app/Model/AllComplaintsModel.dart';
import 'package:awc_complaints_app/Model/MasterResponse.dart';
import 'package:awc_complaints_app/Model/MyComplaintsResponse.dart';
import 'package:awc_complaints_app/Model/NotificationDetailsResponse.dart';

import 'package:awc_complaints_app/Screens/ComplaintDetails.dart';
import 'package:awc_complaints_app/Screens/ComplaintStatusScreen.dart';
import 'package:awc_complaints_app/Screens/Home.dart';
import 'package:awc_complaints_app/Screens/NotificationScreen.dart';
import 'package:awc_complaints_app/Utill/CircularProgress.dart';
import 'package:awc_complaints_app/Utill/CommonUtil.dart';
import 'package:awc_complaints_app/Utill/ConnectionCheck.dart';
import 'package:awc_complaints_app/Utill/Constant.dart';
import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:awc_complaints_app/Utill/SessionManager.dart';
import 'package:awc_complaints_app/Utill/UserDataConstant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class AllComplaints extends StatefulWidget {
  static const routeName = '/allcomplaints';

  @override
  _AllComplaintsState createState() => _AllComplaintsState();
}

class _AllComplaintsState extends State<AllComplaints> {
   Home? home;

  final GlobalKey<State> _globalKey = new GlobalKey<State>();
  String is_new_notification = "0";

  ScrollController? controller;

  Future? _futureMasterApi;
  Future<MyComplaintsResponse>? _futureMyCompalint;
  String filter_name = "SEMUA";

  String filter_id = "";
  List<ComplaintLists> complaintListsmain = [];
  String page_number = "";
  bool? CheckConnection;

  void updateNotification() {
    home!.getNotification1();
  }

  @override
  void initState() {
    super.initState();
    FlutterAppBadger.removeBadge();
    badgeCount=0;
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('click');
      print(message.notification!.title);
      print(message.notification!.body);
      print(message.data.toString());
      print(message.data['action_id']);
      // var res=   jsonEncode(message.data);



       if (message.data['action_id'] != null) {
      ComplaintStatusScreen(message.data['action_id'].toString(),'0')
          .launch(context);
      }
    });




    home = new Home(0);
    init();
    setState(() {
      _futureMyCompalint = my_complaint(user_id!, filter_id, page_number);
      _futureMasterApi = masters();
    });
    controller = new ScrollController()..addListener(_scrollListener);



    ConnectionCheck.check().then((value) => {CheckConnection = value});
  }

  Future<void> init() async {
    getNotification();

    setState(() {});
  }

  void getNotification() async {
    //  isDashboardDataLoaded = false;
    // appStore.setLoading(true);
    await check_new_notification(user_id!).then((res) async {
      log(res.status);
      if (res.status!.contains("success")) {
        is_new_notification = res.data!.unreadNotifications.toString();

        setState(() {});
      } else {}

      // toast(res.status);
    }).catchError((error) {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.removeListener(_scrollListener);
  }

  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  List<ComplaintLists> list = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());

    // _futureMyCompalint = my_complaint(user_id, filter_id, "2");
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    //  var appLocalization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: false,

        title: Text(
          'Senarai aduan',
          // appLocalization.translate('list_of_complaints'),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, color: MyColors.lightBlue),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications_rounded,
                size: 25,
                color: MyColors.lightBlue,
              ),
              onPressed: () {
                goToSecondScreen();
              }).visible(is_new_notification == "0"),
          Container(
            child: new RawMaterialButton(
              elevation: 0.0,
              child: Image.asset(
                'assets/notification_bell.png',
                height: 25,
                width: 25,
              ),
              onPressed: () {
                goToSecondScreen();
              },
            ),
          ).visible(is_new_notification == "1"),
        ],
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status: ",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 150,
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: MyColors.lightGreyColor,
                        border: Border.all(color: MyColors.greyColor),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        filterBottomSheet();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            filter_name,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer:
           // CustomFooter(builder: (BuildContext context, LoadStatus? mode) { widget? body; },)
        CustomFooter(
          builder: (BuildContext? context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Image.asset(
                  'assets/frame_img.png',
                  width: MediaQuery.of(context).size.width,
                )),
            FutureBuilder<MyComplaintsResponse>(
              future: _futureMyCompalint,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgress();
                  default:
                    if (snapshot.hasData) {
                      MyComplaintsResponse response = snapshot.data;
                      if (response.status == "success") {
                        complaintListsmain.addAll(response.data!.complaintLists!);
                        log("size " + complaintListsmain.length.toString());
                        page_number =
                            response.data!.pagination!.nextPage.toString();
                        if (response.data!.complaintLists!.isEmpty) {
                          return Center(
                            child: Text(
                              'Tiada rekod',
                              style: TextStyle(fontSize: 18),
                              // appLocalization.translate('no_complaint_available')
                            ),
                          );
                        } else {
                          return ListView.builder(
                              controller: controller,
                              itemCount: response.data!.complaintLists != null
                                  ? response.data!.complaintLists!.length
                                  : 0,
                              itemBuilder: (context, index) {
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
                                              //list[index].complaintDate,
                                              response
                                                  .data!
                                                  .complaintLists![index]
                                                  .complaintDate.toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: MyColors.blueColor,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 30,
                                              child: TextButton(
                                                style: TextButton.styleFrom(
                                                  primary: Colors.white,
                                                  minimumSize: Size(88, 44),
                                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                                  backgroundColor: response
                                                      .data!
                                                      .complaintLists![
                                                  index]
                                                      .complaintStatus ==
                                                      1
                                                      ? orangeColor
                                                      : response
                                                      .data!
                                                      .complaintLists![
                                                  index]
                                                      .complaintStatus ==
                                                      2
                                                      ? openColorCode
                                                      : closeColorCode,
                                                ),


                                                onPressed: () {
                                                  goToDetailPage(
                                                      response
                                                          .data!
                                                          .complaintLists![index]
                                                          .id.toString()
                                                          .toString(),
                                                      response
                                                          .data!
                                                          .complaintLists![index]
                                                          .complaintStatusTxt.toString(),
                                                      response
                                                          .data!
                                                          .complaintLists![index]
                                                          .complaintStatus
                                                          .toString());

                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) => ComplaintDetails(
                                                  //             response
                                                  //                 .data
                                                  //                 .complaintLists[
                                                  //                     index]
                                                  //                 .id,
                                                  //             response
                                                  //                 .data
                                                  //                 .complaintLists[
                                                  //                     index]
                                                  //                 .complaintStatusTxt,
                                                  //             response
                                                  //                 .data
                                                  //                 .complaintLists[
                                                  //                     index]
                                                  //                 .complaintStatus)));
                                                },
                                                child: Text(
                                                  response
                                                      .data!
                                                      .complaintLists![index]
                                                      .complaintStatusTxt.toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          response.data!.complaintLists![index]
                                              .description.toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ));
                              });
                        }
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
            )
          ],
        ),

        // ListView.builder(
        //   itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
        //   itemExtent: 100.0,
        //   itemCount: items.length,
        // ),
      ),
    );
  }

  void filterBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState
                  /*You can rename this!*/) {
            return Container(
                color: Colors.transparent,
                //could change this to Color(0xFF737373),
                //so you don't have to change MaterialApp canvasColor
                height: 240,
                child: FutureBuilder(
                  future: _futureMasterApi,
                  builder: (BuildContext contex, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return CircularProgress();
                      default:
                        if (snapshot.hasData) {
                          MasterResponse masterResponse = snapshot.data;
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              child: ListView.builder(
                                  itemCount: masterResponse
                                              .data!.complaintStatuslists !=
                                          null
                                      ? masterResponse
                                          .data!.complaintStatuslists!.length
                                      : 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            this.setState(() {
                                              filter_name = masterResponse
                                                  .data!
                                                  .complaintStatuslists![index]
                                                  .name.toString();
                                              _futureMyCompalint = my_complaint(
                                                  user_id!,
                                                  masterResponse
                                                      .data!
                                                      .complaintStatuslists![
                                                          index]
                                                      .id.toString(),
                                                  page_number);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              masterResponse
                                                  .data!
                                                  .complaintStatuslists![index]
                                                  .name.toString(),
                                              style: TextStyle(fontSize: 18),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                        )
                                      ],
                                    );
                                  }));
                        } else {
                          return Text(snapshot.error.toString());
                        }
                    }
                  },
                ));
          });
        });
  }

  void _scrollListener() {
    if (controller!.position.pixels == controller!.position.maxScrollExtent) {}
  }

  Future<MyComplaintsResponse> my_complaint(
      String user_id, String complaint_status, String page_number) async {
    final response = await http.post(
      Uri.parse(URLS.BASE_URL + 'my_complaint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_id': user_id,
        'complaint_status': complaint_status,
        'page_number': page_number,
        'apikey': URLS.ApiKey
      }),
    );
    print(response.body);
    print("userid " + user_id);
    print("complaint_status " + complaint_status);
    print("page_number " + page_number);

    print(response.request!.url);
    if (response.statusCode == 200) {
      MyComplaintsResponse myComplaintsResponse =
          MyComplaintsResponse.fromJson(jsonDecode(response.body));
      return myComplaintsResponse;
    } else {
      throw Exception("Failed to Load");
    }
  }







  void goToSecondScreen() async {
    var result = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new NotificationScreen(),
        ));
    print(result);
    setState(() {
      updateNotification();
      getNotification();
      _futureMyCompalint = my_complaint(user_id!, "", "");
      _futureMasterApi = masters();
    });
  }

  void goToDetailPage(
      String id, String complaintStatusTxt, String complaintStatus) async {
    var result = await Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              new ComplaintDetails(id, complaintStatusTxt, complaintStatus),
        ));
    print(result);
    setState(() {
      updateNotification();
      getNotification();
      _futureMyCompalint = my_complaint(user_id!, "", "");
      _futureMasterApi = masters();
    });
  }
}
