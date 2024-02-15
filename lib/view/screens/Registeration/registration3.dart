import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:vidhya_doctors/view/screens/Registeration/subPayment.dart';

import '../../../controller/TextController.dart';
import '../../../networkhandler.dart';
import '../../Utils/colors.dart';
import '../../Utils/dimention.dart';
import '../../widgets/big_text.dart';
import '../../widgets/uploadImageDisplay.dart';

class Registration3 extends StatefulWidget {
  const Registration3({Key? key}) : super(key: key);

  @override
  State<Registration3> createState() => _Registration3State();
}

class _Registration3State extends State<Registration3> {
   TextController textController = Get.find<TextController>();
  bool educationselect = true;
  bool registrationselect = true;
  NetworkHandler networkHandler = NetworkHandler();
  List<String> idlist = [
    'Aadhaar Card',
    'Driving License ',
    'Passport',
    'Voter Identity card ',
    'PAN Card',
    'Others'
  ];
  String? iddropdownvalue;
  bool idselect = true;
  List<String> educationList = [
    'MBBS',
    'MD',
    'BAMS',
    'BHMS',
    'Others',
  ];
  String? educationdropdownvalue;
  List<String> registrationList = [
    'Indian medical council',
    'Kerala  Medical Council',
    'Karnataka Medical Council',
    'Others',
  ];
  String? registrationdropdownvalue;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _regnumberController = TextEditingController();
  // TextEditingController _regCouncilController = TextEditingController();
  TextEditingController _regyearController = TextEditingController();
  bool validate = false;
  bool circular = false;
  File? _idimageFile;
  bool _idupload = false;
  bool _iduploading = false;
  bool _educationUpload = false;
  bool _educationuploading = false;
  bool _registrationUpload = false;
  bool _registrationuploading = false;
  // File? imageFile;
  File? _educationimageFile;
  File? _registrationimageFile;
  var id;
  @override
  void initState() {
    super.initState();
    id = textController.userid.toString();
    // print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "My Profile",
          color: Colors.white,
          size: 17,
          weight: FontWeight.w300,
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                // height: Dimention.screenHeight - 20,
                width: Dimention.screenWidth,
                child: Form(
                  key: _globalkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Row(
                        children: [
                          Flexible(child: idDropDown()),
                          SizedBox(
                            width: 2,
                          ),
                          Material(
                              type: MaterialType
                                  .transparency, //Makes it usable on any background color, thanks @IanSmith
                              child: Ink(
                                height: 55,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.mainColor, width: 1.0),
                                ),
                                child: IconButton(
                                    onPressed: () => {pickIdImage()},
                                    icon: Icon(
                                      Icons.attach_file_outlined,
                                      size: 26,
                                      color: AppColors.secondColor,
                                    )),
                              ))
                        ],
                      )),
                      _idimageFile != null
                          ? Row(
                              children: [
                                Flexible(
                                    child: uploadImageDisplay(
                                        imageFiles: _idimageFile)),
                                SizedBox(
                                  width: 3,
                                ),
                                _idupload
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.mainColor,
                                        ),
                                        onPressed: () async {},
                                        child: Icon(Icons.check_outlined))
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.secondColor,
                                        ),
                                        onPressed: () async {
                                          if (!_iduploading) {
                                            if (iddropdownvalue != null) {
                                              setState(() {
                                                _iduploading = true;
                                              });
                                              ImageProperties properties =
                                                  await FlutterNativeImage
                                                      .getImageProperties(
                                                          _idimageFile!.path);
                                              File compressedFile =
                                                  await FlutterNativeImage
                                                      .compressImage(
                                                _idimageFile!.path,
                                                quality: 50,
                                                targetWidth: 550,
                                                targetHeight: 550,
                                                // targetHeight: ((properties
                                                //                 .height! *
                                                //             600) /
                                                //         (properties
                                                //             .width!
                                                //             .toInt()))
                                                //     .round()
                                              );
                                              // print(id);
                                              var response = await networkHandler
                                                  .patchImage(
                                                      "/upload_DoctorsIdProof/$id",
                                                      compressedFile.path);
                                              if (response.statusCode == 200 ||
                                                  response.statusCode == 201) {
                                                setState(() {
                                                  _idupload = true;
                                                  _iduploading = false;
                                                });
                                              } else {
                                                setState(() {
                                                  _iduploading = false;
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                idselect = false;
                                              });
                                            }
                                          }
                                        },
                                        child: Icon(Icons.upload),
                                      )
                              ],
                            )
                          : SizedBox(
                              height: 10,
                            ),
                      Center(
                          child: Row(
                        children: [
                          Flexible(child: educationDropDown()),
                          SizedBox(
                            width: 2,
                          ),
                          Material(
                              type: MaterialType
                                  .transparency, //Makes it usable on any background color, thanks @IanSmith
                              child: Ink(
                                height: 55,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.mainColor, width: 1.0),
                                ),
                                child: IconButton(
                                    onPressed: () => {pickeducationImage()},
                                    icon: Icon(
                                      Icons.attach_file_outlined,
                                      size: 26,
                                      color: AppColors.secondColor,
                                    )),
                              ))
                        ],
                      )),
                      _educationimageFile != null
                          ? Row(
                              children: [
                                Flexible(
                                    child: uploadImageDisplay(
                                        imageFiles: _educationimageFile)),
                                SizedBox(
                                  width: 3,
                                ),
                                _educationUpload
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.mainColor,
                                        ),
                                        onPressed: () async {},
                                        child: Icon(Icons.check_outlined))
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.secondColor,
                                        ),
                                        onPressed: () async {
                                          if (!_educationuploading) {
                                            if (educationdropdownvalue !=
                                                null) {
                                              setState(() {
                                                _educationuploading = true;
                                              });
                                              ImageProperties properties =
                                                  await FlutterNativeImage
                                                      .getImageProperties(
                                                          _educationimageFile!
                                                              .path);
                                              File compressedFile =
                                                  await FlutterNativeImage
                                                      .compressImage(
                                                          _educationimageFile!
                                                              .path,
                                                          quality: 50,
                                                          targetWidth: 600,
                                                          targetHeight: ((properties
                                                                          .height! *
                                                                      600) /
                                                                  (properties
                                                                      .width!
                                                                      .toInt()))
                                                              .round());
                                              var response = await networkHandler
                                                  .patchImage(
                                                      "/upload_EducationCertificate/$id",
                                                      compressedFile.path);
                                              if (response.statusCode == 200 ||
                                                  response.statusCode == 201) {
                                                setState(() {
                                                  _educationUpload = true;
                                                  _educationuploading = false;
                                                });
                                              } else {
                                                setState(() {
                                                  _educationuploading = false;
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                educationselect = false;
                                              });
                                            }
                                          }
                                        },
                                        child: Icon(Icons.upload),
                                      )
                              ],
                            )
                          : SizedBox(
                              height: 10,
                            ),
                      Center(
                          child: Row(
                        children: [
                          Flexible(child: RegistrationDropdown()),
                          SizedBox(
                            width: 2,
                          ),
                          Material(
                              type: MaterialType
                                  .transparency, //Makes it usable on any background color, thanks @IanSmith
                              child: Ink(
                                height: 55,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.mainColor, width: 1.0),
                                ),
                                child: IconButton(
                                    onPressed: () => {pickregistrationImage()},
                                    icon: Icon(
                                      Icons.attach_file_outlined,
                                      size: 26,
                                      color: AppColors.secondColor,
                                    )),
                              ))
                        ],
                      )),
                      _registrationimageFile != null
                          ? Row(
                              children: [
                                Flexible(
                                    child: uploadImageDisplay(
                                        imageFiles: _registrationimageFile)),
                                SizedBox(
                                  width: 3,
                                ),
                                _registrationUpload
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.mainColor,
                                        ),
                                        onPressed: () async {},
                                        child: Icon(Icons.check_outlined))
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.secondColor,
                                        ),
                                        onPressed: () async {
                                          if (!_registrationuploading) {
                                            if (registrationdropdownvalue !=
                                                null) {
                                              setState(() {
                                                _registrationuploading = true;
                                              });
                                              ImageProperties properties =
                                                  await FlutterNativeImage
                                                      .getImageProperties(
                                                          _registrationimageFile!
                                                              .path);
                                              File compressedFile =
                                                  await FlutterNativeImage.compressImage(
                                                      _registrationimageFile!
                                                          .path,
                                                      quality: 50,
                                                      targetWidth: 600,
                                                      targetHeight: ((properties
                                                                      .height! *
                                                                  600) /
                                                              (properties.width!
                                                                  .toInt()))
                                                          .round());
                                              var response = await networkHandler
                                                  .patchImage(
                                                      "/upload_RegisterationCertificate/$id",
                                                      compressedFile.path);
                                              if (response.statusCode == 200 ||
                                                  response.statusCode == 201) {
                                                setState(() {
                                                  _registrationUpload = true;
                                                  _registrationuploading =
                                                      false;
                                                });
                                              } else {
                                                setState(() {
                                                  _registrationuploading =
                                                      false;
                                                });
                                              }
                                            } else {
                                              setState(() {
                                                registrationselect = false;
                                              });
                                            }
                                          }
                                        },
                                        child: Icon(Icons.upload),
                                      )
                              ],
                            )
                          : SizedBox(
                              height: 10,
                            ),
                      Center(child: regNumberTextField()),
                      SizedBox(
                        height: 15,
                      ),
                      Center(child: regYearTextField()),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (!_idupload) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("please Upload your Id Proof"),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              ));
                            } else if (!_educationUpload) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content:
                                    Text("please Upload your Education Proof"),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              ));
                            } else if (!_registrationUpload) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "please Upload your Medical Registration Information"),
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
                                      return Container(
                                        color: Colors.transparent,
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    });
                                Map<String, dynamic> data = {
                                  "_id": id,
                                  "regNumber": _regnumberController.text,
                                  "regCouncil": registrationdropdownvalue,
                                  "regYear": _regyearController.text,
                                  "idproff": iddropdownvalue,
                                  "education": educationdropdownvalue
                                };

                                var response = await networkHandler.post(
                                    "/register3", data);
                                Map<String, dynamic> output =
                                    json.decode(response.body);
                                if (response.statusCode == 200 ||
                                    response.statusCode == 201) {
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => SubPayment()),
                                  // );
                                  Get.back();
                                  Get.off(SubPayment());
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
                            // setState(() {
                            //   circular = true;
                            // });
                            // Get.offAll(LoginPage());
                          },
                          child: Container(
                            width: Dimention.screenWidth / 2.8,
                            height: 40,
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
                                      "NEXT",
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
          ],
        ),
      ),
    );
  }

  Future pickIdImage() async {
    try {
      final _imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      // print(_imageFile);
      if (_imageFile != null) {
        setState(() {
          _idimageFile = File(_imageFile.path);
          _idupload = false;
        });
      }
    } on PlatformException {
      // print('Failed to pick image: $e');
    }
  }

  Future pickeducationImage() async {
    try {
      final _imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (_imageFile != null) {
        setState(() {
          _educationUpload = false;
          _educationimageFile = File(_imageFile.path);
        });
      }
    } on PlatformException {}
  }

  Future pickregistrationImage() async {
    try {
      final _imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (_imageFile != null) {
        setState(() {
          _registrationUpload = false;
          _registrationimageFile = File(_imageFile.path);
        });
      }
    } on PlatformException {}
  }

  Widget idDropDown() {
    return Container(
        width: 300.w,
        decoration:
            BoxDecoration(border: Border.all(color: AppColors.mainColor)),
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: DropdownButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromARGB(255, 131, 125, 125),
          ),
          style: TextStyle(color: AppColors.textColor, fontSize: 16),
          isExpanded: true,
          value: iddropdownvalue,

          // icon: const Icon(Icons.keyboard_arrow_down),
          hint: idselect
              ? const Text(
                  'Identification Document',
                  style: TextStyle(
                      color: Color.fromARGB(255, 131, 125, 125), fontSize: 15),
                )
              : const Text(
                  'Please Select a Document',
                  style: TextStyle(color: Colors.red),
                ),
          items: idlist.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              iddropdownvalue = newValue!;
            });
          },
        ));
  }

  Widget educationDropDown() {
    return Container(
        width: 300.w,
        decoration:
            BoxDecoration(border: Border.all(color: AppColors.mainColor)),
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: DropdownButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromARGB(255, 131, 125, 125),
          ),
          style: TextStyle(color: AppColors.textColor, fontSize: 16),
          isExpanded: true,
          value: educationdropdownvalue,
          // icon: const Icon(Icons.keyboard_arrow_down),
          hint: educationselect
              ? const Text(
                  'Education',
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 81, 81),
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                )
              : const Text(
                  'Please Select your Education',
                  style: TextStyle(color: Colors.red),
                ),
          items: educationList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              educationdropdownvalue = newValue!;
            });
          },
        ));
  }

  Widget RegistrationDropdown() {
    return Container(
        width: 300.w,
        decoration:
            BoxDecoration(border: Border.all(color: AppColors.mainColor)),
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: DropdownButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color.fromARGB(255, 131, 125, 125),
          ),
          style: TextStyle(color: AppColors.textColor, fontSize: 16),
          isExpanded: true,
          value: registrationdropdownvalue,
          // icon: const Icon(Icons.keyboard_arrow_down),
          hint: registrationselect
              ? const Text(
                  'Registration Council',
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 81, 81),
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                )
              : const Text(
                  'Please Select Registration Council',
                  style: TextStyle(color: Colors.red),
                ),
          items: registrationList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              registrationdropdownvalue = newValue!;
            });
          },
        ));
  }

  Widget regNumberTextField() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) return "Registration Number  can't be  empty";
          return null;
        },
        controller: _regnumberController,
        decoration: InputDecoration(
            hintMaxLines: 2,
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
            helperStyle: TextStyle(color: Colors.grey[400], fontSize: 5),
            hintStyle: TextStyle(
              fontSize: 15,
            ),
            // labelText: "Enter User Id or Email Address",
            hintText: "Registration Number "));
  }

  Widget regYearTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "Registration Year  be  empty";
        return null;
      },
      controller: _regyearController,
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
        hintText: "Registration Year  ",
      ),
    );
  }
}
