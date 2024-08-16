import 'package:get/get.dart';
import 'package:tidapartners/app/modules/upcoming_bookings/controllers/upcoming_bookings_controller.dart';

class UpcomingBookingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpcomingBookingsController>(
      () => UpcomingBookingsController(),
    );
  }
}