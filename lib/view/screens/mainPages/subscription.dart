import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/TextController.dart';
import '../../../networkhandler.dart';
import '../../Utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  NetworkHandler networkHandler = NetworkHandler();
  TextController textController = Get.find<TextController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            text: "Subscription",
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
                text: "Your Subscription plan will be end on ",
                maxlines: 20,
                fontWeight: FontWeight.w300,
                size: 18,
              ),
              const SizedBox(
                height: 15,
              ),
              textController.subEndDate != ""
                  ? Obx(() => BigText(
                        text: textController.subEndDate
                            .toString()
                            .substring(0, 10),
                        color: AppColors.mainColor,
                      ))
                  : SizedBox.shrink(),
              const SizedBox(
                height: 15,
              ),
              SmallText(
                text:
                    "To enjoy our service without any interuption . please subscribe before its over ",
                maxlines: 20,
                fontWeight: FontWeight.w300,
                size: 18,
              ),
              const SizedBox(
                height: 15,
              ),
              // Center(child: InkWell(onTap: () async {
              //   FocusScope.of(context).unfocus();

              //   showDialog(
              //     context: context,
              //     barrierDismissible: false,
              //     builder: (context) {
              //       return Container(
              //         color: Colors.transparent,
              //         child: const Center(
              //           child: CircularProgressIndicator(
              //             color: Colors.white,
              //           ),
              //         ),
              //       );
              //     },
              //   );
              //     if (textController.drsubCharge.value == 0) {
              //       var response = await networkHandler.get('/subFees');
              //       textController.drsubCharge.value = response[0]['doctorsub'];
              //     }
              //     if (textController.drsubCharge.value != null ||
              //         textController.drsubCharge.value != 0) {
              //       // ignore: use_build_context_synchronously
              //       showDialog(
              //           context: context,
              //           barrierDismissible: false,
              //           builder: (context) {
              //             return Center(
              //               child: Container(
              //                   height: 300,
              //                   width: 300,
              //                   color: Colors.white,
              //                   child: GridTile(
              //                     header: Container(
              //                       height: 50,
              //                       // ignore: sort_child_properties_last
              //                       child: Row(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.center,
              //                         children: [
              //                           const SizedBox(
              //                             width: 40,
              //                           ),
              //                           Expanded(
              //                             child: SmallText(
              //                               text: "Information",
              //                               color: Colors.white,
              //                               size: 18,
              //                               fontWeight: FontWeight.w400,
              //                             ),
              //                           ),
              //                           GestureDetector(
              //                               onTap: () {
              //                                 Get.back();
              //                                 Get.back();
              //                               },
              //                               child: Padding(
              //                                 padding:
              //                                     const EdgeInsets.all(8.0),
              //                                 child: Icon(
              //                                   MdiIcons.closeCircleOutline,
              //                                   color: Colors.white,
              //                                 ),
              //                               ))
              //                           // // onPressed: () {
              //                           // //   Get.back();
              //                           // // },
              //                           // icon: Icon(Icons.close))
              //                         ],
              //                       ),
              //                       color: AppColors.mainColor,
              //                     ),
              //                     // ignore: sort_child_properties_last
              //                     child: Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Column(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.center,
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.center,
              //                         children: [
              //                           // BigText(
              //                           //   text: "Subscription!!",
              //                           //   color: AppColors.mainColor,
              //                           //   size: 25,
              //                           //   weight: FontWeight.w300,
              //                           // ),
              //                           // const SizedBox(
              //                           //   height: 5,
              //                           // ),
              //                           const Center(
              //                             child: Text(
              //                               "Your one year subscription charge is only  ",
              //                               textAlign: TextAlign.center,
              //                               style: TextStyle(
              //                                   decoration: TextDecoration.none,
              //                                   fontSize: 13,
              //                                   color: Color.fromARGB(
              //                                       255, 96, 95, 95),
              //                                   fontStyle: FontStyle.italic,
              //                                   fontWeight: FontWeight.w200),
              //                             ),
              //                           ),
              //                           const SizedBox(
              //                             height: 5,
              //                           ),
              //                           BigText(
              //                             text:
              //                                 "\u{20B9} ${textController.drsubCharge}",
              //                             color: AppColors.mainColor,
              //                             size: 25,
              //                             weight: FontWeight.w500,
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                     // footer: Padding(
              //                     //   padding: const EdgeInsets.all(8.0),
              //                     //   child: ElevatedButton(
              //                     //       style: ElevatedButton.styleFrom(
              //                     //           primary: AppColors.mainColor),
              //                     //       onPressed: () async {
              //                     //         openCheckout();
              //                     //       },
              //                     //       child: const Text(
              //                     //         "Pay Now",
              //                     //         style: TextStyle(
              //                     //             color: Colors.white,
              //                     //             fontSize: 16),
              //                     //       )),
              //                     // ),
              //                   )),
              //             );
              //           });
              //     } else {
              //       Get.back();
              //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //         content: Text("Error to process Now"),
              //         backgroundColor: Colors.red,
              //         elevation: 10,
              //         behavior: SnackBarBehavior.floating,
              //         margin: EdgeInsets.all(5),
              //       ));
              //     }
              //   },
              //   child: Container(
              //     width: Dimention.screenWidth / 2.2,
              //     height: 50,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(7),
              //       color: AppColors.mainColor,
              //     ),
              //     child: const Center(
              //       child: Text(
              //         "Subscribe",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ),
              //   ),
              // )
              // }))
            ],
          ),
        ));
  }
}
