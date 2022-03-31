import 'package:flutter/material.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_image.dart';
import 'dart:io';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import 'package:local_image_provider/local_image_provider.dart' as lip;
import 'package:flutter/painting.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();

  runApp(MaterialApp(home: ImageScreen()));
}

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  //LocalImageProvider imageProvider = LocalImageProvider();
  bool _showImages = false;
  String _noPermissionMessage = 'No access allowed to';
  bool _isLoading = true;
  List<LocalImage> images;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getStoragePermission();
    getLatestImages();
  }

// method to request permission for storage
  checkPermission() async {
    Permission permission = Permission.storage;

    if (await Permission.storage.isGranted) {
      // Do nothing here
      getLatestImages();
    } else {
      setState(() {
        _isLoading = false;
        _showImages = false;
      });
    }
  }

  getLatestImages() async {
    lip.LocalImageProvider imageProvider = lip.LocalImageProvider();
    bool hasPermission = await imageProvider.initialize();

    if (hasPermission) {
      images = await imageProvider.findLatest(30);
      images.forEach((image) => print(image.id));
      setState(() {
        _isLoading = false;
        _showImages = true;
      });
    } else {
      print("The user has denied access to images on their device.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Sizer(builder: ((context, orientation, deviceType) {
          return Stack(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _showImages
                        ? Column(
                            children: [
                              Expanded(
                                  child: GridView.builder(
                                      itemCount: images.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          child: Image(
                                              image:
                                                  DeviceImage(images[index])),
                                        );
                                      })),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 10.h,
                                      width: 10.h,
                                      child: IconButton(
                                        onPressed: () {
                                          // go to the main gallery image picker
                                        },
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 5.h,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                    ),
                                    Container(
                                      height: 10.h,
                                      width: 10.h,
                                      child: IconButton(
                                        onPressed: () {
                                          // go to the main gallery image picker
                                        },
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 5.h,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue),
                                    )
                                  ],
                                ),
                                height: 20.h,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                              )
                            ],
                          )
                        : Center(
                            child: Text('Permision not Granted'),
                          ),
              )
            ],
          );
        })),
      ),
    );
  }
}
