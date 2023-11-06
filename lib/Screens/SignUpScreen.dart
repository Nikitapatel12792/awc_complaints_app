import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
import 'package:awc_complaints_app/Model/MasterResponse.dart';
import 'package:awc_complaints_app/Screens/Home.dart';
import 'package:awc_complaints_app/Screens/VarifyID.dart';
import 'package:awc_complaints_app/Utill/CircularProgress.dart';
import 'package:awc_complaints_app/Utill/CommonUtil.dart';
import 'package:awc_complaints_app/Utill/Constant.dart';
import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:awc_complaints_app/Utill/SessionManager.dart';
import 'package:awc_complaints_app/Utill/UserDataConstant.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  TextEditingController _fullnamecontroller = new TextEditingController();
  TextEditingController _phonenoController = new TextEditingController();

  TextEditingController _password = new TextEditingController();
  TextEditingController _designation = new TextEditingController();
  TextEditingController _departmentController = new TextEditingController();

  bool _showError = false;
  bool _loadApi = false;
  int? building_id;
  List<BuildingLists> buildingLists = [];

  @override
  void initState() {
    init();
    super.initState();
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

  Future<void> init() async {
    callMasterApi();
  }

  void callMasterApi() async {
    // CommonUtil.showLoadingDialog(context, _keyLoader);
    _loadApi = true;
    await masters().then((res) async {
      if (res.status!.contains("success")) {
        setState(() {
          _loadApi = false;
          buildingLists = res.data!.buildingLists!;
        });
      } else {
        setState(() {
          _loadApi = false;
        });
      }

      // toast(res.status);
    }).catchError((error) {
      _loadApi = false;
      // toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Stack(
                  children: [
                    Image.asset(
                      'assets/login_backgroun.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    IconButton(
                      onPressed: () {
                        finish(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: black,
                      ),
                    ).paddingTop(25)
                  ],
                ),
                Positioned(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    Container(
                      margin: EdgeInsets.fromLTRB(45, 20, 60, 5),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Nama lengkap",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: 48,
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _fullnamecontroller,
                        keyboardType: TextInputType.name,
                        decoration: new InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "Nama lengkap",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(45, 12, 60, 5),
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
                      height: 48,
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
                            hintText: "Telefon no.",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(45, 12, 60, 5),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Nama bangunan",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white),
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        decoration: InputDecoration.collapsed(
                          hintText: '',
                        ),
                        hint: Text('Pilih Gedung',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            )),
                        items: buildingLists.map((item) {
                          return DropdownMenuItem(
                            value: item.id,
                            child: new Text(item.name.toString()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          log(val);
                        },
                      ),
                    ).paddingSymmetric(horizontal: 50),

                    Container(
                      margin: EdgeInsets.fromLTRB(45, 12, 60, 5),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Penamaan",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: 48,
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _designation,
                        decoration: new InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "Penamaan",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(45, 12, 60, 5),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Departemen",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: 48,
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _departmentController,
                        decoration: new InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "Departemen",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(45, 12, 60, 5),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Kata sandi",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: 48,
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: new InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: new OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "Kata sandi",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 45,
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
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            'Buat Akun',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              _loadApi = true;
                            });
                            SignUpApi();
                          },
                        )),
                    10.height,
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(60, 20, 60, 20),
                    //   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    //   alignment: Alignment.center,
                    //   child: Form(
                    //     child: Text(
                    //       'Jika terdapat sebarang masalah sila rujuk kepada Pengurus Fasiliti',
                    //       style: TextStyle(fontSize: 16, color: Colors.white),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ),
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
                  ]),
            ),
          ).visible(_loadApi == true)
        ],
      ),
    );
  }

  void SignUpApi() {
    // CommonUtil.showLoadingDialog(context, _keyLoader);
    ApiService.sign_up(
            _fullnamecontroller.text,
            _phonenoController.text,
            building_id.toString(),
            _designation.text,
            _departmentController.text,
            _password.text)
        .then((value) {
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      print(value);
      if (value.status == "success") {
        _loadApi = false;
        setState(() {
          user_id = value.data!.id.toString();
          // building_name = value.data.buildingName;
          // building_id = value.data.buildingId;

          SessionManeger.saveDetailes("user_id", value.data!.id.toString());
          SessionManeger.saveDetailes("user_name", value.data!.fullName.toString());
          SessionManeger.saveDetailes("mobile", value.data!.mobile.toString());
          SessionManeger.saveDetailes("image", value.data!.image.toString());
          SessionManeger.saveDetailes("email", value.data!.email.toString());
          SessionManeger.saveDetailes("building_name", value.data!.buildingName.toString());
          SessionManeger.saveDetailes("building_id", value.data!.buildingId.toString());
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home(0)),
            ModalRoute.withName("/home"));
      } else if (value.status == "error") {
        setState(() {
          _loadApi = false;
        });

        CommonUtil.showDialogMsg(context, value.message.toString());

        print("tata " + value.message.toString());
      }
    });
  }
}
