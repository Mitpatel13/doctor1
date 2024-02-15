import 'package:flutter/material.dart';

import '../Utils/colors.dart';

class ProfileAvatar extends StatelessWidget {
  String id;
  double imagesize;
  // final String imageUrl;
  ProfileAvatar({
    required this.id,
    this.imagesize = 30,
    super.key,
    // required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: imagesize,
      backgroundColor: AppColors.secondColor,
      child: CircleAvatar(
        radius: imagesize - 1.5,
        backgroundColor: AppColors.secondColor,
        child: ClipOval(
          //     child: ImageFade(
          //   // whenever the image changes, it will be loaded, and then faded in:
          //   image: NetworkImage(
          //       "http://192.168.68.82:3000/uploads/DoctorsImage/$id.jpg"),
          //   // slow fade for newly loaded images:
          //   duration: const Duration(milliseconds: 900),
          //   // if the image is loaded synchronously (ex. from memory), fade in faster:
          //   syncDuration: const Duration(milliseconds: 150),

          //   // supports most properties of Image:
          //   alignment: Alignment.center,
          //   fit: BoxFit.fill,

          //   // shown behind everything:
          //   placeholder: Container(
          //     color: const Color(0xFFCFCDCA),
          //     alignment: Alignment.center,
          //     child: const Icon(Icons.photo, color: Colors.white30, size: 128.0),
          //   ),

          //   // shows progress while loading an image:
          //   loadingBuilder: (context, progress, chunkEvent) =>
          //       Center(child: CircularProgressIndicator(value: progress)),

          //   // displayed when an error occurs:
          //   errorBuilder: (context, error) => Container(
          //     color: const Color(0xFF6F6D6A),
          //     alignment: Alignment.center,
          //     child:
          //         const Icon(Icons.warning, color: Colors.black26, size: 128.0),
          //   ),
          // )

          child: Image.network(
            'https://vaidhya421.herokuapp.com/uploads/DoctorsImage/$id.jpg',
            // width: 100,
            // height: 100,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
