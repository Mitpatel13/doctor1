import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../controller/TextController.dart';
import '../../Utils/colors.dart';
import '../../Utils/dimention.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class ReferAndEarn extends StatelessWidget {
  TextController textController = Get.find<TextController>();
  ReferAndEarn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: "Refer and Earn",
            color: Colors.white,
            weight: FontWeight.w700,
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SmallText(
                text:
                    "You can earn money by refer your friends and colleague by use your reference key",
                maxlines: 20,
                size: 18,
                fontWeight: FontWeight.w300,
              ),
              SizedBox(
                height: 20,
              ),
              BigText(
                text: textController.refCode.toString(),
                color: AppColors.mainColor,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: InkWell(
                onTap: () async {
                  _onShare(context);
                },
                child: Container(
                  width: Dimention.screenWidth / 2.2,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: AppColors.mainColor,
                  ),
                  child: const Center(
                    child: Text(
                      "Refer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ));
  }

  void _onShare(BuildContext context) async {
    // final box = context.findRenderObject() as RenderBox?;

    await Share.share(
        'Hey, i Have found a Wonderful Mobile Application for Doctors Appointment and Other Medical requirements .\n https://vaidhya421.herokuapp.com \n Use *Reference id:"${textController.refCode.toString()}"* to join on it.');
    // await Share.share(
    //     "Hey, i Have found this on #Urban Green what you think https://pilasa/product?id=${widget.id}&name=${widget.name}",
    //     subject: "Urabn Green",
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
