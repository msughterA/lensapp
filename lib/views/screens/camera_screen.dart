import 'dart:typed_data';
import 'package:lensapp/models/subject_models.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:lensapp/views/screens/crop_screen.dart';
import 'dart:async';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import '../widgets/camera_screen_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'camera_screen.dart';
import 'package:image_picker/image_picker.dart';

List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //cameras = await availableCameras();
  runApp(MaterialApp(theme: AppThemes.normalTheme, home: CameraScreen()));
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final List<Mode> modes;
  const CameraScreen({Key key, this.cameras, this.modes}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  File _imageGallery;
  File _imageCamera;
  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future initializeCameras() async {
    cameras = await availableCameras();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    try {
      //final path =join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');

      //Attempt taking the picture
      XFile file = await controller.takePicture();
      File _img = await new File(file.path);
      setState(() {
        _imageCamera = _img;
      });
    } catch (e) {}
  }

  Future<File> pickFromPhotos() async {
    try {
      var img =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageGallery = File(img.path);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Sizer(builder: (context, orientation, deviceType) {
        return Stack(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              child: CameraPreview(controller),
            ),
            Positioned(
              right: 3.0.w,
              top: 15.h,
              child: Container(
                height: 40.h,
                width: 10.w,
                decoration: BoxDecoration(
                    color: Pallete.secondary.withOpacity(0.7),
                    borderRadius: BorderRadius.all(Radius.circular(5.h))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.keyboard_outlined,
                          color: Pallete.primary,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.flash_off_outlined,
                          color: Pallete.primary,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.flash_on_outlined,
                          color: Pallete.primary,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.lightbulb_outline,
                          color: Pallete.accent,
                        ))
                  ],
                ),
              ),
            ),
            Positioned(
              left: 3.w,
              right: 3.w,
              bottom: 21.0.h,
              child: Container(
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
            ),
            // Positioned()
            Positioned(
                left: 10,
                right: 10,
                bottom: 9.0.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        await pickFromPhotos();
                        // convert the image to unit 8
                        Uint8List imageUnit8List =
                            await _imageGallery.readAsBytes();
                        // Move to the crop screen
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CropScreen(
                            image: imageUnit8List,
                          );
                        }));
                      },
                      child: Container(
                        height: 6.h,
                        width: 6.h,
                        child: Icon(Icons.image_outlined),
                        decoration: BoxDecoration(
                            color: Pallete.primary,
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.h))),
                      ),
                    ),
                    // Camera shutter Button
                    InkWell(
                      onTap: () async {
                        // take the picture
                        await takePicture();
                        //print(_image);
                        // convert the image to unit 8
                        Uint8List imageUnit8List =
                            await _imageCamera.readAsBytes();
                        // Move to the crop screen
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CropScreen(
                            image: imageUnit8List,
                          );
                        }));
                      },
                      child: Container(
                        height: 10.h,
                        width: 10.h,
                        decoration: BoxDecoration(
                            color: Pallete.primary,
                            borderRadius: BorderRadius.circular(5.h),
                            border: Border.all(color: Pallete.accent)),
                      ),
                    ),
                    Container(
                      height: 5.h,
                      width: 5.h,
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
                  ],
                )),

            Positioned(
                left: 1.0,
                right: 1.0,
                bottom: 1.0.h,
                child: Container(
                  height: 5.h,
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        //scrollDirection: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(widget.modes.length, (index) {
                          return CameraMode(
                            label: widget.modes[index].mode,
                            fillisBlack: true,
                            labelisWhite: false,
                          );
                        })),
                  ),
                ))
          ],
        );
      }),
    );
  }
}
