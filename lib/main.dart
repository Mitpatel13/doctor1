import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:vidhya_doctors/view/biding/ctrl_biding.dart';
import 'package:vidhya_doctors/view/screens/spalsh_screen.dart';
import 'package:get_storage/get_storage.dart';



Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

void _portraitModeOnly() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialBinding: ControllerBinding(),

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
