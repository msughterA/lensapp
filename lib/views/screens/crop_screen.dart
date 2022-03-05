import 'dart:convert';
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
import 'package:lensapp/models/subject_models.dart';
import 'package:lensapp/bloc/main_bloc.dart';
import 'main_screen.dart' as mn;
import 'package:lensapp/bloc/main_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'qa_screen.dart';
import 'summarizer_screen.dart';
import 'examples_screen.dart';

//import 'camera_screen.dart';
void main() {}

class CropScreen extends StatefulWidget {
  Uint8List image;
  final List<Mode> modes;
  final int selectedModeIndex;
  final Color color;
  final mn.Module module;
  CropScreen(
      {Key key,
      this.image,
      this.modes,
      this.module,
      this.selectedModeIndex,
      this.color})
      : super(key: key);

  @override
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final _cropController = CropController();
  int _selectedModeIndex = 0;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedModeIndex = widget.selectedModeIndex;
  }

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
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
                            onTap: () {
                              if (_isLoading == false) {
                                // notify is loading icon
                                setState(() {
                                  _isLoading = true;
                                });
                                // Crop the image
                                _cropController.crop();
                              }
                            },
                            child: Container(
                              height: 4.0.h,
                              width: 18.0.w,
                              child: Center(
                                child: _isLoading
                                    ? SizedBox(
                                        height: 12.0,
                                        width: 12.0,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text('Crop'),
                              ),
                              decoration: BoxDecoration(
                                  color: widget.color,
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
                      // Push to the Result rendering screen and make an api call
                      var _img = base64Encode(image);
                      // send the image to the question and answer display screen
                      if (widget.module == mn.Module.mathematics) {
                        mainBloc.add(CalculateEvent(
                            img: _img,
                            mode: widget.modes[_selectedModeIndex].mode));
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<MainBloc>(context),
                            child: AnswerScreen(),
                          );
                        }));
                      } else if (widget.module == mn.Module.summarizer) {
                        mainBloc.add(SummarizeEvent(
                            img: _img,
                            mode: widget.modes[_selectedModeIndex].mode));
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<MainBloc>(context),
                            child: SummarizerScreen(),
                          );
                        }));
                      } else if (widget.module == mn.Module.chemistry) {
                        mainBloc.add(AnswerChemistryEvent(
                            img: _img,
                            mode: widget.modes[_selectedModeIndex].mode));
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<MainBloc>(context),
                            child: ChemistryAnswer(),
                          );
                        }));
                      } else if (widget.module == mn.Module.examples) {
                        mainBloc.add(ExampleEvent(
                            img: _img,
                            mode: widget.modes[_selectedModeIndex].mode));
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<MainBloc>(context),
                            child: ExampleScreen(),
                          );
                        }));
                      }
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
                            child: Text(
                                widget.modes[_selectedModeIndex].description),
                          ),
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              //scrollDirection: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:
                                  List.generate(widget.modes.length, (index) {
                                return CameraMode(
                                  color: widget.color,
                                  onpressed: () {
                                    setState(() {
                                      _selectedModeIndex = index;
                                    });
                                  },
                                  label: widget.modes[index].mode,
                                  fillisColor: _selectedModeIndex == index
                                      ? true
                                      : false,
                                  labelisWhite: _selectedModeIndex == index
                                      ? true
                                      : false,
                                );
                              })),
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
