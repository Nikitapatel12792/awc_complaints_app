import 'package:awc_complaints_app/Utill/CircularProgress.dart';
import 'package:awc_complaints_app/Utill/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatefulWidget {
  String image;

  FullScreenImage(this.image);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          leadingWidth: 25,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: MyColors.lightBlue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PhotoView(
            imageProvider: NetworkImage(widget.image),
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 40.0,
                height: 40.0,
                child: CircularProgress()
                // CircularProgressIndicator(
                //   value: event == null
                //       ? 0
                //       : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                // ),
              ),
            ),
          )),
    );
  }
}
