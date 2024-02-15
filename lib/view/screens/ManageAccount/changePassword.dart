import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
// import '../../widgets/widgets.dart';
import '../../widgets/big_text.dart';
import '../loginPage.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //  TextController textController = Get.find<TextController>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _codeController = TextEditingController();
  final _globalkey = GlobalKey<FormState>();
  late List<String> result;
  bool otp = false;
  bool circular = false;
  String? errorText;
  bool validate = false;
  bool vis = true;
  bool vis2 = true;
  bool vis3 = true;
  TextEditingController _oldpasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  var log = new Logger();
  GetStorage box = GetStorage();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Change Password",
            color: Colors.white,
            size: 17,
            weight: FontWeight.w300,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                    oldPasswordTextField(),
                    SizedBox(
                      height: 25,
                    ),
                    passwordTextField(),
                    SizedBox(
                      height: 25,
                    ),
                    RepasswordTextField(),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 225,
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
                                  "currpassword": _oldpasswordController.text,
                                  "newpassword": _passwordController.text
                                };

                                var response = await networkHandler.post2(
                                    "/change-password", data);
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  Get.back();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("Password Successfully updated"),
                                    backgroundColor: AppColors.mainColor,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                  ));
                                  Future.delayed(Duration(milliseconds: 2000),
                                      () {
                                    box.remove("token");
                                    Get.offAll(()=>LoginPage());
                                  });
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
                            }
                          },
                          child: BigText(
                            text: "Change Password",
                            color: Colors.white,
                            size: 16,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ),
        ));
  }

  Widget oldPasswordTextField() {
    return TextFormField(
      controller: _oldpasswordController,
      validator: (value) {
        if (value!.isEmpty) return "Password can't be empty";
        if (value.length < 8) return "Wrong Password";
        return null;
      },
      obscureText: vis3,
      decoration: InputDecoration(
        // errorText: validate ? null : errorText,
        suffixIcon: IconButton(
          color: AppColors.mainColor,
          icon: Icon(vis3 ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              vis3 = !vis3;
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
        hintText: "Current Password",
      ),
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value!.isEmpty) return "Password can't be empty";
        if (value.length < 8) return "Password should be strong";
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

  Widget RepasswordTextField() {
    return TextFormField(
      controller: _repasswordController,
      validator: (value) {
        if (value!.isEmpty) return "Password can't be empty";
        if (value.length < 8) return "Password should be strong";
        if (value != _passwordController.text) return "Password Not Matching";
        return null;
      },
      obscureText: vis2,
      decoration: InputDecoration(
        // errorText: validate ? null : errorText,
        suffixIcon: IconButton(
          color: AppColors.mainColor,
          icon: Icon(vis2 ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              vis2 = !vis2;
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
        hintText: "Re enter Password",
      ),
    );
  }
}
