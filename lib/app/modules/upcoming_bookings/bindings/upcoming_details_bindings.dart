
import 'package:get/get.dart';

import '../controllers/upcoming_details_controller.dart';

class UpcomingDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpcomingDetailsController>(
      () => UpcomingDetailsController(),
    );
  }
}