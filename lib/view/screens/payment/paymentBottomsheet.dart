import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../controller/PaymentController.dart';
import '../../../model/paymentModel.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class PaymentBottomSheet extends StatefulWidget {
  String amount;
  PaymentBottomSheet({required this.amount, super.key});

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  NetworkHandler networkHandler = NetworkHandler();
  final _globalkey = GlobalKey<FormState>();
  final PaymentController payController = Get.find<PaymentController>();
  final TextEditingController _amtController = TextEditingController();
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimention.screenHeight / 3,
      // key: _globalKey,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _globalkey,
            child: ListView(children: <Widget>[
              Center(
                  child: BigText(
                text: "Payment Request",
                color: AppColors.secondColor,
                decoration: TextDecoration.underline,
                weight: FontWeight.w500,
              )),
              const SizedBox(
                height: 10,
              ),
              SmallText(
                text: "Withraw Amount",
                size: 15,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 88, 85, 85),
              ),
              SizedBox(
                height: 10,
              ),
              amountTextField(),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    // Get.offAll(navScreen());

                    if (_globalkey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Container(
                            color: Colors.transparent,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                      Map<String, dynamic> data = {
                        "amount": _amtController.text,
                      };

                      var response =
                          await networkHandler.post2("/requestPayment", data);
                      Map<String, dynamic> output = json.decode(response.body);
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        payController.balance.value =
                            payController.balance.toInt() -
                                int.parse(_amtController.text);
                        payController.total.value =
                            payController.total.toInt() +
                                int.parse(_amtController.text);
                        payController.addToCart(PaymentModel(
                            date: DateTime.now(),
                            amount: int.parse(_amtController.text),
                            status: "Pending"));
                        Get.back();
                        Get.back();
                      } else {
                        Get.back();
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(output["msg"]),
                          backgroundColor: Colors.red,
                          elevation: 10,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(5),
                        ));
                      }
                    }
                  },
                  child: Container(
                    width: Dimention.screenWidth / 1.5,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: circular
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Create Request",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                ),
              )
            ]),
          )),
    );
  }

  Widget amountTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) return "Amount  Can't be empty";
        if (!RegExp(r'^-?[0-9]+$').hasMatch(value)) return "Invalid Amound";
        if (int.parse(value) > int.parse(widget.amount))
          return "Insufficient balance";
        if (int.parse(value) < 1000) return "Minimum withdraw amount is 1000";
        return null;
      },
      controller: _amtController,
      decoration: InputDecoration(
        // errorText: validate ? null : errorText,
        suffixIcon: Icon(
          MdiIcons.asterisk,
          color: Colors.red,
          size: 10,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: AppColors.mainColor,
            )),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mainColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mainColor)),
        // helperStyle: TextStyle(color:, fontSize: 5),
        hintStyle: const TextStyle(
          fontSize: 16,
        ),
        hintText: "Withdraw Amount",
      ),
      // maxLength: 10,
      keyboardType: TextInputType.number,
    );
  }
}
