import 'package:flutter/material.dart';

class NoInternetConnection extends StatefulWidget {
  @override
  _NoInternetConnectionState createState() => _NoInternetConnectionState();
}

class _NoInternetConnectionState extends State<NoInternetConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/frame_img.png',
                width: MediaQuery.of(context).size.width,
              )),
        ],
      ),
    );
  }
}
