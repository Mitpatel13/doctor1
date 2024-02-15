import 'package:get/state_manager.dart';

import '../model/slotModel.dart';

class SlotController extends GetxController {
  RxList<SlotModel> bookedList = <SlotModel>[].obs;
  int get count => bookedList.length;

  void addToCart(SlotModel slot) {
    bookedList.add(slot);
  }

  void removeitem(SlotModel slot) {
    bookedList.remove(slot);
  }
}
