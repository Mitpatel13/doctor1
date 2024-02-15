import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Utils/colors.dart';

class uploadImageDisplay extends StatelessWidget {
  File? imageFiles;
  uploadImageDisplay({super.key, required this.imageFiles});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5, right: 3),
          child: Container(
              // margin: EdgeInsets.symmetric(
              //   horizontal: 20,
              //   vertical: 20,
              // ),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.mainColor, width: 2)),
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              child: imageFiles == null
                  ? Image.asset("assets/doctor.jpeg")
                  : Image.file(
                      File(imageFiles!.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    )),
        ),
      ]),
    );
  }
}
