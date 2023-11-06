import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Screens/Home.dart';
import 'package:awc_complaints_app/Screens/SignUpScreen.dart';
import 'package:awc_complaints_app/Screens/VarifyID.dart';
import 'package:awc_complaints_app/Utill/CircularProgress.dart';
import 'package:awc_complaints_app/Utill/CommonUtil.dart';
import 'package:awc_complaints_app/Utill/ConnectionCheck.dart';
import 'package:awc_complaints_app/Utill/Constant.dart';
import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:awc_complaints_app/Utill/SessionManager.dart';
import 'package:awc_complaints_app/Utill/UpperCaseTextFormatter.dart';
import 'package:awc_complaints_app/Utill/UserDataConstant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  //static const routeName = '/login';

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _phonenoController = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _showError = false;
  bool _showSignBtn = false;
  bool _loadApi = false;
  bool isError = false;

  @override
  void initState() {
    init();
    super.initState();

    // setState(() {
    //   SessionManeger.getDetails("user_id").then((value) {
    //     // print("user_id " + value);
    //     if (value != null) {
    //       Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(builder: (context) => Home(0)),
    //           ModalRoute.withName("/home"));
    //     }
    //   });
    // });
  }

  Future<void> init() async {
    ConnectionCheck.check().then((value) {
      if (value == true) {
        setState(() {
          _loadApi = true;
        });
        CallApiBeforeLogin();
        print('conected');
      } else {
        CommonUtil.showDialogMsg(context, NoInternet);
        print('Not conected');
      }
    });
    setState(() {
      SessionManeger.getDetails("user_id").then((value) {
        // print("user_id " + value);
        if (value != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home(0)),
              ModalRoute.withName("/home"));
        }
      });
    });
  }

  void CallApiBeforeLogin() async {
    // CommonUtil.showLoadingDialog(context, _keyLoader);
    await before_login().then((res) async {
      if (res.status!.contains("success")) {
        //   Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        setState(() {
          _loadApi = false;
          if (res.data!.signupStatus == 1) {
            _showSignBtn = true;
          } else {
            _showSignBtn = false;
          }
        });
      } else {
        setState(() {
          _loadApi = false;
        });
      }

      // toast(res.status);
    }).catchError((error) {
      setState(() {
        _loadApi = false;
      });
      CommonUtil.showDialogMsg(context, Something_went_wrong);
      // toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    'assets/login_backgroun.png',
                    width: MediaQuery.of(context).size.width,
                  ),
                ),

                Positioned(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    300.height,
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      alignment: Alignment.center,
                      child: Form(
                        child: Text(
                          "e-Aduan",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _showError,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Center(
                          child: Text(
                            "Tidak sah. Sila masukkan nombor telefon yang sah dan berdaftar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(45, 20, 60, 10),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "No. Telefon",
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
                        controller: _phonenoController,
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "e.g 014198890312",
                            hintStyle: TextStyle(color: Colors.grey)),
                        // validator: (value) {
                        //   setState(() {
                        //     if (value.isEmpty) {
                        //       isError = true;
                        //     }
                        //   });
                        //   return null; //
                        //}
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(45, 20, 60, 10),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "ID",
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
                        autocorrect: false,
                        inputFormatters: [UpperCaseTextFormatter()],
                        textCapitalization: TextCapitalization.characters,
                        decoration: new InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "e.g k3khie12m".toUpperCase(),
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 50,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.white, width: 0.5)),
                              disabledBackgroundColor: Colors.grey,
                              textStyle: TextStyle(color: Colors.white),
                              backgroundColor: Theme.of(context).primaryColor),
                          child: Text(
                            'Log Masuk',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            // callMobileVerifyApi();
                            //  callLoginApi();
                            if (_phonenoController.text == "" ||
                                _password.text == "") {
                              setState(() {
                                _showError = true;
                              });
                            } else {
                              LoginApiCall();
                            }
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                        visible: _showSignBtn,
                        child: Container(
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: TextButton(

                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: Colors.white, width: 0.5)),
                                  disabledBackgroundColor: Colors.grey,
                                  textStyle: TextStyle(color: Colors.white),
                                  backgroundColor: Theme.of(context).primaryColor),



                              child: Text(
                                'Buat Akun',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()),
                                );
                              },
                            ))),
                    SizedBox(
                      height: 10,
                    ).visible(_showSignBtn),
                    Visibility(
                        visible: isError,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(60, 20, 60, 20),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          alignment: Alignment.center,
                          child: Form(
                            child: Text(
                              'Jika terdapat sebarang masalah sila rujuk kepada Pengurus Fasiliti',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ))
                  ],
                ))

                // CenterWidget(context),
                // BottomWidget(context)
              ],
            ),
          ),
          Container(
            child: Center(
              child: SimpleDialog(

                  // backgroundColor: Colors.white,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  // ),
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          backgroundColor: MyColors.primaryColor,
                        ),
                      ]),
                    )
                  ]).visible(_loadApi == true),
            ),
          )
        ],
      ),
    );
  }

  void callMobileVerifyApi() {
    try {
      CommonUtil.showLoadingDialog(context, _keyLoader);
      ApiService.mobileVerify(_phonenoController.text).then((value) {
        if (value.status == "success") {
          Navigator.of(_keyLoader.currentContext!, rootNavigator: true)
              .pop(); //c

          setState(() {
            isError = false;
            SessionManeger.saveDetailes("mobile", value.data!.mobile.toString());
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => VarifyID()),
                ModalRoute.withName("/varify"));
          });
          print("tata " + "success");
        } else if (value.status == "error") {
          setState(() {
            isError = true;
          });
          Navigator.of(_keyLoader.currentContext!, rootNavigator: true)
              .pop(); //c
          // _showErrorDialog(value.message);
          CommonUtil.showDialogMsg(context, value.message.toString());

          print("tata " + "errror");
        }
      });
    } catch (error) {
      isError = true;
      CommonUtil.showDialogMsg(context, 'Something went wrong');
      print("tata " + error.toString());
    }
  }

  void LoginApiCall() {
    CommonUtil.showLoadingDialog(context, _keyLoader);
    ApiService.login(_phonenoController.text, _password.text).then((value) {
      Navigator.of(_keyLoader.currentContext!, rootNavigator: true).pop();
      print(value);
      if (value.status == "success") {
        //  print("val" + value.data.id);
        // Navigator.of(_globalKey.currentContext, rootNavigator: true).pop();
        setState(() {
          isError = false;
          user_id = value.data!.id.toString();
          // building_name = value.data.buildingName;
          // building_id = value.data.buildingId;

          SessionManeger.saveDetailes("user_id", value.data!.id.toString());
          SessionManeger.saveDetailes(
              "user_name", value.data!.fullName.toString());
          SessionManeger.saveDetailes("mobile", value.data!.mobile.toString());
          SessionManeger.saveDetailes("image", value.data!.image.toString());
          SessionManeger.saveDetailes("email", value.data!.email.toString());
          SessionManeger.saveDetailes(
              "building_name", value.data!.buildingName.toString());
          SessionManeger.saveDetailes(
              "building_id", value.data!.buildingId.toString());
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      0,
                    )),
            ModalRoute.withName("/home"));
      } else if (value.status == "error") {
        setState(() {});
        isError = true;
        CommonUtil.showDialogMsg(context, value.message.toString());

        print("tata " + value.message.toString());
      }
    });
  }
}
