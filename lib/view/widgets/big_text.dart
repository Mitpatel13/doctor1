import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  FontWeight weight;
  TextDecoration decoration;
  BigText({
    super.key,
    this.color = Colors.black,
    required this.text,
    this.decoration = TextDecoration.none,
    this.overFlow = TextOverflow.ellipsis,
    this.size = 20,
    this.weight = FontWeight.w800,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overFlow,
        maxLines: 1,
        style: TextStyle(
            fontFamily: 'Roboto',
            color: color,
            fontSize: size,
            fontWeight: weight,
            decoration: decoration));
  }
}
