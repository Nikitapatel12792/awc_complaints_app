import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:flutter/material.dart';

class CommonUtil {


  static Future<void> showDialogMsg(BuildContext context,String message) async {
    return showDialog<void>(
        context: context, builder: (BuildContext context) {
          return  AlertDialog(
            title: Text('Alert'),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
    });
  }

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  // backgroundColor: Colors.white,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  // ),
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          backgroundColor:MyColors.primaryColor,
                        ),
                      ]),
                    )
                  ]));
        });
  }

}
