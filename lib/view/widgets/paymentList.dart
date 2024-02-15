import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:vidhya_doctors/view/widgets/small_text.dart';
import '../../model/paymentModel.dart';
import '../../networkhandler.dart';
import '../Utils/colors.dart';
import 'widgets.dart';

class PaymentList extends StatelessWidget {
  PaymentModel paylist;
  PaymentList({
    super.key,
    required this.paylist,
  });
  NetworkHandler networkHandler = NetworkHandler();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: const Color(0XFFE7ECEF),
        border: Border.all(
          color: Colors.grey,
          // width: 5,
        ),
        borderRadius: BorderRadius.circular(5),
        // border: BoxBorder(),
        // boxShadow: const [
        //   BoxShadow(
        //       blurRadius: 2.0,
        //       offset: Offset(1, 1),
        //       color: Color.fromARGB(255, 114, 105, 105)),
        // ],
      ),
      // ignore: sort_child_properties_last
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 2,
          ),
          // Divider(thickness: 1, color: Colors.grey),
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallText(
                  text: DateFormat('dd-MM-yyyy').format(paylist.date),
                  size: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
                SmallText(
                  text: paylist.amount.toString(),
                  size: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainColor,
                )
              ],
            ),
          ),
          // Divider(thickness: 1, color: Colors.grey),
          Container(
            width: double.maxFinite,
            height: 40,
            decoration: BoxDecoration(
              // color: const Color(0XFFE7ECEF),
              border: Border.all(
                color: AppColors.thirdColour,
                // width: 5,
              ),
              color: AppColors.thirdColour,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4.6),
                  bottomRight: Radius.circular(4.6)),
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 8, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: paylist.payDate == null
                        ? ""
                        : DateFormat('dd-MM-yyyy').format(paylist.payDate!),
                    // paylist.payeddate!.day.toString(),
                    color: Colors.white,
                  ),
                  SmallText(
                    text: paylist.status,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      // width: 120,
      // // height: 20.h,
    );
  }
}
