import 'dart:developer';

import 'package:awc_complaints_app/ApiCall/ApiCall.dart';

import 'package:awc_complaints_app/Screens/AllComplaints.dart';

import 'package:awc_complaints_app/Screens/MainDashboardScreen.dart';

import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:awc_complaints_app/Utill/UserDataConstant.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class Home extends StatefulWidget {
  int type;

  // static const routeName = '/home';

  Home(this.type);

  @override
  _Home createState() => _Home();

  void getNotification1() {
    _Home().getNotification();
  }
}

class _Home extends State<Home>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  String is_new_notification = "0";


 int? newScreen;

  int selectedIndex = 0;

  List<Widget> pages = [
    MainDashboardScreen(),
    // StepsTest(),
    AllComplaints(),
    // AthleteProfileFragment(),
  ];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();


  }

  Future<void> init() async {
    getNotification();

    setState(() {});
  }

  void updateNotificationStaic() {
    log('check');
    setState(() {
      is_new_notification = "1";
    });
  }

  void getNotification() async {
    await check_new_notification(user_id!).then((res) async {
      log(res.status!);
      if (res.status!.contains("success")) {
        setState(() {});
        log('check');
        is_new_notification = res.data!.unreadNotifications.toString();
        log(res.data!.unreadNotifications.toString());
      } else {}

      // toast(res.status);
    }).catchError((error) {});
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getNotification();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    getNotification();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
          getNotification();
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 16,
        showSelectedLabels: true,
        selectedItemColor: MyColors.blueColor,
        showUnselectedLabels: true,
        selectedFontSize: 16,
        items: [
          BottomNavigationBarItem(
            label: 'Aduan',
            icon: Image.asset('assets/bottom_home.png',
                width: 25,
                height: 25,
                color: Theme.of(context).textTheme.headline6!.color),
            activeIcon: Container(
              padding: EdgeInsets.all(0),
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //     shape: BoxShape.circle, color: primaryColor.withOpacity(0.2)),
              child: Image.asset('assets/bottom_home.png',
                  width: 25, height: 25, color: MyColors.blueColor),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Senarai Aduan',
            icon: Stack(
              children: [
                Image.asset('assets/bottom_complaint.png',
                    width: 25,
                    height: 25,
                    color: Theme.of(context).textTheme.headline6!.color),
                Visibility(
                    visible: is_new_notification == '1',
                    child: Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              color: Colors.red[500],
                              border: Border.all(
                                color: Colors.red[500]!,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ))),
              ],
            ),
            activeIcon: Container(
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
                // decoration: BoxDecoration(
                //     shape: BoxShape.circle, color: primaryColor.withOpacity(0.2)),
                child: Stack(
                  children: [
                    Image.asset('assets/bottom_complaint.png',
                        width: 25, height: 25, color: MyColors.blueColor),
                    Visibility(
                        visible: is_new_notification == '1',
                        child: Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  color: Colors.red[500],
                                  border: Border.all(
                                    color: Colors.red[500]!,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                            ))),
                  ],
                )

                // Image.asset('assets/bottom_complaint.png',
                //     width: 25, height: 25, color: MyColors.blueColor),
                ),
          ),
        ],
      ),
      body: SafeArea(child: pages[selectedIndex]),
    );
  }
}
