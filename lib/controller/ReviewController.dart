import 'package:get/state_manager.dart';

import '../model/reviewModel.dart';

class ReviewController extends GetxController {
  var reviewList = <ReviewModel>[].obs;
  int get count => reviewList.length;
}
