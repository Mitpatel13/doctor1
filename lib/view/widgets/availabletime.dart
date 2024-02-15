import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:vidhya_doctors/view/widgets/small_text.dart';

import '../../controller/SlotController.dart';
import '../../controller/BookedSlotController.dart';
import '../../controller/FindTime.dart';
import '../../model/slotModel.dart';
import '../../networkhandler.dart';
import '../Utils/colors.dart';
import 'big_text.dart';

class AvailableTime extends StatelessWidget {
  NetworkHandler networkHandler = NetworkHandler();
   BookedSlotController bookedSlotController = Get.find<BookedSlotController>();
    SlotController slotController = Get.find<SlotController>();
  FindTime findtime = FindTime();
  String selDate;
  SlotModel slot;
  AvailableTime({
    super.key,
    required this.selDate,
    required this.slot,
  });
  List<IconData> treattypeicons = [
    MdiIcons.hospitalBuilding,
    MdiIcons.phone,
    MdiIcons.video,
    MdiIcons.doorOpen
  ];
  List<String> treattypeName = [
    "IN Clinic",
    "On Call",
    "On Video",
    "Door Step"
  ];
  @override
  Widget build(BuildContext context) {
    bookedSlotController.timelist.add(slot.time);
    return Container(
      decoration: BoxDecoration(
        // color: const Color(0XFFE7ECEF),
        border: Border.all(
          color: Colors.grey,
          // width: 5,
        ),
        borderRadius: BorderRadius.circular(5),
        // border: BoxBorder(),
        // boxShadow: const [
        //   BoxShadow(
        //       blurRadius: 2.0,
        //       offset: Offset(1, 1),
        //       color: Color.fromARGB(255, 114, 105, 105)),
        // ],
      ),
      // ignore: sort_child_properties_last
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            height: 40,
            decoration: BoxDecoration(
              // color: const Color(0XFFE7ECEF),
              border: Border.all(
                color: AppColors.mainColor,
                // width: 5,
              ),
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            child: Center(
              child:  SmallText(
                text: findtime.toTime(int.parse(slot.time)),
                size: 12.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          // Divider(thickness: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  treattypeicons[slot.treattype - 1],
                  size: 20.sp,
                  color: AppColors.secondColor,
                ),
                SizedBox(
                  width: 5,
                ),
                SmallText(
                  text: treattypeName[slot.treattype - 1],
                  size: 10.sp,
                  fontWeight: FontWeight.w400,
                )
              ],
            ),
          ),
          // Divider(thickness: 1, color: Colors.grey),
          Container(
            width: double.maxFinite,
            height: 40,
            decoration: BoxDecoration(
              // color: const Color(0XFFE7ECEF),
              border: Border.all(
                color: AppColors.thirdColour,
                // width: 5,
              ),
              color: AppColors.thirdColour,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4.6),
                  bottomRight: Radius.circular(4.6)),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return Center(
                          child: Container(
                              height: 300,
                              width: 300,
                              color: Colors.white,
                              child: GridTile(
                                header: Container(
                                  height: 50,
                                  // ignore: sort_child_properties_last
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Expanded(
                                        child: SmallText(
                                          text: "Information",
                                          color: Colors.white,
                                          size: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              MdiIcons.closeCircleOutline,
                                              color: Colors.white,
                                            ),
                                          ))
                                      // // onPressed: () {
                                      // //   Get.back();
                                      // // },
                                      // icon: Icon(Icons.close))
                                    ],
                                  ),
                                  color: AppColors.mainColor,
                                ),
                                // ignore: sort_child_properties_last
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BigText(
                                      text: "Information!!",
                                      color: AppColors.mainColor,
                                      size: 25,
                                      weight: FontWeight.w500,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Center(
                                      child: Text(
                                        "Do you want to cancel the Appointment",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 11,
                                            color:
                                                Color.fromARGB(255, 96, 95, 95),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    )
                                  ],
                                ),
                                footer: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: AppColors.mainColor),
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return Container(
                                              color: Colors.transparent,
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                        Map<String, dynamic> data = {
                                          "date": selDate,
                                          "time": slot.time
                                        };
                                        var response = await networkHandler
                                            .post2("/cancelAppointment", data);
                                        if (response.statusCode == 200 ||
                                            response.statusCode == 201) {
                                          slotController.bookedList
                                              .remove(slot);
                                          Get.back();
                                          Get.back();
                                        } else {
                                          Get.back();
                                          Get.back();
                                          Map<String, dynamic> output =
                                              json.decode(response.body);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(output["msg"]),
                                            backgroundColor: Colors.red,
                                            elevation: 10,
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(5),
                                          ));
                                        }
                                      },
                                      child: const Text(
                                        "Okay",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                ),
                              )),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.cancel,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      width: 120,
      // height: 20.h,
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:flutter/cupertino.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:sizer/sizer.dart';

// import '../Utils/colors.dart';
// import 'widgets.dart';

// class AvailableTime extends StatelessWidget {
//   final int trtype;
//   String time;
//   AvailableTime({
//     Key? key,
//     required this.trtype,
//     required this.time,
//   }) : super(key: key);
//   List<IconData> treattypeicons = [
//     MdiIcons.hospitalBuilding,
//     MdiIcons.phone,
//     MdiIcons.video,
//     MdiIcons.doorOpen
//   ];
//   List<String> treattypeName = [
//     "IN Clinic",
//     "On Call",
//     "On Video",
//     "Door Step"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             // color: const Color(0XFFE7ECEF),
//             border: Border.all(
//               color: Colors.grey,
//               // width: 5,
//             ),
//             borderRadius: BorderRadius.circular(5),
//             // border: BoxBorder(),
//             // boxShadow: const [
//             //   BoxShadow(
//             //       blurRadius: 2.0,
//             //       offset: Offset(1, 1),
//             //       color: Color.fromARGB(255, 114, 105, 105)),
//             // ],
//           ),
//           // ignore: sort_child_properties_last
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SmallText(
//                 text: time,
//                 size: 10.sp,
//                 color: AppColors.mainColor,
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Divider(thickness: 1, color: Colors.grey),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     treattypeicons[trtype - 1],
//                     size: 12.sp,
//                     color: AppColors.secondColor,
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   SmallText(
//                     text: treattypeName[trtype - 1],
//                     size: 8.sp,
//                   )
//                 ],
//               ),
//               Divider(thickness: 1, color: Colors.grey),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 8),
//                   child: Icon(
//                     Icons.cancel,
//                     size: 20,
//                     color: Colors.red,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           width: 30.w,
//           height: 20.h,
//         ),
//       ],
//     );
//   }
// }
