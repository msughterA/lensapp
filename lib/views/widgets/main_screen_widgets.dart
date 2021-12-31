import 'package:flutter/material.dart';
import '/utils/app_themes.dart';
import 'package:sizer/sizer.dart';
// subject tile

class SubjectTile extends StatelessWidget {
  final Icon icon;
  final int index;
  final double spacing;
  final double tileOddHeight;
  final double tileEvenHeight;
  final double tileBorderRadius;
  final String title;
  final Color color;
  const SubjectTile(
      {Key key,
      this.icon,
      this.index,
      this.title,
      this.tileEvenHeight,
      this.tileOddHeight,
      this.tileBorderRadius,
      this.spacing,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          this.icon,
          SizedBox(
            height: this.spacing,
          ),
          Text(
            this.title,
            style: TextStyle(
                color: Pallete.secondary, fontWeight: FontWeight.bold),
          )
        ],
      ),
      height: index.isEven ? this.tileEvenHeight : tileOddHeight,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(this.tileBorderRadius)),
          color: this.color),
    );
  }
}

// Category Tile
class CategoryTile extends StatelessWidget {
  final Icon icon;
  final Color iconColor;
  final String title;
  final Color titleColor;
  final Color color;
  final double width;
  final double height;
  final double spacing;
  final double iconSize;
  final double radius;
  final Color textColor;
  const CategoryTile(
      {Key key,
      this.icon,
      this.iconColor,
      this.title,
      this.color,
      this.height,
      this.width,
      this.spacing,
      this.titleColor,
      this.radius,
      this.textColor,
      this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          this.icon,
          SizedBox(
            height: this.spacing,
          ),
          Text(
            this.title,
            style: TextStyle(color: this.textColor),
          )
        ],
      ),
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(this.radius)),
          color: this.color),
    );
  }
}
