import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/TextController.dart';
import '../../../networkhandler.dart';
import '../../Utils/colors.dart';
import '../../Utils/dimention.dart';
import '../../widgets/ProfileAvatar.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class ProfileEditScreen extends StatefulWidget {
  final String name;
  String id;
  String department;
  String qualification;
  String address;
  String experience;
  ProfileEditScreen({
    Key? key,
    required this.id,
    required this.experience,
    required this.address,
    required this.name,
    required this.qualification,
    required this.department,
  }) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
   TextController textController = Get.find<TextController>();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  File? imageFile;
  bool imageupload = false;
  @override
  void initState() {
    super.initState();
    _experienceController.text = widget.experience;
    _addressController.text = widget.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Update Profile",
          color: Colors.white,
          size: 17,
          weight: FontWeight.w300,
        ),
        centerTitle: true,
      ),
      body: Container(
        // padding: EdgeInsets.all(3),
        // color: Colors.red,
        // width: w17.,
        // height: 33.h,
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Form(
            key: _globalkey,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      imageFile == null
                          ? ProfileAvatar(
                              id: widget.id,
                              imagesize: 70,
                            )
                          : Column(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: AppColors.secondColor,
                                  child: CircleAvatar(
                                    radius: 68.5,
                                    backgroundColor: AppColors.secondColor,
                                    child: ClipOval(
                                      child: Image.file(
                                        imageFile!,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Positioned(
                          right: 0,
                          bottom: 10,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.secondColor,
                              ),
                              const CircleAvatar(
                                radius: 18.5,
                                backgroundColor: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 0),
                                child: IconButton(
                                  onPressed: () => {pickImage()},
                                  icon: Icon(MdiIcons.camera),
                                  color: AppColors.secondColor,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  imageupload
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppColors.mainColor),
                                onPressed: () async {
                                  ImageProperties properties =
                                      await FlutterNativeImage
                                          .getImageProperties(imageFile!.path);
                                  File compressedFile =
                                      await FlutterNativeImage.compressImage(
                                    imageFile!.path,
                                    quality: 50,
                                    targetWidth: 550,
                                    targetHeight: 550,
                                    // targetHeight: ((properties.height! * 600) /
                                    //         (properties.width!.toInt()))
                                    //     .round()
                                  );
                                  var response =
                                      await networkHandler.patchImage(
                                          "/upload_profile_image/${widget.id}",
                                          compressedFile.path);
                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201) {
                                    setState(() {
                                      imageupload = false;
                                    });
                                  } else {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Error to Upload image"),
                                        backgroundColor: Colors.red,
                                        elevation: 10,
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(5),
                                      ));
                                    });
                                  }
                                },
                                child: const Text(
                                  "Update",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                )),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 10,
                  ),
                  BigText(
                    text: widget.name,
                    size: 18,
                    weight: FontWeight.w600,
                    color: AppColors.secondColor,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SmallText(
                    text: widget.department,
                    size: 12,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SmallText(
                    maxlines: 3,
                    text: widget.qualification,
                    size: 13,
                    color: AppColors.smallText,
                  ),
                  Divider(
                    thickness: 2,
                    color: AppColors.mainColor,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(child: addressTextField()),
                  SizedBox(
                    height: 10,
                  ),
                  // Center(child: locationTextField()),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Center(child: experienceTextField()),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: InkWell(
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
                            "_id": widget.id.toString(),
                            "address": _addressController.text,
                            "experience": _experienceController.text
                          };
                          var response =
                              await networkHandler.post("/updateProfile", data);
                          Map<String, dynamic> output =
                              json.decode(response.body);
                          if (response.statusCode == 200 ||
                              response.statusCode == 201) {
                            textController.address.value =
                                _addressController.text;
                            // textController.googleLocation.value =
                            //     _googlelocationController.text;
                            textController.experience.value =
                                _experienceController.text;
                            Get.back();
                            Get.back();
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

                        // setState(() {
                        //   circular = true;
                        // });
                        // Get.offAll(navScreen());
                      },
                      child: Container(
                        width: Dimention.screenWidth / 2.8,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: Text(
                            "Update",
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
      ),
    );
  }

  Future pickImage() async {
    try {
      final _imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      // print(_imageFile);
      if (_imageFile != null) {
        setState(() {
          imageFile = File(_imageFile.path);
          imageupload = true;
        });
      }
      // if (_imageFile != null) {
      //   Uint8List imagebytes =
      //       await _imageFile.readAsBytes(); //convert to bytes
      //   print(imagebytes);
      //   base64string =
      //       base64.encode(imagebytes); //convert bytes to base64 string
      //   print(base64string);
      // }
    } on PlatformException {}
  }

  Widget addressTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "Address can't be  empty";
        return null;
      },
      controller: _addressController,
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
          fontSize: 15,
        ),
        hintText: "Address",
      ),
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 5,
    );
  }

  // Widget locationTextField() {
  //   return TextFormField(
  //       validator: (value) {
  //         if (value!.isEmpty) return "Location can't be  empty";
  //         return null;
  //       },
  //       controller: _googlelocationController,
  //       decoration: InputDecoration(
  //           suffixIcon: Icon(
  //             MdiIcons.asterisk,
  //             color: Colors.red,
  //             size: 10,
  //           ),
  //           // errorText: validate ? null : errorText,
  //           // suffixIcon:  Icon( Icons.star ,color: Colors.red,size: 10,),

  //           contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(3),
  //               borderSide: BorderSide(
  //                 color: AppColors.mainColor,
  //               )),
  //           border: OutlineInputBorder(
  //               borderSide: BorderSide(color: AppColors.mainColor)),
  //           focusedBorder: OutlineInputBorder(
  //               borderSide: BorderSide(color: AppColors.mainColor)),
  //           helperStyle: TextStyle(color: Colors.grey[400], fontSize: 5),
  //           hintStyle: TextStyle(
  //             fontSize: 15,
  //           ),
  //           // labelText: "Enter User Id or Email Address",
  //           hintText: "Clinic Google Map  location"));
  // }

  Widget experienceTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "Experience can't be  empty";
        return null;
      },
      controller: _experienceController,
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
          fontSize: 15,
        ),
        hintText: "Experience in Years ",
      ),
      // maxLength: 10,
      keyboardType: TextInputType.number,
    );
  }
}
