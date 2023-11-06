// import 'dart:convert';
// import 'dart:io';
//
// import 'package:awc_complaints_app/ApiCall/ApiCall.dart';
// import 'package:awc_complaints_app/Language/app_localizations.dart';
// import 'package:awc_complaints_app/Screens/ThankyouScreen.dart';
// import 'package:awc_complaints_app/Utill/CommonUtil.dart';
// import 'package:awc_complaints_app/Utill/Constant.dart';
// import 'package:awc_complaints_app/Utill/MyColors.dart';
// import 'package:awc_complaints_app/Utill/SessionManager.dart';
// import 'package:awc_complaints_app/Utill/UserDataConstant.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:im_stepper/stepper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
//
// class StepsTest extends StatefulWidget {
//   @override
//   _StepsTestState createState() => _StepsTestState();
// }
//
// class _StepsTestState extends State<StepsTest> {
//   int selectedIndex = 0;
//   bool is_image_visible = true;
//   String step = 'Langkah 1';
//   String stepMessage = "Nyatakan lokasi dan aduan";
//
//   //First Screen Variable
//   TextEditingController firstScreen_location = new TextEditingController();
//   TextEditingController firstScreen_description = new TextEditingController();
//
//   File _image;
//   String buildingName;
//   String building_id;
//   final picker = ImagePicker();
//
//   Future getImageCamera() async {
//     // final image = await ImagePicker.pickImage(source: ImageSource.camera);
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//
//       //  _image = image
//     });
//   }
//   // Future getImageGalley() async {
//   //   final image = await ImagePicker.pickImage(source: ImageSource.gallery);
//   //   setState(() {
//   //     _image = image;
//   //   });
//   // }
//
//   //Third Screen Variable
//   final GlobalKey<State> globalKey = new GlobalKey<State>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
//     setState(() {
//       SessionManeger.getDetails("building_name").then((value) {
//         buildingName = value;
//       });
//
//       SessionManeger.getDetails("building_id").then((value) {
//         setState(() {
//           building_id = value;
//         });
//       });
//     });
//     // initSetLang();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           iconTheme: IconThemeData(color: Colors.black),
//           elevation: 0.0,
//           title: Text(
//             "Aduan ",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 30,
//             ),
//           ),
//           flexibleSpace: Image.asset(
//             'assets/app_background.png',
//             fit: BoxFit.cover,
//             height: 100,
//           ),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/step_1_primary.png',
//                     height: 35,
//                     width: 35,
//                   ),
//                   Expanded(
//                       child: Divider(
//                     color: MyColors.primaryColor,
//                     thickness: 5,
//                   )),
//                   selectedIndex > 0
//                       ? Image.asset(
//                           'assets/step_2_primary.png',
//                           height: 35,
//                           width: 35,
//                         )
//                       : Image.asset(
//                           'assets/step_2_grey.png',
//                           height: 35,
//                           width: 35,
//                         ),
//                   Expanded(
//                       child: Divider(
//                     color: selectedIndex > 1
//                         ? MyColors.primaryColor
//                         : greyColorCode,
//                     thickness: 5,
//                   )),
//                   selectedIndex > 1
//                       ? Image.asset(
//                           'assets/step_3_primary.png',
//                           height: 35,
//                           width: 35,
//                         )
//                       : Image.asset(
//                           'assets/step_3_grey.png',
//                           height: 35,
//                           width: 35,
//                         ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//               decoration: BoxDecoration(
//                   color: MyColors.greyColor,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                       bottomLeft: Radius.circular(10))),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                         color: MyColors.blueColor,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.zero,
//                             bottomRight: Radius.zero,
//                             bottomLeft: Radius.circular(10))),
//                     child: Text(
//                       '$step',
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.zero,
//                             bottomRight: Radius.zero,
//                             bottomLeft: Radius.circular(10))),
//                     child: Text(
//                       '$stepMessage',
//                       style: TextStyle(fontSize: 12, color: Colors.black),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Builder(builder: (context) {
//                 if (selectedIndex == 0) {
//                   return FirstScreen();
//                 } else if (selectedIndex == 1) {
//                   return SecondScreen();
//                 } else {
//                   return ThirdScreen();
//                 }
//               }),
//             )
//           ],
//         ));
//   }
//
//   Widget FirstScreen() {
//     // var appLocalization = AppLocalizations.of(context);
//     return Container(
//         // margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//         alignment: Alignment.center,
//         child: Stack(
//           children: [
//             Positioned(
//                 bottom: 0,
//                 child: Image.asset(
//                   'assets/frame_img.png',
//                   width: MediaQuery.of(context).size.width,
//                 )),
//             Container(
//               color: Colors.transparent,
//               margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//               child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: ListView(
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
//                       child: Text(
//                         'Lokasi aduan',
//                         // appLocalization.translate('location_of_complaint'),
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: MyColors.blueColor),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
//                       child: TextFormField(
//                         controller: firstScreen_location,
//                         decoration: new InputDecoration(
//                             border: new OutlineInputBorder(
//                                 borderRadius: const BorderRadius.all(
//                                   const Radius.circular(10.0),
//                                 ),
//                                 borderSide: BorderSide(color: Colors.blue)),
//                             filled: true,
//                             hintStyle: new TextStyle(color: Colors.grey[800]),
//                             hintText: "",
//                             fillColor: Colors.white70),
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//                       child: Text(
//                         'Contoh: Tingkat 1 / Jabatan Imigresen / Bilik Mesyuarat 1',
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 12,
//                             color: Colors.black),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                       child: Text(
//                         'Perincian aduan',
//                         // appLocalization.translate('details_of_complaint'),
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: MyColors.blueColor),
//                       ),
//                     ),
//                     Container(
//                       child: TextFormField(
//                         maxLines: 6,
//                         controller: firstScreen_description,
//                         decoration: new InputDecoration(
//                             border: new OutlineInputBorder(
//                                 borderRadius: const BorderRadius.all(
//                                   const Radius.circular(10.0),
//                                 ),
//                                 borderSide: BorderSide(color: Colors.blue)),
//                             filled: true,
//                             hintStyle: new TextStyle(color: Colors.grey[800]),
//                             hintText: "",
//                             fillColor: Colors.white70),
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Container(
//                         height: 50,
//                         margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
//                         padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         child: FlatButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           disabledColor: Colors.grey,
//                           textColor: Colors.white,
//                           color: MyColors.primaryColor,
//                           child: Text(
//                             'Langkah seterusnya',
//                             // appLocalization.translate('next_step'),
//                             style: TextStyle(fontSize: 20, color: Colors.white),
//                           ),
//                           onPressed: () {
//                             if (firstScreen_description.text == "" ||
//                                 firstScreen_location.text == "") {
//                               CommonUtil.showDialogMsg(
//                                   context, "Lokasi dan deskripsi diperlukan");
//                             } else {
//                               setState(() {
//                                 step = 'Langkah 2';
//                                 stepMessage = 'Gambar aduan';
//                                 //    appLocalization.translate('step_two_message');
//
//                                 selectedIndex = 1;
//                               });
//                             }
//                           },
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget SecondScreen() {
//     //  var appLocalization = AppLocalizations.of(context);
//     return Container(
//         child: Stack(
//       children: [
//         Positioned(
//             bottom: 0,
//             child: Image.asset(
//               'assets/frame_img.png',
//               width: MediaQuery.of(context).size.width,
//             )),
//         ListView(
//           children: <Widget>[
//             Container(
//                 margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 child: Stack(
//                   children: <Widget>[
//                     new GestureDetector(
//                         onTap: () {
//                           //getImage();
//                           getImageCamera();
//                           // _showSelectionDialog(context);
//                         },
//                         child: _image == null
//                             ? DottedBorder(
//                                 color: Colors.grey, //color of dotted/dash line
//                                 strokeWidth: 1, //thickness of dash/dots
//                                 dashPattern: [4, 4],
//                                 child: Container(
//                                   height: 200,
//                                   color: MyColors.greyColor,
//                                   alignment: Alignment.center,
//                                   child: IconButton(
//                                     iconSize: 50,
//                                     icon: Icon(Icons.camera_alt_rounded),
//                                     onPressed: () {
//                                       // _showSelectionDialog(context);
//                                       getImageCamera();
//                                       print("click");
//                                     },
//                                   ),
//                                 ))
//                             : ClipRRect(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 child: Image.file(_image,
//                                     height: 200,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover),
//                               ))
//                   ],
//                 )),
//             Visibility(
//               visible: _image != null ? true : false,
//               child: Container(
//                   height: 50,
//                   margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                   child: FlatButton.icon(
//                     icon: Icon(
//                       Icons.delete_forever,
//                       color: Colors.red[400],
//                     ),
//                     label: Text(
//                       'Ambil semula',
//                       // appLocalization.translate('take_it_back'),
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         getImageCamera();
//                       });
//                     },
//                   )),
//             ),
//             SizedBox(
//               height: 60,
//             ),
//             Visibility(
//               visible: _image == null ? true : false,
//               child: Container(
//                   height: 50,
//                   margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
//                   child: FlatButton(
//                     child: Text(
//                       'Tiada gambar',
//                       //appLocalization.translate('no_picture'),
//                       style: TextStyle(
//                           fontSize: 22,
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         selectedIndex = 2;
//                         step = 'Langkah 3';
//                         stepMessage = 'Semak dan hantar';
//                         //   appLocalization.translate('step_three_message');
//                       });
//                     },
//                   )),
//             ),
//             Container(
//                 height: 50,
//                 margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                 padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                 child: FlatButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   disabledColor: MyColors.darkGreyColor,
//                   textColor: Colors.white,
//                   color: MyColors.primaryColor,
//                   child: Text(
//                     'Langkah seterusnya',
//                     //appLocalization.translate('next_step'),
//                     style: TextStyle(fontSize: 20, color: Colors.white),
//                   ),
//                   onPressed: _image == null
//                       ? (null)
//                       : () {
//                           setState(() {
//                             selectedIndex = 2;
//                             step = 'Langkah 3';
//                             stepMessage = 'Semak dan hantar';
//                             // appLocalization.translate('step_three_message');
//                           });
//                           print(_image);
//                         },
//                 )),
//           ],
//         ),
//       ],
//     ));
//   }
//
//   Widget ThirdScreen() {
//     //  var appLocalization = AppLocalizations.of(context);
//
//     return Container(
//       child: Stack(
//         children: [
//           Positioned(
//               bottom: 0,
//               child: Image.asset(
//                 'assets/frame_img.png',
//                 width: MediaQuery.of(context).size.width,
//               )),
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: ListView(
//               children: <Widget>[
//                 Visibility(
//                   visible: is_image_visible,
//                   child: Container(
//                       margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
//                       child: _image == null
//                           ? Container()
//                           : ClipRRect(
//                               borderRadius: BorderRadius.circular(8.0),
//                               child: Image.file(_image,
//                                   height: 200,
//                                   width: double.infinity,
//                                   fit: BoxFit.cover),
//                             )
//
//                       // _image != null
//                       //     ? Image.file(_image)
//                       //     : Image.asset('assets/pizza.jpg',
//                       //         height: 120,
//                       //         width: double.infinity,
//                       //         fit: BoxFit.cover)
//                       ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
//                   child: Text(
//                     'Nama Bangunan',
//                     //  appLocalization.translate('building_name'),
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.blueColor),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
//                   child: Text(
//                     '$buildingName',
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.normal,
//                         color: Colors.black),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
//                   child: Text(
//                     'Lokasi aduan',
//                     // appLocalization.translate('location_of_complaint'),
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.blueColor),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
//                   child: Text(
//                     firstScreen_location.text,
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                         color: Colors.black),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
//                   child: Text(
//                     'Perincian aduan',
//                     // appLocalization.translate('details_of_complaint'),
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         color: MyColors.blueColor),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
//                   child: Text(
//                     firstScreen_description.text,
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.normal,
//                         color: Colors.black),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Container(
//                     height: 50,
//                     margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                     child: FlatButton.icon(
//                       icon: Icon(
//                         Icons.delete_forever,
//                         color: Colors.red[400],
//                       ),
//                       label: Text(
//                         'Batal',
//                         // appLocalization.translate('cancel'),
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.blue,
//                             decoration: TextDecoration.underline),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           selectedIndex = 0;
//                           step = 'Langkah 1';
//                           //appLocalization.translate('steps') + '1';
//                           stepMessage = 'Nyatakan lokasi dan aduan';
//                           //   appLocalization.translate('step_one_message');
//                           clearAll();
//                         });
//                       },
//                     )),
//                 Container(
//                     height: 50,
//                     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                     child: FlatButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       disabledColor: Colors.grey,
//                       textColor: Colors.white,
//                       color: MyColors.primaryColor,
//                       child: Text(
//                         'Hantar aduan',
//                         // appLocalization.translate('send_complaints'),
//                         style: TextStyle(fontSize: 20),
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           uploadImage();
//                         });
//
//                         ///  clearAll();
//                       },
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future uploadImage() async {
//     CommonUtil.showLoadingDialog(context, globalKey);
//     Uri uri = Uri.parse(URLS.BASE_URL + 'add_complaint');
//     http.MultipartRequest request = new http.MultipartRequest('POST', uri);
//     request.fields['user_id'] = user_id;
//     request.fields['building_no'] = building_id;
//     request.fields['location_of_complaint'] = firstScreen_location.text;
//     request.fields['description'] = firstScreen_description.text;
//     request.fields['apikey'] = '999930';
//     if (_image != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//         'image',
//         _image.path,
//       ));
//     }
//     http.StreamedResponse response = await request.send();
//
//     print("aaya" + response.statusCode.toString());
//     // print()
//     response.stream.transform(utf8.decoder).listen((value) {
//       print(value);
//       var data = jsonDecode(value);
//       print(data['status']);
//
//       if (data['status'] == "success") {
//         setState(() {
//           Navigator.of(globalKey.currentContext, rootNavigator: false).pop();
//
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => ThankyouScreen()));
//           selectedIndex = 0;
//           clearAll();
//         });
//       } else {
//         Navigator.of(globalKey.currentContext, rootNavigator: false).pop();
//         CommonUtil.showDialogMsg(context, data['message']);
//       }
//     });
//   }
//
//   void clearAll() {
//     setState(() {
//       firstScreen_description.text = "";
//       firstScreen_location.text = "";
//       firstScreen_description.text = "";
//       _image = null;
//       buildingName = "";
//       selectedIndex = 0;
//     });
//   }
// }
