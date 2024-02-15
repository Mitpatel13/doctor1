import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:vidhya_doctors/view/widgets/small_text.dart';
import '../../controller/BookedSlotController.dart';
import '../../controller/TextController.dart';
import '../../controller/FindTime.dart';
import '../../model/bookedSlotModel.dart';
import '../../networkhandler.dart';
import '../Utils/colors.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../screens/booking/summary.dart';
import 'big_text.dart';


class BookedSlot extends StatelessWidget {
  NetworkHandler networkHandler = NetworkHandler();
  TextController textcont = Get.find<TextController>();
  _callNumber(number) async {
    // const number = '0859211912'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  final BookedSlotController bookedSlotController = Get.find<BookedSlotController>();
  FindTime findtime = FindTime();
  BookedSlotModel bookedSlotModel;
  bool past;
  String selDate;
  final TextEditingController _commentController = TextEditingController();
  BookedSlot(
      {Key? key,
      required this.bookedSlotModel,
      required this.past,
      required this.selDate})
      : super(key: key);
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
    bookedSlotModel.status != "active"
        ? bookedSlotController.totalfees - bookedSlotModel.fees
        : null;
    Color borderColor = bookedSlotModel.status == "active"
        ? AppColors.mainColor
        : bookedSlotModel.status != "Raised"
            ? Colors.red
            : AppColors.secondColor;
    bookedSlotController.timelist.add(bookedSlotModel.time);
    return GestureDetector(
      onTap: () async {
        if (past) {
          if (bookedSlotModel.summary) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Container(
                  color: Colors.transparent,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              },
            );
            Map<String, dynamic> data = {
              "patientid": bookedSlotModel.patientid,
              "time": bookedSlotModel.time,
              "date": bookedSlotModel.date,
            };
            var response = await networkHandler.post2("/displaySummary", data);

            if (response.statusCode == 200 || response.statusCode == 201) {
              Map<String, dynamic> output = json.decode(response.body);

              Get.back();
              Get.to(Summary(
                summary: output["summary"],
                bookedSlotModel: bookedSlotModel,
              ));
            } else {
              Get.back();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Error to load Summary . Please try later"),
                backgroundColor: Colors.red,
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(5),
              ));
            }
          } else {
            Get.to(Summary(
              bookedSlotModel: bookedSlotModel,
              summary: "",
            ));
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          // color: const Color(0XFFE7ECEF),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        // ignore: sort_child_properties_last
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                // color: const Color(0XFFE7ECEF),
                border: Border.all(
                  color: AppColors.mainColor,
                  // width: 5,
                ),
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.4),
                    topRight: Radius.circular(4.4)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallText(
                    text: findtime.toTime(int.parse(bookedSlotModel.time)),
                    size: 17,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        treattypeicons[bookedSlotModel.treattype - 1],
                        size: 20,
                        color: AppColors.secondColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SmallText(
                        text: treattypeName[bookedSlotModel.treattype - 1],
                        size: 13,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Divider(thickness: 1, color: borderColor),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: SmallText(
                      text: bookedSlotModel.patientname,
                      size: 14.sp,
                      color: AppColors.mainColor,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SmallText(
                    text: bookedSlotModel.phone,
                    size: 10.sp,
                  ),
                ],
              ),
            ),
            // Divider(thickness: 1, color: borderColor),
            Container(
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(
                // color: const Color(0XFFE7ECEF),
                border: Border.all(
                  color: AppColors.thirdColour,
                  // width: 5,
                ),
                color: AppColors.thirdColour,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4.4),
                    bottomRight: Radius.circular(4.4)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (() {
                        _callNumber(bookedSlotModel.phone);
                      }),
                      child: Icon(
                        Icons.call,
                        size: 25,
                        color: AppColors.mainColor,
                      ),
                    ),
                    past == true
                        ? const SizedBox.shrink()
                        : bookedSlotModel.status == "active"
                            // ignore: prefer_const_constructors
                            ? GestureDetector(
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 40,
                                                      ),
                                                      Expanded(
                                                        child: SmallText(
                                                          text: "Information",
                                                          color: Colors.white,
                                                          size: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Icon(
                                                              MdiIcons
                                                                  .closeCircleOutline,
                                                              color:
                                                                  Colors.white,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    BigText(
                                                      text: "Cancellation!!",
                                                      color:
                                                          AppColors.mainColor,
                                                      size: 25,
                                                      weight: FontWeight.w500,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    commentTextField()
                                                  ],
                                                ),
                                                footer: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: AppColors
                                                                  .mainColor),
                                                      onPressed: () async {
                                                        if (_commentController
                                                                .text ==
                                                            "") {
                                                          Get.snackbar("Error",
                                                              "Comment Required");
                                                        } else {
                                                          showDialog(
                                                            context: context,
                                                            barrierDismissible:
                                                                false,
                                                            builder: (context) {
                                                              return Container(
                                                                color: Colors
                                                                    .transparent,
                                                                child:
                                                                    const Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                          Map<String, dynamic>
                                                              data = {
                                                            "date":
                                                                bookedSlotModel
                                                                    .date,
                                                            "time":
                                                                bookedSlotModel
                                                                    .time,
                                                            "name": textcont
                                                                .name
                                                                .toString(),
                                                            "phone": textcont
                                                                .phone
                                                                .toString(),
                                                            "reason":
                                                                _commentController
                                                                    .text
                                                          };

                                                          var response =
                                                              await networkHandler
                                                                  .post2(
                                                                      "/cancelBookedAppointment",
                                                                      data);
                                                          if (response.statusCode ==
                                                                  200 ||
                                                              response.statusCode ==
                                                                  201) {
                                                            bookedSlotController
                                                                    .totalfees -
                                                                bookedSlotModel
                                                                    .fees;
                                                            // bookedSlotModel.status =
                                                            //     "Cancelled";

                                                            bookedSlotModel
                                                                    .status =
                                                                "Raised";

                                                            bookedSlotController
                                                                .bookedList
                                                                .remove(
                                                                    bookedSlotModel);
                                                            bookedSlotController
                                                                .bookedList
                                                                .add(
                                                                    bookedSlotModel);
                                                            Get.back();
                                                            Get.back();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                // ignore: prefer_const_constructors
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: const Text(
                                                                  "Request Generated Successfully.Cancellation will Confirm after approval "),
                                                              backgroundColor:
                                                                  AppColors
                                                                      .mainColor,
                                                              elevation: 10,
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                            ));
                                                          } else {
                                                            Get.back();
                                                            Get.back();
                                                            Map<String, dynamic>
                                                                output =
                                                                json.decode(
                                                                    response
                                                                        .body);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                  output[
                                                                      "msg"]),
                                                              backgroundColor:
                                                                  Colors.red,
                                                              elevation: 10,
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              margin: EdgeInsets
                                                                  .all(5),
                                                            ));
                                                          }
                                                        }
                                                      },
                                                      child: const Text(
                                                        "Submit",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16),
                                                      )),
                                                ),
                                              )),
                                        );
                                      });
                                },
                                child: Icon(
                                  Icons.cancel,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox.shrink()
                  ],
                ),
              ),
            )
          ],
        ),
        width: 44.w,
        // height: 20.h,
      ),
    );
  }

  Widget commentTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: TextFormField(
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return "Shouldnotbe emty";
          //   }
          //   return null;
          // },
          maxLines: 3,
          autocorrect: true,
          controller: _commentController,
          decoration: InputDecoration(
            // errorText: validate ? null : errorText,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  color: AppColors.mainColor,
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.mainColor)),
            // helperStyle: TextStyle(color:, fontSize: 5),
            hintStyle: TextStyle(
              fontSize: 16,
            ),
            hintText: "Comment ",
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:flutter/cupertino.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:sizer/sizer.dart';
//  /view/widgets/widgets.dart';

// import '../Utils/colors.dart';

// class BookedSlot extends StatelessWidget {
//   final int trtype;
//   String time;
//   BookedSlot({
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
//               color: AppColors.secondColor,
//               width: 1.7,
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
//                 text: "Sibin James",
//                 size: 12.sp,
//                 color: AppColors.mainColor,
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               SmallText(
//                 text: "9496473754",
//                 size: 10.sp,
//               ),
//               Divider(thickness: 1, color: AppColors.secondColor),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SmallText(
//                     text: time,
//                     size: 10.sp,
//                     color: AppColors.mainColor,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         treattypeicons[trtype - 1],
//                         size: 12.sp,
//                         color: AppColors.secondColor,
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       SmallText(
//                         text: treattypeName[trtype - 1],
//                         size: 8.sp,
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               Divider(thickness: 1, color: AppColors.secondColor),
//               Padding(
//                 padding: const EdgeInsets.only(left: 8, right: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(
//                       Icons.call,
//                       size: 25,
//                       color: AppColors.mainColor,
//                     ),
//                     Icon(
//                       Icons.cancel,
//                       size: 25,
//                       color: Colors.red,
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//           width: 44.w,
//           height: 20.h,
//         ),
//       ],
//     );
//   }
// }
