import 'package:get/get.dart';
import '../controllers/venue_list_controller.dart';


class VenueListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueListController>(
      () => VenueListController(),
    );
  }
}
