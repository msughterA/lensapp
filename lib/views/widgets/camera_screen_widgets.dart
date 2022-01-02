import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';

class CameraMode extends StatelessWidget {
  final Function onpressed;
  final String label;
  final bool labelisWhite;
  final bool fillisColor;
  final Color color;
  CameraMode(
      {this.label,
      this.onpressed,
      this.labelisWhite,
      this.fillisColor,
      this.color});
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(
        right: 2.w,
      ),
      child: Container(
        constraints: BoxConstraints(minHeight: 5.h, minWidth: 5.w),
        child: new RaisedButton(
            child: new Text(
              label,
              style: new TextStyle(
                  color: labelisWhite ? Colors.white : Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            onPressed: () {
              //change the subject state
              onpressed();
            },
            color: fillisColor ? color : Pallete.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.transparent)),
            elevation: 0,
            padding: EdgeInsets.all(5.0)),
      ),
    );
  }
}
