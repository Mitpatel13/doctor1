import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../../widgets/widgets.dart';

class Consulting extends StatefulWidget {
  const Consulting({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConsultingState createState() => _ConsultingState();
}

class _ConsultingState extends State<Consulting> {
  TextEditingController _clinicController = TextEditingController();
  TextEditingController _inCallController = TextEditingController();
  TextEditingController _videoController = TextEditingController();
  TextEditingController _doorController = TextEditingController();
  var index = 0;
  bool circular = false;
  bool resRecived = false;
  NetworkHandler networkHandler = NetworkHandler();
  final _globalkey = GlobalKey<FormState>();
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
  bool inclinicbox = false;
  bool oncallbox = false;
  bool onvideobox = false;
  bool doorbox = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPayment();
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
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
        }));
  }

  void fetchPayment() async {
    var response = await networkHandler.get("/findConsultingFee");
    Get.back();
    setState(() {
      resRecived = true;
      _clinicController.text = response["inClinic"];
      _clinicController.text != "0" ? inclinicbox = true : inclinicbox = false;
      _inCallController.text = response["onCall"];
      _inCallController.text != "0" ? oncallbox = true : oncallbox = false;
      _videoController.text = response["onVideo"];
      _videoController.text != "0" ? onvideobox = true : onvideobox = false;
      _doorController.text = response["doorStep"];
      _doorController.text != "0" ? doorbox = true : doorbox = false;
    });

    // slotController.bookedList.value = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Consulting",
          color: Colors.white,
          size: 17,
          weight: FontWeight.w300,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _globalkey,
            child: Column(
              children: [
                CheckboxListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0), // Optionally
                    side: BorderSide(color: AppColors.mainColor),
                  ),
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            treattypeicons[0],
                            color: AppColors.secondColor,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            treattypeName[0],
                          )
                        ],
                      ),
                      inclinicbox
                          ? TextFormField(
                              validator: (value) {
                                if (inclinicbox && value!.isEmpty)
                                  return "Amount Cant be empty";
                                if (!RegExp(r'^-?[0-9]+$').hasMatch(value!))
                                  return "Invalid Amound";
                                return null;
                                // if (value.length < 3) return "Invalid Name";
                              },
                              controller: _clinicController,
                              decoration: InputDecoration(
                                // errorText: validate ? null : errorText,
                                suffixIcon: Icon(
                                  MdiIcons.asterisk,
                                  color: Colors.red,
                                  size: 10,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: BorderSide(
                                      color: AppColors.mainColor,
                                    )),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                // helperStyle: TextStyle(color:, fontSize: 5),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                ),
                                hintText: "In clinic Consulting Fee",
                              ),
                              keyboardType: TextInputType.number)
                          : SizedBox.shrink()
                    ],
                  ),
                  value: inclinicbox,
                  onChanged: (newValue) {
                    setState(() {
                      inclinicbox = newValue!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CheckboxListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0), // Optionally
                    side: BorderSide(color: AppColors.mainColor),
                  ),
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            treattypeicons[1],
                            color: AppColors.secondColor,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            treattypeName[1],
                          )
                        ],
                      ),
                      oncallbox
                          ? TextFormField(
                              validator: (value) {
                                if (oncallbox && value!.isEmpty)
                                  return "Amount Cant be empty";
                                if (!RegExp(r'^-?[0-9]+$').hasMatch(value!))
                                  return "Invalid Amound";
                                return null;
                              },
                              controller: _inCallController,
                              decoration: InputDecoration(
                                // errorText: validate ? null : errorText,
                                suffixIcon: Icon(
                                  MdiIcons.asterisk,
                                  color: Colors.red,
                                  size: 10,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: BorderSide(
                                      color: AppColors.mainColor,
                                    )),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                // helperStyle: TextStyle(color:, fontSize: 5),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                ),
                                hintText: "On call consulting fee",
                              ),
                              keyboardType: TextInputType.number)
                          : SizedBox.shrink()
                    ],
                  ),
                  value: oncallbox,
                  onChanged: (newValue) {
                    setState(() {
                      oncallbox = newValue!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CheckboxListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0), // Optionally
                    side: BorderSide(color: AppColors.mainColor),
                  ),
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            treattypeicons[2],
                            color: AppColors.secondColor,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            treattypeName[2],
                          )
                        ],
                      ),
                      onvideobox
                          ? TextFormField(
                              validator: (value) {
                                if (onvideobox && value!.isEmpty)
                                  return "Amount Cant be empty";
                                if (!RegExp(r'^-?[0-9]+$').hasMatch(value!))
                                  return "Invalid Amound";
                                return null;
                              },
                              controller: _videoController,
                              decoration: InputDecoration(
                                // errorText: validate ? null : errorText,
                                suffixIcon: Icon(
                                  MdiIcons.asterisk,
                                  color: Colors.red,
                                  size: 10,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: BorderSide(
                                      color: AppColors.mainColor,
                                    )),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                // helperStyle: TextStyle(color:, fontSize: 5),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                ),
                                hintText: "Video Call Consulting Fee",
                              ),
                              keyboardType: TextInputType.number)
                          : SizedBox.shrink()
                    ],
                  ),
                  value: onvideobox,
                  onChanged: (newValue) {
                    setState(() {
                      onvideobox = newValue!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CheckboxListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0), // Optionally
                    side: BorderSide(color: AppColors.mainColor),
                  ),
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            treattypeicons[3],
                            color: AppColors.secondColor,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            treattypeName[3],
                          )
                        ],
                      ),
                      doorbox
                          ? TextFormField(
                              validator: (value) {
                                if (doorbox && value!.isEmpty)
                                  return "Amount Cant be empty";
                                if (!RegExp(r'^-?[0-9]+$').hasMatch(value!))
                                  return "Invalid Amound";
                                return null;
                              },
                              controller: _doorController,
                              decoration: InputDecoration(
                                // errorText: validate ? null : errorText,
                                suffixIcon: Icon(
                                  MdiIcons.asterisk,
                                  color: Colors.red,
                                  size: 10,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                    borderSide: BorderSide(
                                      color: AppColors.mainColor,
                                    )),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.mainColor)),
                                // helperStyle: TextStyle(color:, fontSize: 5),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                ),
                                hintText: "Door step Consulting fee",
                              ),
                              keyboardType: TextInputType.number)
                          : SizedBox.shrink()
                    ],
                  ),
                  value: doorbox,
                  onChanged: (newValue) {
                    setState(() {
                      doorbox = newValue!;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      if (!inclinicbox &&
                          !oncallbox &&
                          !onvideobox &&
                          !doorbox) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please select Options"),
                          backgroundColor: Colors.red,
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        ));
                      } else {
                        if (_globalkey.currentState!.validate()) {
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Icon(
                                                      MdiIcons
                                                          .closeCircleOutline,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                "This will Remove all the Appointmnets created with Unselected list ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 11,
                                                    color: Color.fromARGB(
                                                        255, 96, 95, 95),
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.w200),
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
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                                Map<String, dynamic> data = {
                                                  "inClinic": inclinicbox
                                                      ? _clinicController.text
                                                      : "0",
                                                  "onCall": oncallbox
                                                      ? _inCallController.text
                                                      : "0",
                                                  "onVideo": onvideobox
                                                      ? _videoController.text
                                                      : "0",
                                                  "doorStep": doorbox
                                                      ? _doorController.text
                                                      : "0",
                                                  "inClinicStatus":
                                                      inclinicbox ? 0 : 1,
                                                  "onCallStatus":
                                                      oncallbox ? 0 : 2,
                                                  "onVideoStatus":
                                                      onvideobox ? 0 : 3,
                                                  "doorStepStatus":
                                                      doorbox ? 0 : 4,
                                                };
                                                var response =
                                                    await networkHandler.post2(
                                                        "/updateConsultingFee",
                                                        data);
                                                Map<String, dynamic> output =
                                                    json.decode(response.body);
                                                // print(output);

                                                if (response.statusCode ==
                                                        200 ||
                                                    response.statusCode ==
                                                        201) {
                                                  Get.back();
                                                  Get.back();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Successfully Updated"),
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    elevation: 10,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(5),
                                                  ));
                                                } else {
                                                  Get.back();
                                                  Get.back();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Error to proceess , Please try later"),
                                                    backgroundColor: Colors.red,
                                                    elevation: 10,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin: EdgeInsets.all(5),
                                                  ));
                                                }
                                              },
                                              child: const Text(
                                                "Okay",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              )),
                                        ),
                                      )),
                                );
                              });
                        }
                      }
                    },
                    child: Container(
                      width: Dimention.screenWidth / 2.2,
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
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






















// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// import '../Utils/Utiils.dart';
// import '../widgets/widgets.dart';

// class Consulting extends StatefulWidget {
//   const Consulting({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ConsultingState createState() => _ConsultingState();
// }

// class _ConsultingState extends State<Consulting> {
//   TextEditingController _phoneController = TextEditingController();
//   final List<SimpleModel> _items = <SimpleModel>[
//     SimpleModel('IN Clinic', false),
//     SimpleModel('On Call', false),
//     SimpleModel('On Video', false),
//     SimpleModel('Door Step', false),
//   ];
//   var index = 0;
//   bool circular = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.mainColor,
//         title: BigText(
//           text: "Consulting",
//           color: Colors.white,
//           size: 17,
//           weight: FontWeight.w300,
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             // height: Dimention.screenHeight / 2,
//             child: ListView(
//               shrinkWrap: true,
//               padding: const EdgeInsets.all(8),
//               children: _items
//                   .map(
//                     (SimpleModel item) => Column(
//                       children: [
//                         CheckboxListTile(
//                           title: Text(item.title),
//                           value: item.isChecked,
//                           onChanged: (bool? val) {
//                             setState(() {
//                               item.isChecked = val!;
//                               val == true
//                                   ? TextFormField(
//                                       validator: (value) {
//                                         if (value!.isEmpty)
//                                           return "fees Can't be empty";
//                                         return null;
//                                       },
//                                       controller: _phoneController,
//                                       decoration: InputDecoration(
//                                         // errorText: validate ? null : errorText,
//                                         suffixIcon: Icon(
//                                           MdiIcons.asterisk,
//                                           color: Colors.red,
//                                           size: 10,
//                                         ),
//                                         contentPadding: EdgeInsets.fromLTRB(
//                                             20.0, 10.0, 20.0, 10.0),
//                                         enabledBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(3),
//                                             borderSide: BorderSide(
//                                               color: AppColors.mainColor,
//                                             )),
//                                         border: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: AppColors.mainColor)),
//                                         focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: AppColors.mainColor)),
//                                         // helperStyle: TextStyle(color:, fontSize: 5),
//                                         hintStyle: TextStyle(
//                                           fontSize: 16,
//                                         ),
//                                         hintText: "Fees",
//                                       ),
//                                       // maxLength: 10,
//                                       keyboardType: TextInputType.number,
//                                     )
//                                   : SizedBox.shrink();
//                             });
//                           },
//                         ),
//                         index == 1
//                             ? TextFormField(
//                                 validator: (value) {
//                                   if (value!.isEmpty)
//                                     return "fees Can't be empty";
//                                   return null;
//                                 },
//                                 controller: _phoneController,
//                                 decoration: InputDecoration(
//                                   // errorText: validate ? null : errorText,
//                                   suffixIcon: Icon(
//                                     MdiIcons.asterisk,
//                                     color: Colors.red,
//                                     size: 10,
//                                   ),
//                                   contentPadding: EdgeInsets.fromLTRB(
//                                       20.0, 10.0, 20.0, 10.0),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(3),
//                                       borderSide: BorderSide(
//                                         color: AppColors.mainColor,
//                                       )),
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColors.mainColor)),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: AppColors.mainColor)),
//                                   // helperStyle: TextStyle(color:, fontSize: 5),
//                                   hintStyle: TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                   hintText: "Fees",
//                                 ),
//                                 // maxLength: 10,
//                                 keyboardType: TextInputType.number,
//                               )
//                             : SizedBox.shrink()
//                       ],
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//           Center(
//             child: InkWell(
//               onTap: () async {
//                 // showDialog(
//                 //   context: context,
//                 //   barrierDismissible: false,
//                 //   builder: (context) {
//                 //     return Container(
//                 //       color: Colors.transparent,
//                 //       child: Center(
//                 //         child: CircularProgressIndicator(
//                 //           color: Colors.white,
//                 //         ),
//                 //       ),
//                 //     );
//                 //   },
//                 // );
//                 // Map<String, dynamic> data = {
//                 //   "username": _usernameController.text,
//                 //   "password": _passwordController.text
//                 // };
//                 // var response = await networkHandler.post("/login", data);
//                 // Map<String, dynamic> output = json.decode(response.body);
//                 // print(output);
//                 // output["_id"] != null
//                 //     ? textController.userid.value = output["_id"]
//                 //     : null;
//                 // output["name"] != null
//                 //     ? textController.name.value = output["name"]
//                 //     : null;
//                 // output["phone"] != null
//                 //     ? textController.phone.value = output["phone"]
//                 //     : null;
//                 // // print(textController.userid);
//                 // // print(output);

//                 // if (response.statusCode == 200 ||
//                 //     response.statusCode == 201) {
//                 //   box.write("token", output["token"]);
//                 //   print(box.read("token"));
//                 //   Get.offAll(navScreen());
//                 // } else {
//                 //   Get.back();
//                 //   if (response.statusCode == 403) {
//                 //     if (output["lvl"] == "1") {
//                 //       Get.to(OtpVerify());
//                 //     } else if (output["lvl"] == "2") {
//                 //       Get.to(Registration2());
//                 //     } else if (output["lvl"] == "3") {
//                 //       Get.to(Registration3());
//                 //     } else if (output["status"] == "block") {
//                 //       // ignore: use_build_context_synchronously
//                 //       ScaffoldMessenger.of(context)
//                 //           .showSnackBar(const SnackBar(
//                 //         content: Text(
//                 //             "your account has been Blocked. Contact support for more information"),
//                 //         backgroundColor: Colors.red,
//                 //         elevation: 10,
//                 //         behavior: SnackBarBehavior.floating,
//                 //         margin: EdgeInsets.all(5),
//                 //       ));
//                 //     } else {
//                 //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 //         content: Text(output["msg"]),
//                 //         backgroundColor: Colors.red,
//                 //         elevation: 10,
//                 //         behavior: SnackBarBehavior.floating,
//                 //         margin: EdgeInsets.all(5),
//                 //       ));
//                 //     }
//                 //   } else {
//                 //     // print("hello");
//                 //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 //       content: Text(output["msg"]),
//                 //       backgroundColor: Colors.red,
//                 //       elevation: 10,
//                 //       behavior: SnackBarBehavior.floating,
//                 //       margin: EdgeInsets.all(5),
//                 //     ));
//                 //   }
//                 // }

//                 // Get.offAll(navScreen());
//                 // }
//               },
//               child: Container(
//                 width: Dimention.screenWidth / 2.2,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(7),
//                   color: AppColors.mainColor,
//                 ),
//                 child: Center(
//                   child: circular
//                       ? CircularProgressIndicator(
//                           color: Colors.white,
//                         )
//                       : Text(
//                           "Submit",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SimpleModel {
//   String title;
//   bool isChecked;

//   SimpleModel(this.title, this.isChecked);
// }
