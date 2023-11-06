import 'package:awc_complaints_app/Screens/ComplaintStatusScreen.dart';
import 'package:awc_complaints_app/Utill/CircularProgress.dart';
import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:html/parser.dart';
import 'package:nb_utils/nb_utils.dart';

class ThankyouScreen extends StatefulWidget {
  var data;

  ThankyouScreen(this.data);

  @override
  _ThankyouScreenState createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('click');
      print(message.notification!.title);
      print(message.notification!.body);
      print(message.data.toString());
      print(message.data['action_id']);
      // var res=   jsonEncode(message.data);
      FlutterAppBadger.updateBadgeCount(-1);

      print('Dashboard');
      if (message.data['action_id'] != null) {
        ComplaintStatusScreen(message.data['action_id'].toString(),'')
            .launch(context);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Aduan ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        flexibleSpace: Image.asset(
          'assets/app_background.png',
          fit: BoxFit.cover,
          height: 100,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: Image.asset(
                  'assets/frame_img.png',
                  width: MediaQuery.of(context).size.width,
                )),
            SingleChildScrollView(
              child: Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/step_1_primary.png',
                          height: 35,
                          width: 35,
                        ),
                        Expanded(
                            child: Divider(
                          color: MyColors.primaryColor,
                          thickness: 5,
                        )),
                        Image.asset(
                          'assets/step_2_primary.png',
                          height: 35,
                          width: 35,
                        ),
                        Expanded(
                            child: Divider(
                          color: MyColors.primaryColor,
                          thickness: 5,
                        )),
                        Image.asset(
                          'assets/step_3_primary.png',
                          height: 35,
                          width: 35,
                        )
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.grey[200],
                    padding: EdgeInsets.all(30),
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          imageUrl: widget.data['image'],
                          placeholder: (context, url) =>
                              new Center(child: CircularProgress()),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          // 'Terima kasih',
                          widget.data['title'],
                          style: TextStyle(
                              fontSize: 30,
                              color: MyColors.blueColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          // 'Aduan anda telah direkodkan dan tindakan akan diambil',

                          parse(widget.data['description']).documentElement!.text.toString()
                          ,
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: 50,
                      margin:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 0.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          disabledBackgroundColor: Colors.grey,
                          textStyle: TextStyle(color: Colors.white),
                          backgroundColor: MyColors.primaryColor,
                        ),

                        child: Text(
                          'Kembali ke menu utama',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                      )),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
