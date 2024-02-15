import 'package:get/get.dart';

class Dimention {
  static double screenHeight = Get.context!.height; //756
  static double screenWidth = Get.context!.width; //360
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 3.84;

  static bool screentype =
      screenHeight < 800 && screenWidth < 400 ? true : false;
  //topcha

  static double tagsize = screenWidth / 17;

  //width
  static double width30 = screenWidth / 35;
  static double width20 = screenWidth / 25;

  //height
  static double foodImageHeight = screenHeight / 2.41;
}
