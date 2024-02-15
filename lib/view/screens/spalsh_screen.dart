import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import '../Utils/colors.dart';
import '../widgets/small_text.dart';
import 'loginPage.dart';
import 'nav_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  GetStorage box = GetStorage();
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    box.read("token") == null
        ? Navigator.pushReplacement(
            this.context, MaterialPageRoute(builder: (context) => LoginPage()))
        : Get.offAll(()=>navScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png'),
                  Text("Advanced health care at your fingertips!"),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(
                    color: AppColors.mainColor,
                    // value: 100,
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(2),
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 3,
                  // ),
                  SmallText(
                      text: "Powered by techraven.live",
                      color: AppColors.smallText)
                ],
              ),
            )

            // Container(
            //     height: 100,
            //     width: Dimention.screenWidth,
            //     decoration: new BoxDecoration(
            //         image: new DecorationImage(
            //       image: const AssetImage('assets/heart.gif'),
            //       fit: BoxFit.fill,
            //     )))
            // child: Image.asset('assets/heart.gif',)),
          ],
        ),
      ),
    );
  }
}
