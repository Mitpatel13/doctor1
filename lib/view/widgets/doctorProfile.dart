import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vidhya_doctors/view/widgets/small_text.dart';
import '../../controller/TextController.dart';
import '../Utils/colors.dart';
import '../Utils/dimention.dart';
import 'IconTextCol.dart';
import 'ProfileAvatar.dart';
import 'big_text.dart';

class DoctorProfile extends StatelessWidget {
  TextController textController = Get.find<TextController>();
  final String name;
  String id;
  String department;
  String qualification;
  String address;
  String experience;
  DoctorProfile({
    super.key,
    required this.id,
    required this.experience,
    required this.address,
    required this.name,
    required this.qualification,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(8),
      // margin: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   color: const Color(0XFFE7ECEF),
      //   borderRadius: BorderRadius.circular(10),
      //   boxShadow: const [
      //     BoxShadow(
      //         blurRadius: 2.0,
      //         offset: Offset(1, 1),
      //         color: Color.fromARGB(255, 114, 105, 105)),
      //   ],
      // ),
      // ignore: sort_child_properties_last
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              ProfileAvatar(
                id: id,
                imagesize: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: name,
                    size: 18,
                    weight: FontWeight.w600,
                    color: AppColors.secondColor,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SmallText(
                    text: department,
                    size: 12,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: Dimention.screenWidth / 1.7,
                    child: SmallText(
                      maxlines: 3,
                      text: qualification,
                      size: 13,
                      color: AppColors.smallText,
                    ),
                  )
                ],
              ),
            ],
          ),
          Divider(
            thickness: 2,
            color: AppColors.mainColor,
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconTextCol(
                      disicon: MdiIcons.thumbUp,
                      distext: "${textController.rating}%"),
                  IconTextCol(
                      disicon: MdiIcons.medicalBag,
                      distext:
                          "${textController.experience}  years of experience")
                ],
              )),
          SizedBox(
            height: 8,
          ),
          Obx(() => Align(
                alignment: Alignment.centerLeft,
                child: SmallText(
                  color: AppColors.smallText,
                  size: 11,
                  text: textController.address.toString(),
                ),
              )),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Icon(
                MdiIcons.googleMaps,
                size: 25,
                color: AppColors.mainColor,
              ),
              Obx(() => SizedBox(
                    width: Dimention.screenWidth / 1.35,
                    child: Text(
                      "https://www.google.com/maps/search/?api=1&query=${textController.latitude},${textController.lontitude}",
                      // textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 11,
                        color: AppColors.secondColor,
                      ),
                    ),
                  ))
            ],
          ),
        ],
      ),
      // color: Colors.red,
      // width: w17.,
      // height: 33.h,
      width: double.maxFinite,
    );
  }
}
