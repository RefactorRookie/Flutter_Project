import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  SmallText({Key? key, this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 12,
    this.height = 1.2
    }) : super(key: key);

  Color? color;
  final String text;
  double size;
  double height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,

      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
          fontSize: size,
          height: height
      ),
    );
  }
}
