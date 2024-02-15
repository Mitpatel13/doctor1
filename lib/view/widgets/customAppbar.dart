import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:vidhya_doctors/view/widgets/small_text.dart';
import '../Utils/Utiils.dart';
import 'big_text.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      leading: Icon(MdiIcons.googleMaps),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Center(
              child: Text(
            "change",
            style: TextStyle(
                fontSize: 10.sp, decoration: TextDecoration.underline),
          )),
        )
      ],
      title: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallText(
              text: "Your Location",
              color: Colors.white,
              size: 8.sp,
            ),
            SizedBox(
              height: 5,
            ),
            BigText(
              text: "4th Cross ,Mahthikere,Bangalore",
              overFlow: TextOverflow.fade,
              size: 10.sp,
              color: Colors.white,
              weight: FontWeight.w400,
            )
          ],
        ),
      ),
    );
  }
}
