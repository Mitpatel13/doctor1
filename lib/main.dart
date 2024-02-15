import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vidhya_doctors/view/screens/spalsh_screen.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/BookedSlotController.dart';
import 'controller/DailySlotController.dart';
import 'controller/PaymentController.dart';
import 'controller/ReviewController.dart';
import 'controller/SlotController.dart';
import 'controller/TextController.dart';

Future<void> main() async {
  await GetStorage.init();
  initializeControllers();
  runApp(const MyApp());
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}
void initializeControllers() {
  Get.put(TextController());
  Get.put(SlotController());
  Get.put(ReviewController());
  Get.put(PaymentController());
  Get.put(DailySlotController());
  Get.put(BookedSlotController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Vaidhya Doctors',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green,
            textTheme:
                GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)),
        home: SpalshScreen(),
      );
    });
  }
}
