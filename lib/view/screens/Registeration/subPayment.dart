import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../controller/TextController.dart';
import '../../../networkhandler.dart';
import '../../Utils/colors.dart';
import '../../Utils/dimention.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../loginPage.dart';
import '../screen.dart';

class SubPayment extends StatefulWidget {
  const SubPayment({super.key});

  @override
  State<SubPayment> createState() => _SubPaymentState();
}

class _SubPaymentState extends State<SubPayment> {
  NetworkHandler networkHandler = NetworkHandler();
  late Razorpay razorpay;
  TextEditingController _referenceController = TextEditingController();
   TextController textController = Get.find<TextController>();
  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    if (textController.drsubCharge.value == 0) {
      fetchsubFree();
    }
  }

  void fetchsubFree() async {
    var response = await networkHandler.get('/subFees');
    // print(response);
    textController.drsubCharge.value = response[0]['doctorsub'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(
            // text: "Subscription",
            text: "Refer",
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
                // text: "Vaidhya Subscription Charge for One year is now only",
                text: " Enter the reference code for Easy Verifcation",
                maxlines: 20,
                fontWeight: FontWeight.w300,
                size: 20,
              ),
              SizedBox(
                height: 30,
              ),
              // Obx(
              //   () => BigText(
              //     text: "\u{20B9}${textController.drsubCharge}",
              //     color: AppColors.mainColor,
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              // SmallText(
              //   text: "Subscribe  to enjoy the service",
              //   maxlines: 20,
              //   fontWeight: FontWeight.w300,
              //   size: 20,
              // ),
              SizedBox(
                height: 30,
              ),
              ReferenceController(),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: InkWell(
                onTap: () async {
                  // if (textController.drsubCharge != 0) {
                  _handlePaymentSuccess();
                  // }
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
                      "Sumbit",
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

  Widget ReferenceController() {
    return TextFormField(
        controller: _referenceController,
        decoration: InputDecoration(
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
            hintText: "Reference Id"));
  }

  // void openCheckout() {
  //   // showDialog(
  //   //   context: context,
  //   //   barrierDismissible: false,
  //   //   builder: (context) {
  //   //     return Container(
  //   //       color: Colors.transparent,
  //   //       child: const Center(
  //   //         child: CircularProgressIndicator(
  //   //           color: Colors.white,
  //   //         ),
  //   //       ),
  //   //     );
  //   //   },
  //   // );

  //   var options = {
  //     "key": "rzp_test_r9BjXS8K8XqlTm",
  //     // "key": "rzp_live_EDhTzfpCsP95JV",
  //     // "amount": total * 100,
  //     "amount": textController.drsubCharge * 100,
  //     "name": "Vaidhya",
  //     "description": "Pay to Vaidhya",
  //     "theme.color": "#10B801",
  //     "prefill": {
  //       "contact": textController.phone.toString(),
  //       "email": textController.email.toString(),
  //     },
  //     "external": {
  //       "wallets": ["paytm"]
  //     },
  //   };

  //   try {
  //     razorpay.open(options);
  //   } catch (e) {}
  // }

  // void _handlePaymentSuccess(PaymentSuccessResponse response2) async {
  void _handlePaymentSuccess() async {
    var razoid;
    // razoid = response2.paymentId.toString();
    Map<String, dynamic> data = {
      "_id": textController.userid.toString(),
      "referedBy": _referenceController.text,
      "paymentId": "",
      "fee": "",
      // "paymentId": response2.paymentId.toString(),
      // "fee": int.parse(textController.drsubCharge.toString())
    };
    var response = await networkHandler.post("/subscription", data);
    // log.i(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(
              child: Container(
                  height: 300,
                  width: 300,
                  color: Colors.white,
                  child: GridTile(
                    header: Container(
                      height: 50,
                      // ignore: sort_child_properties_last
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: SmallText(
                              text: "Information",
                              color: Colors.white,
                              size: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  MdiIcons.closeCircleOutline,
                                  color: Colors.white,
                                ),
                              ))
                          // // onPressed: () {
                          // //   Get.back();
                          // // },
                          // icon: Icon(Icons.close))
                        ],
                      ),
                      color: AppColors.mainColor,
                    ),
                    // ignore: sort_child_properties_last
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BigText(
                          text: "Congratulations!!",
                          color: AppColors.mainColor,
                          size: 25,
                          weight: FontWeight.w500,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Center(
                          child: Text(
                            "You are successfully created\n  account with us.\n Account will be activate after \n Autherized verification  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 11,
                                color: Color.fromARGB(255, 96, 95, 95),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w200),
                          ),
                        )
                      ],
                    ),
                    footer: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.mainColor),
                          onPressed: () => {Get.offAll(()=>LoginPage())},
                          child: const Text(
                            "Okay",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    ),
                  )),
            );
          });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error to subscribe, please try later"),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      ));
    }
    // print(response.paymentId);
    // print(response.orderId);
    // print(response.signature);
    // print(response.);
    // if (response.paymentId != null) {
    //   Map<String, dynamic> data = {
    //     "razoId": razoid,
    //     "church_id": widget.id,
    //     "church_name": widget.chName,
    //     "date": _selectedDay,
    //     "name": _nameController.text,
    //     "type": selType,
    //     "amt": int.parse(amount),
    //     "phone": phoneNumber,
    //     "comment": _commentController.text,
    //   };
    //   var response = await networkHandler.post3("/paymentBooking", data);
    //   setState(() {
    //     _commentController.text = " ";
    //     _nameController.text = " ";
    //     _amtController.text = " ";
    //   });
    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     Navigator.of(context).pop();
    //     _scaffoldKey.currentState.showSnackBar(SnackBar(
    //         backgroundColor: Colors.green,
    //         content: Text("Payment Successful"),
    //         duration: Duration(seconds: 2)));
    //   }
    // } else {
    //   Navigator.of(context).pop();
    //   _scaffoldKey.currentState.showSnackBar(SnackBar(
    //       backgroundColor: Colors.red,
    //       content: Text("Payment failed"),
    //       duration: Duration(seconds: 2)));
    // }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.of(context).pop();
    // print("Payment error");
    //  Toast.show("Payment error", context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Payment error"),
      backgroundColor: Colors.red,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Navigator.of(context).pop();
    // print("External Wallet");
    // Toast.show("External Wallet", context);
    Timer(
        Duration(seconds: 2),
        () =>
            //  Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => page)));
            Navigator.of(context).pop());
  }
}
