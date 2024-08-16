import 'package:get/get.dart';

import '../controllers/past_bookings_controller.dart';

class PastBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PastBookingsController>(
      () => PastBookingsController(),
    );
  }
}