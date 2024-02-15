import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overFlow;
  TextDecoration textDecoration;
  FontWeight fontWeight;
  int maxlines;
  SmallText(
      {super.key,
      this.color = const Color(0xFF332d2b),
      required this.text,
      this.maxlines = 2,
      this.height = 1.2,
      this.overFlow = TextOverflow.fade,
      this.size = 11,
      this.textDecoration = TextDecoration.none,
      this.fontWeight = FontWeight.w500});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxlines,
        overflow: overFlow,
        textAlign: TextAlign.justify,
        style: TextStyle(
          decoration: textDecoration,
          fontFamily: 'Roboto',
          color: color,
          fontSize: size,
          height: height,
          fontWeight: fontWeight,
        ));
  }
}
