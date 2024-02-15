import 'package:get/state_manager.dart';

import '../model/bookedSlotModel.dart';

class BookedSlotController extends GetxController {
  var bookedList = <BookedSlotModel>[].obs;
  int get count => bookedList.length;
  double get totalfees => bookedList.fold(0, (sum, item) => sum + item.fees);
  double get totalAmount => totalfees;
  var timelist = [].obs;
}
