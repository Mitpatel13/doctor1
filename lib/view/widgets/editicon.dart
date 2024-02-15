import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../Utils/colors.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.secondColor,
        ),
        const CircleAvatar(
          radius: 13.5,
          backgroundColor: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Icon(
            MdiIcons.circleEditOutline,
            color: Colors.black,
            size: 22,
          ),
        ),
      ],
    );
  }
}
