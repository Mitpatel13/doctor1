import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/TextController.dart';
import '../../../model/bookedSlotModel.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class Summary extends StatelessWidget {
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _medicinesController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  TextController textController = Get.find<TextController>();
  String summary;
  BookedSlotModel bookedSlotModel;
  Summary({
    required this.bookedSlotModel,
    required this.summary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    _summaryController.text = summary;
    return Scaffold(
      body: Container(
        height: Dimention.screenHeight,
        width: Dimention.screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/letterPad.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 2.h, right: 4.h, top: 6.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(top: 5.h),
                      color: Colors.green.shade100,
                      // height: 100,
                      width: Dimention.screenWidth / 1.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: textController.name.toString(),
                            size: 18,
                            weight: FontWeight.w600,
                            color: AppColors.secondColor,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SmallText(
                            text: textController.qualification.toString(),
                            size: 12,
                            fontWeight: FontWeight.w300,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SmallText(
                            text: "Reg No:${textController.regNo.toString()}",
                            size: 12,
                            fontWeight: FontWeight.w300,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/logo.png',
                      height: 70,
                      width: 70,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallText(
                      size: 15,
                      text: "Name: ${bookedSlotModel.patientname}",
                      fontWeight: FontWeight.w400,
                    ),
                    SmallText(
                      size: 15,
                      text: "Date: ${bookedSlotModel.date}",
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 30,
                ),
                SmallText(text: "Summary"),
                summaryTextField(),
                summary == ""
                    ? SmallText(text: "Medicines")
                    : SizedBox.shrink(),
                summary == "" ? MedicinesTextField() : SizedBox.shrink(),
                SizedBox(
                  height: 30,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if (_medicinesController.text == "" &&
                            _summaryController.text == "") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Discribe something to submit"),
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
                            "patientid": bookedSlotModel.patientid,
                            "time": bookedSlotModel.time,
                            "date": bookedSlotModel.date,
                            "summary": summary == ""
                                ? _summaryController.text +
                                    "\n\n\n" +
                                    _medicinesController.text
                                : _summaryController.text
                          };

                          var response =
                              await networkHandler.post2("/addSummary", data);
                          if (response.statusCode == 200 ||
                              response.statusCode == 201) {
                            bookedSlotModel.summary = true;
                            Get.back();
                            Get.back();
                          } else {
                            Get.back();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Error to uplaod please try again"),
                              backgroundColor: Colors.red,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            ));
                          }
                        }
                      },
                      //  else {
                      //   Get.off(OtpVerify());
                      // },
                      child: Container(
                        width: Dimention.screenWidth / 2.8,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: AppColors.mainColor,
                        ),
                        child: const Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget summaryTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: TextFormField(
          maxLines: summary == "" ? 5 : 15,
          controller: _summaryController,
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
            hintText: "Summary",
          ),
        ),
      ),
    );
  }

  Widget MedicinesTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: TextFormField(
          maxLines: 12,
          controller: _medicinesController,
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
            hintText: "Medicines",
          ),
        ),
      ),
    );
  }
}
