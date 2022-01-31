import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/utils/app_themes.dart';
import 'package:catex/catex.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:transparent_image/transparent_image.dart';

// Text Input widget
class TextInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Widget icon;
  final TextInputType inputType;
  final Function validator;
  final bool obscureText;
  const TextInput(
      {Key key,
      this.hintText,
      this.validator,
      this.icon,
      this.inputType,
      this.obscureText,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 5.w,
      ),
      decoration: new BoxDecoration(
        color: Pallete.secondaryBackround,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          return validator(value);
        },
        keyboardType: inputType,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            icon: icon,
            labelText: this.hintText,
            hintText: this.hintText,
            //errorText:errorText() ,
            border: InputBorder.none,
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Pallete.accent),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Pallete.primary))),
      ),
    );
  }
}

class RenderData extends StatelessWidget {
  final List pods;
  RenderData({Key key, this.pods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(pods.length, (index) {
          String ptype = pods[index]['type'];
          var data = pods[index]['data'];
          //print(data);
          if (ptype == 'image') {
            return Pod(
              data: data,
              podType: PodType.image,
            );
          } else if (ptype == 'latex') {
            return Pod(
              data: data,
              podType: PodType.latex,
            );
          } else {
            return Pod(
              data: data,
              podType: PodType.text,
            );
          }
        }),
      ),
    );
  }
}

class Pod extends StatelessWidget {
  final data;
  final PodType podType;
  Pod({Key key, this.podType, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (podType) {
      case PodType.image:
        return Container(
            child: Stack(
          children: <Widget>[
            const Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: data,
              ),
            ),
          ],
        ));
        break;
      case PodType.text:
        return Container(child: Text(data));
        break;
      case PodType.latex:
        return Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: TeXView(
              child: TeXViewColumn(children: [
                TeXViewDocument(
                  data,
                  style: TeXViewStyle(
                    backgroundColor: Colors.white,
                  ),
                ),
              ]),
              loadingWidgetBuilder: (context) => Center(
                    child: CircularProgressIndicator(),
                  )),
        );
        break;
      default:
      //return Container();
    }
  }
}

enum PodType { image, text, latex }
