import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
 
import '../../../controller/SlotController.dart';
import '../../../controller/BookedSlotController.dart';
import '../../../model/bookedSlotListModel.dart';
import '../../../model/bookedSlotModel.dart';
import '../../../model/slotModel.dart';
import '../../../model/slotModelList.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/availabletime.dart';
import '../../widgets/big_text.dart';
import '../../widgets/bookedslot.dart';
import '../../widgets/small_text.dart';
import 'AppointmentAddBottomSheet.dart';
import 'consulting.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
   TextEditingController _dateController = TextEditingController();
   BookedSlotController bookedSlotController = Get.find<BookedSlotController>();
   final SlotController slotController = Get.find<SlotController>();
  BookedSlotListModel bookedlist = BookedSlotListModel();
  SlotModelList slotlist = SlotModelList();
  late List<BookedSlotModel> bookedlistdata;
  late List<SlotModel> slotlistdata;
  DateTime? pickedDate = DateTime.now();
  NetworkHandler networkHandler = NetworkHandler();
  final _globalKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime today = DateTime.now();
  bool dateclicked = false;
  @override
  void initState() {
    super.initState();
    pickedDate = today;
    _dateController.text = DateFormat('dd-MM-yyyy').format(today);
    fetchinitalAppointment();
  }

  void fetchinitalAppointment() async {
    Map<String, dynamic> data = {
      "date": _dateController.text,
    };
    var response =
        await networkHandler.post2("/findallCommingAppointments", data);
    var output = json.decode(response.body);
    // print(output);

    bookedlist = BookedSlotListModel.fromJson({'data': output["booked"]});
    slotlist = SlotModelList.fromJson({'data': output["nonBooked"]});

    // print(bookedlist.data);
    bookedSlotController.bookedList.value = bookedlist.data!;
    slotController.bookedList.value = slotlist.data!;
  }

  void fetchAppointment() async {
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
      "date": _dateController.text,
    };
    var response =
        await networkHandler.post2("/findallCommingAppointments", data);
    var output = json.decode(response.body);

    bookedlist = BookedSlotListModel.fromJson({'data': output["booked"]});
    slotlist = SlotModelList.fromJson({'data': output["nonBooked"]});

    // print(bookedlist.data);
    bookedSlotController.bookedList.value = bookedlist.data!;
    slotController.bookedList.value = slotlist.data!;
    Get.back();
  }

  void fetchPastAppointment() async {
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
      "date": _dateController.text,
    };
    var response = await networkHandler.post2("/findallpastAppointments", data);
    var output = json.decode(response.body);
    bookedlist = BookedSlotListModel.fromJson({'data': output});
    // print(bookedlist.data);
    bookedSlotController.bookedList.value = bookedlist.data!;
    slotController.bookedList.value = [];
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: DateTime.now().isBefore(pickedDate!)
            ? FloatingActionButton(
                onPressed: () => {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          AppointmentAddBottomSheet(
                            selDate: _dateController.text,
                          ))
                },
                child: const Icon(
                  Icons.add,
                  size: 25,
                ),
              )
            : SizedBox.shrink(),
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "My Bookings",
            color: Colors.white,
            size: 17,
            weight: FontWeight.w300,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  color: AppColors.mainColor,
                  onPressed: () {
                    Get.to(Consulting());
                  },
                  icon: Icon(
                    MdiIcons.cashMultiple,
                    color: Colors.white,
                    size: 25,
                  )),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Column(children: [
              BigText(
                text: "Create  Appointment On",
                color: AppColors.mainColor,
                size: 16,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: dateTextField(),
                  )),
              //  Obx(
              //   () =>
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // DateTime.now().isBefore(pickedDate!)
                  //     ? Obx(
                  //         () =>
                  //         bookedSlotController.bookedList.length == 0 &&
                  //                 slotController.bookedList.length == 0
                  //             ? SizedBox.shrink()
                  //             : Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     left: 10,
                  //                     right: 10,
                  //                     top: 2,
                  //                     bottom: 2),
                  //                 child: ElevatedButton(
                  //                     style: ElevatedButton.styleFrom(
                  //                         primary: AppColors.mainColor),
                  //                     onPressed: () => {
                  //                           showDialog(
                  //                               context: context,
                  //                               barrierDismissible: false,
                  //                               builder: (context) {
                  //                                 return Center(
                  //                                   child: Container(
                  //                                       height: 300,
                  //                                       width: 300,
                  //                                       color: Colors.white,
                  //                                       child: GridTile(
                  //                                         header: Container(
                  //                                           height: 50,
                  //                                           // ignore: sort_child_properties_last
                  //                                           child: Row(
                  //                                             crossAxisAlignment:
                  //                                                 CrossAxisAlignment
                  //                                                     .center,
                  //                                             children: [
                  //                                               SizedBox(
                  //                                                 width: 40,
                  //                                               ),
                  //                                               Expanded(
                  //                                                 child:
                  //                                                     SmallText(
                  //                                                   text:
                  //                                                       "Information",
                  //                                                   color: Colors
                  //                                                       .white,
                  //                                                   size:
                  //                                                       18,
                  //                                                   fontWeight:
                  //                                                       FontWeight.w400,
                  //                                                 ),
                  //                                               ),
                  //                                               GestureDetector(
                  //                                                   onTap:
                  //                                                       () {
                  //                                                     Get.back();
                  //                                                   },
                  //                                                   child:
                  //                                                       Padding(
                  //                                                     padding:
                  //                                                         const EdgeInsets.all(8.0),
                  //                                                     child:
                  //                                                         Icon(
                  //                                                       MdiIcons.closeCircleOutline,
                  //                                                       color:
                  //                                                           Colors.white,
                  //                                                     ),
                  //                                                   ))
                  //                                               // // onPressed: () {
                  //                                               // //   Get.back();
                  //                                               // // },
                  //                                               // icon: Icon(Icons.close))
                  //                                             ],
                  //                                           ),
                  //                                           color: AppColors
                  //                                               .mainColor,
                  //                                         ),
                  //                                         // ignore: sort_child_properties_last
                  //                                         child: Column(
                  //                                           mainAxisAlignment:
                  //                                               MainAxisAlignment
                  //                                                   .center,
                  //                                           crossAxisAlignment:
                  //                                               CrossAxisAlignment
                  //                                                   .center,
                  //                                           children: [
                  //                                             BigText(
                  //                                               text:
                  //                                                   "Information!!",
                  //                                               color: AppColors
                  //                                                   .mainColor,
                  //                                               size: 25,
                  //                                               weight:
                  //                                                   FontWeight
                  //                                                       .w500,
                  //                                             ),
                  //                                             const SizedBox(
                  //                                               height: 5,
                  //                                             ),
                  //                                             const Center(
                  //                                               child: Text(
                  //                                                 "This will Remove all your current day \n Bookings",
                  //                                                 textAlign:
                  //                                                     TextAlign
                  //                                                         .center,
                  //                                                 style: TextStyle(
                  //                                                     decoration: TextDecoration
                  //                                                         .none,
                  //                                                     fontSize:
                  //                                                         11,
                  //                                                     color: Color.fromARGB(
                  //                                                         255,
                  //                                                         96,
                  //                                                         95,
                  //                                                         95),
                  //                                                     fontStyle: FontStyle
                  //                                                         .italic,
                  //                                                     fontWeight:
                  //                                                         FontWeight.w200),
                  //                                               ),
                  //                                             )
                  //                                           ],
                  //                                         ),
                  //                                         footer: Padding(
                  //                                           padding:
                  //                                               const EdgeInsets
                  //                                                       .all(
                  //                                                   8.0),
                  //                                           child:
                  //                                               ElevatedButton(
                  //                                                   style: ElevatedButton.styleFrom(
                  //                                                       primary: AppColors
                  //                                                           .mainColor),
                  //                                                   onPressed:
                  //                                                       () async {
                  //                                                     showDialog(
                  //                                                       context:
                  //                                                           context,
                  //                                                       barrierDismissible:
                  //                                                           false,
                  //                                                       builder:
                  //                                                           (context) {
                  //                                                         return Container(
                  //                                                           color: Colors.transparent,
                  //                                                           child: const Center(
                  //                                                             child: CircularProgressIndicator(
                  //                                                               color: Colors.white,
                  //                                                             ),
                  //                                                           ),
                  //                                                         );
                  //                                                       },
                  //                                                     );
                  //                                                     Map<String, dynamic>
                  //                                                         data =
                  //                                                         {
                  //                                                       "date":
                  //                                                           _dateController.text,
                  //                                                       "fee":
                  //                                                           bookedSlotController.totalfees
                  //                                                     };
                  //                                                     var response = bookedSlotController.bookedList.length == 0
                  //                                                         ? await networkHandler.post2("/cancelAllUnBookedAppointmnets", data)
                  //                                                         : await networkHandler.post2("/cancelAllAppointment", data);
                  //                                                     if (response.statusCode == 200 ||
                  //                                                         response.statusCode == 201) {
                  //                                                       bookedSlotController.bookedList.length == 0
                  //                                                           ? slotController.bookedList.value = []
                  //                                                           : fetchPastAppointment();
                  //                                                       Get.back();
                  //                                                       Get.back();
                  //                                                     } else {
                  //                                                       Get.back();
                  //                                                       Get.back();
                  //                                                       Map<String, dynamic>
                  //                                                           output =
                  //                                                           json.decode(response.body);
                  //                                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //                                                         content: Text(output["msg"]),
                  //                                                         backgroundColor: Colors.red,
                  //                                                         elevation: 10,
                  //                                                         behavior: SnackBarBehavior.floating,
                  //                                                         margin: EdgeInsets.all(5),
                  //                                                       ));
                  //                                                     }
                  //                                                   },
                  //                                                   child:
                  //                                                       const Text(
                  //                                                     "Okay",
                  //                                                     style: TextStyle(
                  //                                                         color: Colors.white,
                  //                                                         fontSize: 16),
                  //                                                   )),
                  //                                         ),
                  //                                       )),
                  //                                 );
                  //                               })
                  //                         },
                  //                     child: const Text(
                  //                       "Cancel",
                  //                       style: TextStyle(
                  //                           color: Colors.white,
                  //                           fontSize: 16),
                  //                     )),
                  //               ))
                  // : SizedBox.shrink(),
                  Obx(
                    () => bookedSlotController.bookedList.isEmpty
                        ? DateTime.now().isBefore(pickedDate!)
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 2, top: 2, bottom: 2),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColors.mainColor),
                                    onPressed: () async {
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
                                                              text:
                                                                  "Information",
                                                              color:
                                                                  Colors.white,
                                                              size: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Icon(
                                                                  MdiIcons
                                                                      .closeCircleOutline,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ))
                                                          // // onPressed: () {
                                                          // //   Get.back();
                                                          // // },
                                                          // icon: Icon(Icons.close))
                                                        ],
                                                      ),
                                                      color:
                                                          AppColors.mainColor,
                                                    ),
                                                    // ignore: sort_child_properties_last
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        BigText(
                                                          text: "Information!!",
                                                          color: AppColors
                                                              .mainColor,
                                                          size: 25,
                                                          weight:
                                                              FontWeight.w500,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        const Center(
                                                          child: Text(
                                                            "This will Remove all your current day booking\n  And Copy all your Daily slot to selected Day",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize: 11,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        96,
                                                                        95,
                                                                        95),
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    footer: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary: AppColors
                                                                      .mainColor),
                                                          onPressed: () async {
                                                            showDialog(
                                                              context: context,
                                                              barrierDismissible:
                                                                  false,
                                                              builder:
                                                                  (context) {
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
                                                                  _dateController
                                                                      .text,
                                                            };
                                                            var response =
                                                                await networkHandler
                                                                    .post2(
                                                                        "/copydailyAppointments",
                                                                        data);
                                                            if (response.statusCode ==
                                                                    200 ||
                                                                response.statusCode ==
                                                                    201) {
                                                              fetchAppointment();
                                                              Get.back();
                                                              Get.back();
                                                            } else {
                                                              Get.back();
                                                              Get.back();
                                                              Map<String,
                                                                      dynamic>
                                                                  output =
                                                                  json.decode(
                                                                      response
                                                                          .body);
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
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
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5),
                                                              ));
                                                            }
                                                          },
                                                          child: const Text(
                                                            "Okay",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          )),
                                                    ),
                                                  )),
                                            );
                                          });
                                    },
                                    child: const Text(
                                      "Copy Slots",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              )
                            : SizedBox.shrink()
                        : SizedBox.shrink(),
                  )
                ],
              ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Divider(
                thickness: 2,
                color: AppColors.mainColor,
              ),
              Obx(
                () => bookedSlotController.bookedList.length == 0 &&
                        slotController.bookedList.length == 0
                    ? SmallText(
                        text: "No slot Available for the day",
                        color: Colors.grey,
                        size: 15,
                        fontWeight: FontWeight.w300,
                      )
                    : SizedBox.shrink(),
              ),

              GetX<BookedSlotController>(builder: (controller) {
                var index = 0;
                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  direction: Axis.horizontal,
                  children: controller.bookedList
                      .map((i) => BookedSlot(
                            bookedSlotModel: i,
                            selDate: _dateController.text,
                            past: DateTime.now().isBefore(pickedDate!) ||
                                    _dateController.text ==
                                        DateFormat('dd-MM-yyyy').format(today)
                                ? false
                                : true,
                          ))
                      .toList(),
                );
              }),
              SizedBox(
                height: 7,
              ),
              GetX<SlotController>(builder: (controller) {
                return Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  direction: Axis.horizontal,
                  children: controller.bookedList
                      .map((i) => AvailableTime(
                            slot: i,
                            selDate: _dateController.text,
                          ))
                      .toList(),
                );
              }),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
        ));
  }

  Widget dateTextField() {
    return SizedBox(
      height: 75.h,
      child: TextField(
          // validator: (value) {
          //   if (value!.isEmpty) return "Please Select Date";
          // },
          controller: _dateController,
          decoration: InputDecoration(
            // suffixIcon: const Icon(
            //   MdiIcons.asterisk,
            //   color: Colors.red,
            //   size: 10,
            // ),
            suffixIcon: Icon(
              Icons.calendar_today,
              color: AppColors.mainColor,
            ), //icon of text field
            // hintText: "Date of Birth", //label text of field
            // helperText: "Age should be Grater than 18",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  color: AppColors.mainColor,
                )),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.mainColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.mainColor)),
          ),
          readOnly: true,
          onTap: () async {
            // dateclicked == true
            //      ?
            //   Future.delayed(Duration(milliseconds: 2000), () { dateclicked == false;})
            // if (dateclicked == false) {
            //   dateclicked == true;
            //   Future.delayed(Duration(milliseconds: 5622000), () {
            //     dateclicked == false;
            //   });
            pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(today.year, today.month, today.day),
              firstDate: DateTime(2022),
              lastDate: DateTime(today.year, today.month, today.day + 10),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.mainColor, // <-- SEE HERE
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('dd-MM-yyyy').format(pickedDate!);
              setState(() {
                _dateController.text = formattedDate;

                // fetchAppointment();
              });
              bookedSlotController.timelist.value = [];
              await DateTime.now().isBefore(pickedDate!) ||
                      _dateController.text ==
                          DateFormat('dd-MM-yyyy').format(today)
                  ? fetchAppointment()
                  : fetchPastAppointment();
              // }
              ;
            }
          }),
    );
  }
}
