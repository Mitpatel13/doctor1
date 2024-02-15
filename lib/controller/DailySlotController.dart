import 'package:get/state_manager.dart';

import '../model/slotModel.dart';

class DailySlotController extends GetxController {
  var dailybookedList = <SlotModel>[].obs;
  int get count => dailybookedList.length;
  List get totalPrice =>
      dailybookedList.map(((element) => element.time)).toList();
  var timelist = [].obs;
  addToCart(SlotModel slot) {
    dailybookedList.add(slot);
  }
}
