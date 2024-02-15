import 'dart:convert';

import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controller/TextController.dart';
import '../../networkhandler.dart';
import '../Utils/Utiils.dart';
import 'Registeration/forgotPassword.dart';
import 'Registeration/otpverify.dart';
import 'Registeration/registration2.dart';
import 'Registeration/registration3.dart';
import 'Registeration/signupPage.dart';
import 'Registeration/subPayment.dart';
import 'nav_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GetStorage box = GetStorage();
  NetworkHandler networkHandler = NetworkHandler();
  bool vis = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final TextController textController = Get.find<TextController>();
  String errorText = '';
  bool validate = false;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Container(
                height: Dimention.screenHeight - 20,
                width: Dimention.screenWidth,
                child: Form(
                  key: _globalkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0, bottom: 70),
                        child: Center(
                            child: Image.asset(
                          "assets/logo.png",
                          height: 150,
                        )),
                      ),
                      Center(child: usernameTextField()),
                      SizedBox(
                        height: 7,
                      ),
                      Center(child: passwordTextField()),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            FocusScope.of(context).unfocus();

                            if (_globalkey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return Container(
                                    color: Colors.transparent,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              );
                              Map<String, dynamic> data = {
                                "username": _usernameController.text,
                                "password": _passwordController.text
                              };
                              var response =
                                  await networkHandler.post("/login", data);
                              Map<String, dynamic> output =
                                  json.decode(response.body);
                              output["_id"] != null
                                  ? textController.userid.value = output["_id"]
                                  : null;
                              output["name"] != null
                                  ? textController.name.value = output["name"]
                                  : null;
                              output["phone"] != null
                                  ? textController.phone.value = output["phone"]
                                  : null;
                              if (response.statusCode == 200 ||
                                  response.statusCode == 201) {
                                box.write("token", output["token"]);
                                Get.offAll(()=>navScreen());
                              } else {
                                Get.back();
                                if (response.statusCode == 403) {
                                  if (output["lvl"] == "1") {
                                    Get.to(OtpVerify());
                                  } else if (output["lvl"] == "2") {
                                    Get.to(Registration2());
                                  } else if (output["lvl"] == "3") {
                                    Get.to(Registration3());
                                  } else if (output["lvl"] == "4") {
                                    Get.to(SubPayment());
                                  } else if (output["status"] == "block") {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "your account has been Blocked. Contact support for more information"),
                                      backgroundColor: Colors.red,
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(output["msg"]),
                                      backgroundColor: Colors.red,
                                      elevation: 10,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(5),
                                    ));
                                  }
                                } else {
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

                              // Get.offAll(navScreen());
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
                                      "LOGIN",
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
                      Center(
                          child: GestureDetector(
                        onTap: () {
                          Get.to(() => ForgetPassword());
                        },
                        child: const Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 11),
                          ),
                        ),
                      )),
                      Center(
                          child: GestureDetector(
                              onTap: () => {Get.to(() => Siginup())},
                              child: Text(
                                "Signup Now",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue[900],
                                    fontSize: 15),
                              )))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
          hintText: " User Id / Email Address"),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value!.isEmpty) return "Password can't be empty";
        if (value.length < 8) return "Invalid Password";
        return null;
      },
      obscureText: vis,
      decoration: InputDecoration(
        // errorText: validate ? null : errorText,
        suffixIcon: IconButton(
          color: AppColors.mainColor,
          icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              vis = !vis;
            });
          },
        ),
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
        // helperStyle: TextStyle(color:, fontSize: 5),
        hintStyle: TextStyle(
          fontSize: 16,
        ),
        hintText: "Password",
      ),
    );
  }
}
