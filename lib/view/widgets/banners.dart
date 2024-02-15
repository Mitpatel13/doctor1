import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
      "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
      "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png",
      "https://static.javatpoint.com/tutorial/flutter/images/flutter-logo.png"
    ];

    return SizedBox(
      height: 40.w,
      width: double.infinity,
      child: CarouselSlider(

        options:
          CarouselOptions(
            height: 120.h,
            aspectRatio: 0.95,
            autoPlay: true,
          ),
        // dotColor: AppColors.mainColor,
        // dotSpacing: 15.0,
        // dotBgColor: Colors.transparent,
        // dotSize: 5,
        items: [
          // CachedNetworkImage(
          //   imageUrl:
          //       "https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg",
          //   fit: BoxFit.fill,
          // ),
          // Image(CachedNetworkImage(
          //  imageurl,
          // ),
          // Image(
          //     fit: BoxFit.fill,
          //   image: CachedNetworkImageProvider( 'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg')),
          // Image.network(
          //   'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg',
          //   fit: BoxFit.fill,
          // ),
          Image.asset(
            "assets/banner3.png",
            fit: BoxFit.fill,
          ),
          Image.asset(
            "assets/banner1.jpg",
            fit: BoxFit.fill,
          ),
          Image.asset(
            "assets/banner2.jpg",
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}
