import 'dart:convert';

import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vidhya_doctors/view/screens/Registeration/registration2.dart';
import '../../../controller/TextController.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';

class OtpVerify extends StatefulWidget {
  OtpVerify({
    Key? key,
  }) : super(key: key);
  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  bool vis = true;
  bool firstClick = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _codeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool validate = false;
  bool circular = false;
   TextController textController = Get.find<TextController>();
  bool _isButtonDisabled = false;

  _disableButton() {
    setState(() {
      _isButtonDisabled = true;
    });

    Future.delayed(Duration(seconds: 30), () {
      setState(() {
        _isButtonDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _phoneController.text = textController.phone.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Verify Phone",
          color: Colors.white,
          size: 17,
          weight: FontWeight.w300,
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _globalkey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
                  child: Center(
                      child: Image.asset(
                    "assets/logo.png",
                    height: 100,
                    width: 100,
                  )),
                ),
                // SizedBox(height: 10),
                // BigText(
                //   text: "9496473754",
                //   color: AppColors.secondColor,
                //   decoration: TextDecoration.underline,
                //   weight: FontWeight.w400,
                // ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 70, right: 70, bottom: 30),
                  child: PhoneTextField(),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                codeTextField(),
                SizedBox(
                  height: 15,
                ),
                // ignore: deprecated_member_use
                InkWell(
                  // elevation: 5,
                  onTap: () async {
                    // print(_isButtonDisabled);
                    if (_isButtonDisabled == false) {
                      _disableButton();
                      Map<String, String> data = {
                        "_id": textController.userid.toString()
                      };
                      var response =
                          await networkHandler.post("/resendCode", data);
                    }
                    // _isButtonDisabled
                    //     ? null
                    //     : () async {
                    //         // _disableButton();
                    //         print("hello");
                    //         Map<String, String> data = {
                    //           "_id": textController.userid.toString()
                    //         };

                    //         var response =
                    //             await networkHandler.post("/resendCode", data);
                    //       };
                  },
                  child: Text(
                    "Resend Code ",
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // ignore: deprecated_member_use
                InkWell(
                  onTap: () async {
                    if (_globalkey.currentState!.validate()) {
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
                        "_id": textController.userid.toString(),
                        "code": int.parse(_codeController.text)
                      };

                      var response =
                          await networkHandler.post("/verifyPhone", data);
                      Map<String, dynamic> output = json.decode(response.body);
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        // ignore: use_build_context_synchronously
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Registration2()));
                        Get.back();
                        Get.off(Registration2());
                      } else {
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(output["msg"]),
                          backgroundColor: Colors.red,
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        ));
                      }
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: circular
                          ? CircularProgressIndicator(
                              backgroundColor: Colors.white70,
                            )
                          : Text(
                              "Verify Phone",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
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

  Widget PhoneTextField() {
    return SizedBox(
      height: 50,
      child: TextFormField(
          style: TextStyle(
            wordSpacing: 3,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          readOnly: true,
          controller: _phoneController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 221, 220, 220),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: BorderSide(
                  color: AppColors.secondColor,
                )),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondColor)),
          )),
    );
  }

  Widget codeTextField() {
    return SizedBox(
      width: 40.w,
      child: TextFormField(
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 10),
        textAlign: TextAlign.center,
        controller: _codeController,
        validator: (value) {
          if (value!.isEmpty) return "code can't be empty";
          if (value.length < 4) return "Incorrect code";

          return null;
        },
        maxLength: 4,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: "",
          // errorText: validate ? null : errorText,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.mainColor,
              width: 2,
            ),
          ),
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
          hintText: "0 0 0 0",
        ),
      ),
    );
  }
}
