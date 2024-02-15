import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vidhya_doctors/view/screens/Registeration/registration3.dart';
import '../../../controller/TextController.dart';
import '../../../networkhandler.dart';
import '../../Utils/colors.dart';
import '../../Utils/dimention.dart';
import '../../widgets/big_text.dart';

class Registration2 extends StatefulWidget {
  const Registration2({Key? key}) : super(key: key);

  @override
  State<Registration2> createState() => _Registration2State();
}

class _Registration2State extends State<Registration2> {
  NetworkHandler networkHandler = NetworkHandler();

  bool specialityselect = true;
  // PickedFile? _imageFile;
  bool genderselect = true;
  List<String> genderList = [
    'Male',
    'Female',
    'Others',
  ];
  bool categorySelect = true;
  List<String> categoryList = [
    'Ayurvedic',
    'General Medicine',
    'Homeopathy',
  ];
  String? categoryDropDownValue;
   TextController textController = Get.find<TextController>();
  String? genderdropdownvalue;
  List<dynamic> specialityList = ['loading....'];
  List<dynamic> generalspecialityList = ['loading....'];
  List<dynamic> ayurvedicspecialityList = ['loading....'];
  String? specialitydropdownvalue;
  List<dynamic> AreaList = ['loading....'];
  String? areadropdownvalue;
  String? specialty;
  DateTime? pickedDate;
  DateTime today = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _globalkey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool validate = false;
  bool circular = false;
  File? imageFile;
  @override
  void initState() {
    super.initState();
    fetchSpeciality();
  }

  void fetchSpeciality() async {
    var response = await networkHandler.get('/listofDepartment');
    // print(response);
    setState(() {
      generalspecialityList = response[0]['generaldepartments'];
      ayurvedicspecialityList = response[0]['ayurvedicDepartment'];
      textController.drsubCharge.value = response[0]['doctorsub'];
    });
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
                      Padding(
                        padding: EdgeInsets.only(top: 20.0, bottom: 1.h),
                        child: Center(
                            child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColors.secondColor,
                              child: CircleAvatar(
                                // ignore: sort_child_properties_last
                                child: ClipOval(
                                  child: imageFile != null
                                      ? Image.file(
                                          imageFile!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          'assets/doctor.jpeg',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                radius: 50 - 1.5,
                                backgroundColor: Colors.grey[200],
                                //  backgroundImage: AssetImage("assets/doctor.jpeg"),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                    foregroundColor: AppColors.mainColor,
                                    child: IconButton(
                                      onPressed: () => {pickImage()},
                                      icon: Icon(MdiIcons.camera),
                                      color: Colors.white,
                                    )))
                          ],
                        )),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: BigText(
                            text: textController.name.toString(),
                            color: AppColors.secondColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Center(child: genderDropDown()),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 70,
                        child: Center(
                          child: dateTextField(),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Center(child: qualificationTextField()),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(child: categoryDropdown()),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(child: specialityDropdown()),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(child: cityTextField()),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(child: addressTextField()),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(child: experienceTextField()),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (imageFile == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("please Select Image"),
                                backgroundColor: Colors.red,
                                elevation: 10,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(5),
                              ));
                            } else {
                              if (_globalkey.currentState!.validate()) {
                                if (genderdropdownvalue == null ||
                                    specialitydropdownvalue == null ||
                                    categoryDropDownValue == null) {
                                  if (genderdropdownvalue == null) {
                                    genderselect = false;
                                  } else if (categoryDropDownValue == null) {
                                    categorySelect = false;
                                  } else {
                                    specialityselect = false;
                                  }
                                  setState(() {});
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
                                  ImageProperties properties =
                                      await FlutterNativeImage
                                          .getImageProperties(imageFile!.path);
                                  File compressedFile =
                                      await FlutterNativeImage.compressImage(
                                          imageFile!.path,
                                          quality: 50,
                                          targetWidth: 600,
                                          targetHeight: ((properties.height! *
                                                      600) /
                                                  (properties.width!.toInt()))
                                              .round());
                                  var id = textController.userid.toString();
                                  networkHandler.patchImage(
                                      "/upload_profile_image/$id",
                                      compressedFile.path);
                                  _addressController.text = _addressController
                                      .text
                                    ..replaceAll("\n", ",");
                                  Map<String, dynamic> data = {
                                    "_id": textController.userid.toString(),
                                    "gender": genderdropdownvalue,
                                    "dob": pickedDate!.toIso8601String(),
                                    "qualifications":
                                        _qualificationController.text,
                                    "category": categoryDropDownValue,
                                    "specality": specialitydropdownvalue,
                                    "city": _cityController.text,
                                    "address": _addressController.text,
                                    "experience": _experienceController.text
                                  };

                                  var response = await networkHandler.post(
                                      "/register2", data);
                                  Map<String, dynamic> output =
                                      json.decode(response.body);
                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201) {
                                    Get.back();
                                    Get.off(Registration3());

                                    // ignore: use_build_context_synchronously
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const Registration3()),
                                    // );
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

  Future pickImage() async {
    try {
      final _imageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      // print(_imageFile);
      if (_imageFile != null) {
        setState(() {
          imageFile = File(_imageFile.path);
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
    } on PlatformException {
      // print('Failed to pick image: $e');
    }
  }

  Widget categoryDropdown() {
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
          value: categoryDropDownValue,
          // icon: const Icon(Icons.keyboard_arrow_down),
          hint: categorySelect
              ? const Text(
                  'Category',
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 81, 81),
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                )
              : const Text(
                  'Please Select a Category',
                  style: TextStyle(color: Colors.red),
                ),
          items: categoryList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              categoryDropDownValue = newValue!;
              if (categoryDropDownValue == "Ayurvedic") {
                specialityList = ayurvedicspecialityList;
              } else if (categoryDropDownValue == "General Medicine") {
                specialityList = generalspecialityList;
              } else if (categoryDropDownValue == "Homeopathy") {
                specialityList = ["Homeopathy"];
              }
            });
          },
        ));
  }

  Widget genderDropDown() {
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
          value: genderdropdownvalue,
          // icon: const Icon(Icons.keyboard_arrow_down),
          hint: genderselect
              ? const Text(
                  'Gender',
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 81, 81),
                      fontSize: 16,
                      fontWeight: FontWeight.w300),
                )
              : const Text(
                  'Please Select a Gender',
                  style: TextStyle(color: Colors.red),
                ),
          items: genderList.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              genderdropdownvalue = newValue!;
            });
          },
        ));
  }

  Widget specialityDropdown() {
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
          value: specialitydropdownvalue,
          // icon: const Icon(Icons.keyboard_arrow_down),
          hint: specialityselect
              ? const Text(
                  'Specality',
                  style: TextStyle(
                      color: Color.fromARGB(255, 83, 81, 81),
                      fontSize: 15,
                      fontWeight: FontWeight.w300),
                )
              : const Text(
                  'Please Select a Specality',
                  style: TextStyle(color: Colors.red),
                ),
          items: specialityList.map((dynamic items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (dynamic? newValue) {
            setState(() {
              specialitydropdownvalue = newValue!;
            });
          },
        ));
  }

  Widget qualificationTextField() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) return "Qualifications can't be  empty";
          return null;
        },
        controller: _qualificationController,
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
            hintText: "Qualification "));
  }

  Widget cityTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "City can't be  empty";
        return null;
      },
      controller: _cityController,
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
        hintText: "city",
      ),
    );
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
        hintText: "Full Address",
      ),
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 5,
    );
  }

  Widget experienceTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "Experience can't be  empty";
        if (int.parse(value) > 70) return "Invalid Value";
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

  Widget dateTextField() {
    return SizedBox(
      height: 75.h,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) return "Please Select DOB";
          return null;
        },
        controller: _dateController,
        decoration: InputDecoration(
          // suffixIcon: const Icon(
          //   MdiIcons.asterisk,
          //   color: Colors.red,
          //   size: 10,
          // ),
          suffixIcon: Icon(
            Icons.calendar_today,
            color: AppColors.mainColor,
          ), //icon of text field
          hintText: "Date of Birth", //label text of field
          // helperText: "Age should be Grater than 18",
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide(
                color: AppColors.mainColor,
              )),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.mainColor)),
        ),
        readOnly: true,
        onTap: () async {
          pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime(today.year - 18, today.month, today.day),
            firstDate: DateTime(1950),
            lastDate: DateTime(today.year - 18, today.month, today.day),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.mainColor, // <-- SEE HERE
                  ),
                ),
                child: child!,
              );
            },
          );
          if (pickedDate != null) {
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate!);
            setState(() {
              _dateController.text = formattedDate;
            });
          } else {}
        },
      ),
    );
  }
}
