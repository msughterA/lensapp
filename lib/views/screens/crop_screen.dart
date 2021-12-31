import 'package:flutter/material.dart';
import '/utils/app_themes.dart';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../widgets/camera_screen_widgets.dart';

//import 'camera_screen.dart';
void main() {}

class CropScreen extends StatefulWidget {
  Uint8List image;

  CropScreen({Key key, this.image}) : super(key: key);

  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final _cropController = CropController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Sizer(
          builder: (context, orientation, deviceType) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.0.h),
                  child: Container(
                    height: 6.0.h,
                    width: 90.0.h,
                    color: Pallete.secondary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              // Go back to Camera screen
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Pallete.primary,
                            )),
                        Padding(
                          padding: EdgeInsets.only(right: 2.0.w),
                          child: InkWell(
                            child: Container(
                              height: 4.0.h,
                              width: 18.0.w,
                              child: Center(
                                child: Text('Crop'),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      child: Crop(
                    baseColor: Pallete.secondary,
                    image: widget.image,
                    controller: _cropController,
                    onCropped: (image) {
                      // Do Something with the image
                    },
                  )),
                ),
                Container(
                    height: 20.0.h,
                    color: Pallete.secondary,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          //width: 80.0.w,
                          height: 7.0.h,
                          child: Center(
                            child: Text('Text Description of the camera mode'),
                          ),
                          decoration: BoxDecoration(
                            color: Pallete.accent,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CameraMode(
                              label: 'Maths',
                              fillisBlack: true,
                              labelisWhite: false,
                            ),
                            CameraMode(
                              label: 'Physics',
                              fillisBlack: true,
                              labelisWhite: false,
                            ),
                            CameraMode(
                              label: 'Chemistry',
                              fillisBlack: true,
                              labelisWhite: false,
                            ),
                            CameraMode(
                              label: 'Biology',
                              fillisBlack: true,
                              labelisWhite: false,
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
