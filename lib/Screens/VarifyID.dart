import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Screens/Home.dart';
import 'package:awc_complaints_app/Utill/CommonUtil.dart';
import 'package:awc_complaints_app/Utill/Constant.dart';
import 'package:awc_complaints_app/Utill/SessionManager.dart';
import 'package:awc_complaints_app/Utill/UserDataConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VarifyID extends StatefulWidget {
  static const routeName = '/varify';

  @override
  _VarifyID createState() => _VarifyID();
}

class _VarifyID extends State<VarifyID> {
  final GlobalKey<State> _globalKey = new GlobalKey<State>();
  TextEditingController _password = new TextEditingController();
  bool is_visiable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              'assets/login_backgroun.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Form(
                      child: Text(
                        "E-ADUAN",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 20, 60, 20),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.topLeft,
                    child: Visibility(
                      visible: is_visiable,
                      child: Text(
                        "Invalid Please enter a valid and registered telephone number",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(45, 20, 60, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Unique ID",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: _password,
                      decoration: new InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: new OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: "Unique id",
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: 50,
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.white, width: 0.5)),
                          disabledBackgroundColor: Colors.grey,
                          textStyle: TextStyle(color: Colors.white),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),

                        child: Text(
                          'Log in',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          // setState(() {
                            LoginApiCall();
                          // });
                        },
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(60, 20, 60, 20),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: Form(
                      child: Text(
                        'If there are any problems please refer to the facility board',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void LoginApiCall() {
    CommonUtil.showLoadingDialog(context, _globalKey);
    SessionManeger.getDetails("mobile").then((value) {
      ApiService.login(value!, _password.text).then((value) {
        Navigator.of(_globalKey.currentContext!, rootNavigator: true).pop();
        print(value);
        if (value.status == "success") {
        //  print("val" + value.data.id);
          // Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
          setState(() {
            user_id = value.data!.id.toString();
            // building_name = value.data.buildingName;
            // building_id = value.data.buildingId;

            SessionManeger.saveDetailes("user_id", value.data!.id.toString());
            SessionManeger.saveDetailes("user_name", value.data!.fullName.toString());
            SessionManeger.saveDetailes("mobile", value.data!.mobile.toString());
            SessionManeger.saveDetailes("image", value.data!.image.toString());
            SessionManeger.saveDetailes("email", value.data!.email.toString());
            SessionManeger.saveDetailes(
                "building_name", value.data!.buildingName.toString());
            SessionManeger.saveDetailes("building_id", value.data!.buildingId.toString());
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home(0)),
              ModalRoute.withName("/home"));
        } else if (value.status == "error") {
          CommonUtil.showDialogMsg(context, value.message.toString());

          print("tata " + value.message.toString());
        }
      });
    });
  }
}
