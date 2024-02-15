import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../controller/TextController.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../loginPage.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
   TextController textController = Get.find<TextController>();
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
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  var log = new Logger();
  @override
  void initState() {
    super.initState();
    _usernameController.text = textController.email.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Forget Password",
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
                    usernameTextField(),
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
                                  "_id": textController.userid.toString(),
                                  "password": _passwordController.text
                                };

                                var response = await networkHandler.post(
                                    "/reset-password", data);
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  // ignore: use_build_context_synchronously
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
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                                                      text: "Successful!!",
                                                      color:
                                                          AppColors.mainColor,
                                                      size: 25,
                                                      weight: FontWeight.w500,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Center(
                                                      child: Text(
                                                        "Password Successfully Reset\n You can enjoy the Vaidhya Now ",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 12,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    96,
                                                                    95,
                                                                    95),
                                                            fontStyle: FontStyle
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
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: AppColors
                                                                  .mainColor),
                                                      onPressed: () => {
                                                            Get.offAll(()=>LoginPage())
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
                            text: "Reset Password",
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

  Widget usernameTextField() {
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
          controller: _usernameController,
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
