import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatefulWidget {
  @override
  _CircularProgressState createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
          backgroundColor: MyColors.primaryColor,
        ),
        //   child: SimpleDialog(
        //
        //       elevation: 0.0,
        //       backgroundColor: Colors.transparent,
        //       // shape: RoundedRectangleBorder(
        //       //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
        //       // ),
        //       children: <Widget>[
        //         Center(
        //           child: Column(children: [
        //             CircularProgressIndicator(
        //               backgroundColor: primaryColor,
        //             ),
        //           ]),
        //         )
        //       ])
      ),
    );
  }
}
