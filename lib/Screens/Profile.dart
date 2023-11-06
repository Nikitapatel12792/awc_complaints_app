import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Model/UserDetailResponse.dart';
import 'package:awc_complaints_app/Screens/EditProfile.dart';
import 'package:awc_complaints_app/Screens/Login.dart';
import 'package:awc_complaints_app/Utill/CommonUtil.dart';
import 'package:awc_complaints_app/Utill/ConnectionCheck.dart';
import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:awc_complaints_app/Utill/SessionManager.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String fullName = "";
  String email = "";
  String mobile = "";
  String building_name = "";
  String image = "";

  final GlobalKey<State> _globalKey = new GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SessionManeger.getDetails("user_id").then((value) {
      print(value);
      callUserDatileAPi(value!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Profil',
          // appLocalization.translate('list_of_complaints'),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, color: MyColors.lightBlue),
        ),
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
        //       })
        // ],
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/frame_img.png',
                width: MediaQuery.of(context).size.width,
              )),
          ListView(
            children: <Widget>[
              Align(
                widthFactor: 100,
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('$image'),
                        radius: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
                  child: Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                  child: Text(
                    '$fullName',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
                  child: Text(
                    "Mobile",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                  child: Text(
                    '$mobile',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
                  child: Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                  child: Text(
                    '$email',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
                  child: Text(
                    "Building",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  )),
              Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 50.0),
                  child: Text(
                    '$building_name',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text(
                      "Edit Profile",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: MyColors.primaryColor)),
                      disabledBackgroundColor: Colors.grey,
                      textStyle: TextStyle(color: Colors.white),
                      backgroundColor: MyColors.primaryColor,
                    ),

                    // child: Text(
                    //   'Edit Profile',
                    //   style: TextStyle(fontSize: 20),
                    // ),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()));
                      });
                    },
                  )),
              Container(
                  height: 50,
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextButton(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //     side: BorderSide(color: Colors.blue[300])),

                    style: TextButton.styleFrom(

                      disabledBackgroundColor: Colors.grey,
                      textStyle: TextStyle(color: Colors.blue),

                    ),



                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      setState(() {
                        logoutApi();
                      });
                    },
                  )),
            ],
          )
        ],
      ),
    );
  }

  void callUserDatileAPi(String user_id) {
    try {
      CommonUtil.showLoadingDialog(context, _globalKey);
      ApiService.userDetails(user_id).then((value) {
        if (value.status == "success") {
          Navigator.of(_globalKey.currentContext!, rootNavigator: false).pop();
          //  CommonUtil.showDialogMsg(context, value.message);
          setState(() {
            this.fullName = value.data!.fullName.toString();
            this.mobile = value.data!.mobile.toString();
            this.email = value.data!.email.toString();
            this.building_name = value.data!.buildingName.toString();
            this.image = value.data!.image.toString();
          });

          print("tata" + value.message.toString());
        } else if (value.status == "error") {
          Navigator.of(_globalKey.currentContext!, rootNavigator: false).pop();
          CommonUtil.showDialogMsg(context, value.message.toString());
          print("tata" + value.message.toString());
        }
      });
    } catch (error) {
      Navigator.of(_globalKey.currentContext!, rootNavigator: false).pop();
      //    CommonUtil.showDialogMsg(context, value.message);
      print("tata" + error.toString());
    }
  }

  void logoutApi() {
    try {
      CommonUtil.showLoadingDialog(context, _globalKey);
      SessionManeger.getDetails("user_id").then((value) {
        ApiService.logout(value!).then((value) {
          if (value.status == "success") {
            SessionManeger.logoutSP();
            print("tata " + value.message!);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                ModalRoute.withName("/login"));
          } else if (value.status == "error") {
            print("tata " + value.message!);
          }
        });
      });
    } catch (error) {
      print("tata " + "Exception");
    }
  }
}
