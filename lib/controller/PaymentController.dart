import 'package:get/state_manager.dart';

import '../model/paymentModel.dart';

class PaymentController extends GetxController {
  var payList = <PaymentModel>[].obs;
  int get count => payList.length;
  addToCart(PaymentModel slot) {
    payList.add(slot);
  }

  RxInt balance = 0.obs;
  RxInt total = 0.obs;
}
