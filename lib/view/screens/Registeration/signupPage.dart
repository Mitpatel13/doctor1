
import 'dart:convert';

import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controller/TextController.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'mapScreen.dart';
import 'otpverify.dart';

class Siginup extends StatefulWidget {
  const Siginup({super.key});
  @override
  State<Siginup> createState() => _SiginupState();
}

class _SiginupState extends State<Siginup> {
  @override
  bool agree = false;
  bool _agree = false;
  bool vis = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  NetworkHandler networkHandler = NetworkHandler();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // ignore: avoid_init_to_null
  String? latitudeData = null;
   TextController textController = Get.find<TextController>();
  // ignore: avoid_init_to_null
  String? longtitudeData = null;
  Position? position;
  @override
  void initState() {
    super.initState();
    _determinePosition();

    // print
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      var result = await Geolocator.openLocationSettings();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // print(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }
    serviceEnabled
        ? Geolocator.getCurrentPosition().then((value) {
            setState(() {
              latitudeData = '${value.latitude}';
              longtitudeData = '${value.longitude}';
              textController.latitude.value = '${value.latitude}';
              textController.lontitude.value = '${value.longitude}';
            });
          })
        : null;
    // permission == LocationPermission.always ||
    //         permission == LocationPermission.whileInUse
    //     ? Geolocator.getCurrentPosition().then((value) {
    //         setState(() {
    //           latitudeData = '${value.latitude}';
    //           longtitudeData = '${value.longitude}';
    //           print(latitudeData);
    //         });
    //       })
    //     : null;

    //print(await Geolocator.getCurrentPosition());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Registration",
          color: Colors.white,
          size: 17,
          weight: FontWeight.w300,
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _globalkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 6.h),
                      child: Center(
                          child: Image.asset(
                        "assets/logo.png",
                        height: 100,
                        width: 100,
                      )),
                    ),
                    Center(child: nameTextField()),
                    SizedBox(
                      height: 12,
                    ),
                    Center(child: emailTextField()),
                    SizedBox(
                      height: 10,
                    ),
                    // Center(
                    //     child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(right: 5),
                    //       child: Container(
                    //         height: 48,
                    //         width: 50,
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: AppColors.mainColor),
                    //             borderRadius: BorderRadius.circular(3)),
                    //         child: Center(child: Text("+91")),
                    //       ),
                    //     ),
                    //     Expanded(child: mobileTextField()),
                    //   ],
                    // )),
                    mobileTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: passwordTextField()),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (longtitudeData == null || latitudeData == null) {
                            _determinePosition();
                          } else {
                            Get.to(MapScreen());
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.navigation,
                              color: AppColors.secondColor,
                              size: 25,
                            ),
                            SmallText(
                              text: "Choose the location",
                              size: 15,
                              fontWeight: FontWeight.w300,
                            )
                          ],
                        )),

                    Center(
                      child: SizedBox(
                        width: Dimention.screenWidth / 1.7,
                        child: CheckboxListTile(
                            side: BorderSide(
                                color: _agree ? Colors.red : Colors.grey,
                                width: 2),
                            activeColor: AppColors.mainColor,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: GestureDetector(
                              onTap: () {
                                _launchURL() async {
                                  var url =
                                      "https://vaidhya421.herokuapp.com/termsAndConditions";
                                  if (await launch(url)) {
                                    await canLaunch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }

                                _launchURL();
                              },
                              child: const Text('Terms & Condition',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 13,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w100)),
                            ),
                            value: agree,
                            onChanged: (value) {
                              setState(() {
                                agree = value!;
                              });
                            }),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (longtitudeData == null || latitudeData == null) {
                            _determinePosition();
                          } else {
                            if (agree) {
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
                                  "name": _nameController.text,
                                  "phone": _phoneController.text,
                                  "email": _emailController.text,
                                  "password": _passwordController.text,
                                  "longtitude": textController.lontitude.value,
                                  "latitude": textController.latitude.value,
                                };

                                var response = await networkHandler.post(
                                    "/register1", data);
                                textController.phone.value =
                                    _phoneController.text;
                                textController.email.value =
                                    _emailController.text;
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                // print(output["_id"]);
                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  textController.userid.value = output["_id"];
                                  // ignore: use_build_context_synchronously
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => OtpVerify()));
                                  Get.back();
                                  Get.off(() => OtpVerify());
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
                            } else {
                              setState(() {
                                _agree = true;
                              });
                            }
                            // setState(() {
                            //   circular = false;
                            // });
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
                              "SIGN UP",
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
          ],
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "Password can't be empty";
        if (value.length < 8) return "Password should be strong";
        return null;
      },
      controller: _passwordController,
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

  Widget emailTextField() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) return " Email Address can't be  empty";
          if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
              .hasMatch(value)) return "Invalid  Email Address";

          return null;
        },
        controller: _emailController,
        decoration: InputDecoration(
            suffixIcon: Icon(
              MdiIcons.asterisk,
              color: Colors.red,
              size: 10,
            ),
            // errorText: validate ? null : errorText,
            // suffixIcon:  Icon( Icons.star ,color: Colors.red,size: 10,),

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
            hintText: " Email Address "),
        keyboardType: TextInputType.emailAddress);
  }

  Widget mobileTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "Phone Number Can't be empty";
        if (value.contains(" ")) return "Invalid Phone Number ";
        if (value.length < 10) return "Phone Number is Invalid";
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        counterText: "",
        prefixText: "+91 ",
        // errorText: validate ? null : errorText,
        suffixIcon: Icon(
          MdiIcons.asterisk,
          color: Colors.red,
          size: 10,
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
        hintText: "Mobile Number ",
      ),
      // maxLength: 10,
      keyboardType: TextInputType.number,
    );
  }

  Widget nameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "Name Can't be empty";
        if (value.length < 3) return "Invalid Name";
        return null;
      },
      controller: _nameController,
      decoration: InputDecoration(
        // errorText: validate ? null : errorText,
        suffixIcon: Icon(
          MdiIcons.asterisk,
          color: Colors.red,
          size: 10,
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
        hintText: "Full Name",
      ),
    );
  }
}
