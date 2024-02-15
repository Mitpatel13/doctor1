import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';
import 'package:vidhya_doctors/view/screens/Registeration/resetPassword.dart';
import '../../../controller/TextController.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _codeController = TextEditingController();
   TextController textController = Get.find<TextController>();
  final _globalkey = GlobalKey<FormState>();
  late List<String> result;
  bool otp = false;
  bool circular = false;
  String? errorText;
  bool validate = false;
  TextEditingController _usernameController = TextEditingController();
  var log = new Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Forgot Password",
            color: Colors.white,
            size: 17,
            weight: FontWeight.w300,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Form(
              key: _globalkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Center(
                          child: Image.asset(
                        'assets/logo.png',
                        height: 100,
                        width: 100,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: usernameTextField(),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.mainColor),
                            // enableFeedback: false
                            shadowColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                            elevation: MaterialStateProperty.all(4),
                          ),
                          onPressed: () async {
                            if (!otp) {
                              FocusScope.of(context).unfocus();
                              if (_globalkey.currentState!.validate()) {
                                Map<String, dynamic> data = {
                                  "username": _usernameController.text,
                                };

                                var response = await networkHandler.post(
                                    "/forget_password", data);

                                Map<String, dynamic> output =
                                    json.decode(response.body);

                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  textController.userid.value = output["_id"];
                                  setState(() {
                                    otp = true;
                                  });
                                } else {
                                  // Get.back();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
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
                          child: BigText(
                            text: "GET OTP",
                            color: Colors.white,
                            size: 16,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    otp
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              codeTextField(),
                              SizedBox(
                                height: 20,
                              ),
                              // ignore: deprecated_member_use
                              // Center(
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       SmallText(
                              //         text: "Did not receive an OTP?",
                              //         color: Colors.black54,
                              //       ),
                              //       SizedBox(
                              //         width: 3,
                              //       ),
                              //       GestureDetector(
                              //           onTap: () => {
                              //                 // Get.to(Siginup())
                              //               },
                              //           child: Text(
                              //             "Resend",
                              //             style: TextStyle(
                              //                 decoration:
                              //                     TextDecoration.underline,
                              //                 color: AppColors.mainColor,
                              //                 fontSize: 15),
                              //           )),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              // ignore: deprecated_member_use
                              SizedBox(
                                width: 35.w,
                                height: 5.h,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.mainColor),
                                  ),
                                  onPressed: () async {
                                    if (_codeController.text.length < 4) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Invalid Code"),
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
                                      // print(textController.userid.toString());
                                      Map<String, dynamic> data = {
                                        "_id": textController.userid.toString(),
                                        "code": int.parse(_codeController.text)
                                      };

                                      var response = await networkHandler.post(
                                          "/verifyforgetpassword", data);
                                      Map<String, dynamic> output =
                                          json.decode(response.body);
                                      if (response.statusCode == 200 ||
                                          response.statusCode == 201) {
                                        textController.email.value =
                                            _usernameController.text;
                                        Get.off(ResetPassword());
                                      } else {
                                        Get.back();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(output["msg"]),
                                          backgroundColor: Colors.red,
                                          elevation: 10,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(5),
                                        ));
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: circular
                                        ? CircularProgressIndicator(
                                            backgroundColor: Colors.white70,
                                          )
                                        : const Text(
                                            "Verify OTP",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink()
                  ]),
            ),
          ),
        ));
  }

  Widget usernameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "User Id can't be  empty";
        if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(value)) return "Invalid User Id";

        return null;
      },
      controller: _usernameController,
      decoration: InputDecoration(
          // errorText: validate ? null : errorText,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                color: AppColors.mainColor,
              )),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor)),
          helperStyle: TextStyle(color: Colors.grey[400], fontSize: 5),
          hintStyle: TextStyle(
            fontSize: 16,
          ),
          // labelText: "Enter User Id or Email Address",
          hintText: "Email Address"),
      keyboardType: TextInputType.emailAddress,
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
