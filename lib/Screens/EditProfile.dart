import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Utill/CommonUtil.dart';
import 'package:awc_complaints_app/Utill/SessionManager.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String fullName = "";
  String building_name = "";
  String location = "";
  String image = "";
  final TextEditingController mobile_controler = new TextEditingController();
  final TextEditingController email_controler = new TextEditingController();
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
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          title: (Text(
            "Profile",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          )),
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
                // Align(
                //   widthFactor: 100,
                //   alignment: Alignment.center,
                //   child: Stack(
                //     children: <Widget>[
                //       Container(
                //         padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
                //         child: CircleAvatar(
                //           backgroundImage: NetworkImage('$image'),
                //           radius: 50,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                    child: Text(
                      '$fullName',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                    child: Text(
                      "Mobile",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 5.0),
                    child: TextField(
                      controller: mobile_controler,
                      decoration: new InputDecoration(
                          // border: new OutlineInputBorder(
                          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
                          // ),

                          ),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                    child: TextField(
                      controller: email_controler,
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
                    child: TextButton(
                      // icon: Icon(
                      //   Icons.verified,
                      //   color: Colors.white,
                      // ),
                      child: Text("Save Prifile"),
                      //  label: Text("Save Prifile"),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.blue[300]!)),
                          disabledBackgroundColor: Colors.grey,
                          textStyle: TextStyle(color: Colors.white),
                          backgroundColor: Colors.blue),

                      onPressed: () {
                        setState(() {
                          SessionManeger.getDetails("user_id").then((value) {
                            print(value);
                            saveDetailApi(value.toString());
                          });
                        });
                      },
                    )),
                // Container(
                //     height: 50,
                //     width: double.infinity,
                //     padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                //     child: FlatButton(
                //       // shape: RoundedRectangleBorder(
                //       //     borderRadius: BorderRadius.circular(10),
                //       //     side: BorderSide(color: Colors.blue[300])),
                //       disabledColor: Colors.grey,
                //       textColor: Colors.blue,
                //
                //       child: Text(
                //         'Logout',
                //         style: TextStyle(fontSize: 20),
                //       ),
                //       onPressed: () {
                //         setState(() {
                //           // logoutApi();
                //         });
                //       },
                //     )),
              ],
            ),
          ],
        ));
  }

  void callUserDatileAPi(String user_id) {
    try {
      CommonUtil.showLoadingDialog(context, _globalKey);
      ApiService.userDetails(user_id).then((value) {
        if (value.status == "success") {
          Navigator.of(_globalKey.currentContext!, rootNavigator: false).pop();
          // CommonUtil.showDialogMsg(context, value.message);
          setState(() {
            this.fullName = value.data!.fullName.toString();
            mobile_controler.text = value.data!.mobile.toString();
            email_controler.text = value.data!.email.toString();
            this.building_name = value.data!.buildingName.toString();
            this.image = value.data!.image.toString();
            // this.location=value.data.l
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

  void saveDetailApi(String user_id) {
    try {
      CommonUtil.showLoadingDialog(context, _globalKey);
      ApiService.edit_profile(
              user_id, mobile_controler.text, email_controler.text)
          .then((value) {
        if (value.status == "success") {
          Navigator.of(_globalKey.currentContext!, rootNavigator: false).pop();
          CommonUtil.showDialogMsg(context, value.message.toString());
          SessionManeger.saveDetailes("mobile", value.data!.mobile.toString());
          SessionManeger.saveDetailes("email", value.data!.email.toString());
        } else if (value.status == "error") {
          Navigator.of(_globalKey.currentContext!, rootNavigator: false).pop();
          CommonUtil.showDialogMsg(context, value.message.toString());
        }
      });
    } catch (error) {
      Navigator.of(_globalKey.currentContext!, rootNavigator: false).pop();
    }
  }
}
