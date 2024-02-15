import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/DailySlotController.dart';
import '../../../controller/TextController.dart';
import '../../../controller/FindTime.dart';
import '../../../model/slotModel.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class DailySlotBottomSheet extends StatefulWidget {
  const DailySlotBottomSheet({super.key});

  @override
  State<DailySlotBottomSheet> createState() => _DailySlotBottomSheetState();
}

class _DailySlotBottomSheetState extends State<DailySlotBottomSheet> {
  NetworkHandler networkHandler = NetworkHandler();
  FindTime findtime = FindTime();
  final TextController textcont = Get.find<TextController>();
  final DailySlotController dailyController = Get.find<DailySlotController>();
  final TextEditingController _time = TextEditingController();
  List<String> hrlist = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];
  String hrdropdownvalue = "12";
  bool hrselect = true;
  List<String> secondlist = [
    "00",
    "05",
    "10",
    "25",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50",
    "55"
  ];

  String seconddropdownvalue = "00";
  bool secondselect = true;
  List<String> amPmlist = ["AM", "PM"];
  String amPmdropdownvalue = "AM";
  bool circular = false;
  bool amPmselect = true;
  bool loaded = false;
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
  var inclinicbox = "0";
  var oncallbox = "0";
  var onvideobox = "0";
  var doorbox = "0";
  @override
  void initState() {
    super.initState();
    fetchPayment();
  }

  void fetchPayment() async {
    var response = await networkHandler.get("/findConsultingFee");
    setState(() {
      inclinicbox = response["inClinic"];
      oncallbox = response["onCall"];
      onvideobox = response["onVideo"];
      doorbox = response["doorStep"];
      loaded = true;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Container(
            height: Dimention.screenHeight / 2.4,
            // key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Center(
                      child: BigText(
                    text: "Create Slot",
                    color: AppColors.secondColor,
                    decoration: TextDecoration.underline,
                    weight: FontWeight.w500,
                  )),
                  const SizedBox(
                    height: 30,
                  ),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              textcont.iconIndex.value = 1;
                            }),
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Icon(
                                    size: 8.w,
                                    MdiIcons.hospitalBuilding,
                                    color: textcont.iconIndex.value == 1
                                        ? AppColors.mainColor
                                        : Colors.grey,
                                  ),
                                  SmallText(
                                      text: "IN Clinic",
                                      maxlines: 1,
                                      size: 10.sp,
                                      color: textcont.iconIndex.value == 1
                                          ? AppColors.mainColor
                                          : Colors.grey)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              textcont.iconIndex.value = 2;
                            }),
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Icon(MdiIcons.phone,
                                      size: 8.w,
                                      color: textcont.iconIndex.value == 2
                                          ? AppColors.mainColor
                                          : Colors.grey),
                                  SmallText(
                                      text: "On Call",
                                      maxlines: 1,
                                      size: 10.sp,
                                      color: textcont.iconIndex.value == 2
                                          ? AppColors.mainColor
                                          : Colors.grey)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              textcont.iconIndex.value = 3;
                            }),
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Icon(MdiIcons.video,
                                      size: 8.w,
                                      color: textcont.iconIndex.value == 3
                                          ? AppColors.mainColor
                                          : Colors.grey),
                                  SmallText(
                                      text: "On Video",
                                      maxlines: 1,
                                      size: 10.sp,
                                      color: textcont.iconIndex.value == 3
                                          ? AppColors.mainColor
                                          : Colors.grey)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              textcont.iconIndex.value = 4;
                            }),
                            child: FittedBox(
                              child: Column(
                                children: [
                                  Icon(MdiIcons.doorOpen,
                                      size: 8.w,
                                      color: textcont.iconIndex.value == 4
                                          ? AppColors.mainColor
                                          : Colors.grey),
                                  SmallText(
                                      text: "Door Step",
                                      maxlines: 1,
                                      size: 10.sp,
                                      color: textcont.iconIndex.value == 4
                                          ? AppColors.mainColor
                                          : Colors.grey)
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Flexible(child: hrdropdown()),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(child: seconddropdown()),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(child: ampmdropdown())
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  InkWell(
                    onTap: () async {
                      if ((textcont.iconIndex.value == 1 &&
                              inclinicbox == "0") ||
                          (textcont.iconIndex.value == 2 && oncallbox == "0") ||
                          (textcont.iconIndex.value == 3 &&
                              onvideobox == "0") ||
                          (textcont.iconIndex.value == 4 && doorbox == "0")) {
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Please Add Consulting Fee For " +
                              treattypeName[textcont.iconIndex.value - 1]),
                          backgroundColor: Colors.red,
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        ));
                      } else {
                        var time = findtime.fromTime(hrdropdownvalue,
                            seconddropdownvalue, amPmdropdownvalue);
                        if (dailyController.timelist.contains(time) == true) {
                          Get.back();

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                " Slot Already done for the selected time"),
                            backgroundColor: Colors.red,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          ));
                        } else {
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
                            "appointments": [
                              {
                                "time": time,
                                "treattype": textcont.iconIndex.value
                              }
                            ]
                          };

                          var response = await networkHandler.post2(
                              "/adddailyAppointment", data);
                          Map<String, dynamic> output =
                              json.decode(response.body);
                          if (response.statusCode == 200 ||
                              response.statusCode == 201) {
                            dailyController.addToCart(SlotModel(
                                time: time,
                                treattype: textcont.iconIndex.value));
                            // Get.back();
                            Get.back();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(output["msg"]),
                              backgroundColor: Colors.red,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            ));
                          }
                        }
                      }
                    },
                    child: Container(
                      width: Dimention.screenWidth / 1.5,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                        child: circular
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Create Appointment",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  )
                  // ignore: deprecated_member_use
                ],
              ),
            ),
          )
        : SizedBox(
            height: Dimention.screenHeight / 2.5,
            child: Center(child: CircularProgressIndicator()));
  }

  Widget hrdropdown() {
    return Container(
        width: 300.w,
        decoration:
            BoxDecoration(border: Border.all(color: AppColors.mainColor)),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: DropdownButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromARGB(255, 131, 125, 125),
          ),
          style: TextStyle(color: AppColors.textColor, fontSize: 16),
          isExpanded: true,
          value: hrdropdownvalue,

          // icon: const Icon(Icons.keyboard_arrow_down),
          // hint: hrselect
          //     ? const Text(
          //         'Identification Document',
          //         style: TextStyle(
          //             color: Color.fromARGB(255, 131, 125, 125), fontSize: 15),
          //       )
          //     : const Text(
          //         'Please Select a Document',
          //         style: TextStyle(color: Colors.red),
          //       ),
          items: hrlist.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              hrdropdownvalue = newValue!;
            });
          },
        ));
  }

  Widget ampmdropdown() {
    return Container(
        width: 300.w,
        decoration:
            BoxDecoration(border: Border.all(color: AppColors.mainColor)),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: DropdownButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromARGB(255, 131, 125, 125),
          ),
          style: TextStyle(color: AppColors.textColor, fontSize: 16),
          isExpanded: true,
          value: amPmdropdownvalue,

          // icon: const Icon(Icons.keyboard_arrow_down),
          // hint: amPmselect
          //     ? const Text(
          //         'Identification Document',
          //         style: TextStyle(
          //             color: Color.fromARGB(255, 131, 125, 125), fontSize: 15),
          //       )
          //     : const Text(
          //         'Please Select a Document',
          //         style: TextStyle(color: Colors.red),
          //       ),
          items: amPmlist.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              amPmdropdownvalue = newValue!;
            });
          },
        ));
  }

  Widget seconddropdown() {
    return Container(
        width: 300.w,
        decoration:
            BoxDecoration(border: Border.all(color: AppColors.mainColor)),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: DropdownButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromARGB(255, 131, 125, 125),
          ),
          style: TextStyle(color: AppColors.textColor, fontSize: 16),
          isExpanded: true,
          value: seconddropdownvalue,

          // icon: const Icon(Icons.keyboard_arrow_down),
          // hint: secondselect
          //     ? const Text(
          //         'Identification Document',
          //         style: TextStyle(
          //             color: Color.fromARGB(255, 131, 125, 125), fontSize: 15),
          //       )
          //     : const Text(
          //         'Please Select a Document',
          //         style: TextStyle(color: Colors.red),
          //       ),
          items: secondlist.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              seconddropdownvalue = newValue!;
            });
          },
        ));
  }
}
