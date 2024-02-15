import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:vidhya_doctors/view/widgets/small_text.dart';
import '../Utils/colors.dart';

class IconTextCol extends StatelessWidget {
  Color? color;
  Color? textcolor;
  final String distext;
  IconData disicon;
  IconTextCol({
    super.key,
    this.color,
    this.textcolor,
    required this.disicon,
    required this.distext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          disicon,
          size: 17,
          color: color != null ? color : AppColors.mainColor,
        ),
        SizedBox(
          width: 4,
        ),
        SmallText(
          text: distext,
          size: 12,
          color: textcolor != null ? textcolor : null,
        )
      ],
    );
  }
}
