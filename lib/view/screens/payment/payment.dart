import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vidhya_doctors/view/screens/payment/paymentBottomsheet.dart';
import '../../../controller/PaymentController.dart';
import '../../../model/paymentModel.dart';
import '../../../model/paymentModelList.dart';
import '../../../networkhandler.dart';
import '../../Utils/Utiils.dart';
import '../../widgets/big_text.dart';
import '../../widgets/paymentList.dart';
import '../../widgets/small_text.dart';
import '../../widgets/widgets.dart';
import 'accountAdd.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  PaymentModelList paylist = PaymentModelList();
  final PaymentController payController = Get.find<PaymentController>();
  late List<PaymentModel> slotlistdata;
  // ignore: prefer_typing_uninitialized_variables
  var response;
  var balance = "";
  var grandTotal = "";
  NetworkHandler networkHandler = NetworkHandler();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPayment();
  }

  void fetchPayment() async {
    response = await networkHandler.get("/totalpayments");
    paylist = PaymentModelList.fromJson({'data': response["requests"]});
    if (paylist.data != null) {
      payController.payList.value = paylist.data!;
    }
    payController.balance.value = response["balance"];
    payController.total.value = response["grandtotal"];

  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // fetchPayment();
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Payment",
            color: Colors.white,
            size: 17,
            weight: FontWeight.w300,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              BigText(
                text: "Account  Summary",
                color: AppColors.mainColor,
                size: 20,
                decoration: TextDecoration.underline,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: "Balance",
                    size: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  Obx(
                    () => SmallText(
                      text: payController.balance.toString(),
                      size: 20,
                      color: AppColors.secondColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    text: "Grand Payed",
                    size: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  Obx(() => SmallText(
                        text: payController.total.toString(),
                        size: 15,
                        color: AppColors.secondColor,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 50,
                    height: 35,
                    decoration: BoxDecoration(
                      // color: const Color(0XFFE7ECEF),
                      border: Border.all(
                        color: AppColors.mainColor,
                        // width: 5,
                      ),
                      color: AppColors.mainColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 9.0),
                        child: IconButton(
                            color: AppColors.mainColor,
                            onPressed: () {
                              showModalBottomSheet(
                                  // isDismissible: false,
                                  // isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) => Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Obx(() => PaymentBottomSheet(
                                              amount: payController.balance
                                                  .toString(),
                                            )),
                                      ));
                            },
                            icon: Icon(
                              MdiIcons.cashMultiple,
                              color: Colors.white,
                              size: 40,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 50,
                    height: 35,
                    decoration: BoxDecoration(
                      // color: const Color(0XFFE7ECEF),
                      border: Border.all(
                        color: AppColors.mainColor,
                        // width: 5,
                      ),
                      color: AppColors.mainColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: FittedBox(
                      child: IconButton(
                          color: AppColors.mainColor,
                          onPressed: () {
                            Get.to(AccountAdd());
                          },
                          icon: Icon(
                            MdiIcons.bank,
                            color: Colors.white,
                            size: 30,
                          )),
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 1.5,
                color: AppColors.mainColor,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              GetX<PaymentController>(builder: (controller) {
                return Center(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.count,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PaymentList(
                            paylist: controller.payList[i],
                          ),
                        );
                        //  AvailableTime(
                        //   slot: i,
                        //   selDate: "12/02/22",
                        // );
                      }),
                );
              }),
              const SizedBox(
                height: 70,
              )
            ]),
          ),
        ));
  }
}
