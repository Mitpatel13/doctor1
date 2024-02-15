
import 'package:get/get.dart';

import '../../controller/BookedSlotController.dart';
import '../../controller/DailySlotController.dart';
import '../../controller/PaymentController.dart';
import '../../controller/ReviewController.dart';
import '../../controller/SlotController.dart';
import '../../controller/TextController.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TextController());
    Get.put(SlotController());
    Get.put(ReviewController());
    Get.put(PaymentController());
    Get.put(DailySlotController());
    Get.put(BookedSlotController());
  }
}