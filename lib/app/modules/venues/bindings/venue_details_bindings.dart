import 'package:get/get.dart';

import '../controllers/venue_details_controller.dart';


class VenueDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueDetailsController>(
      () => VenueDetailsController(),
    );
  }
}
