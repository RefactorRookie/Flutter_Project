import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.fontSize,
      this.weight})
      : super(key: key);

  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: textColor, fontSize: fontSize, fontWeight: weight),
    );
  }
}
