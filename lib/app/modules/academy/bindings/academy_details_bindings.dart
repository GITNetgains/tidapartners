import 'package:get/get.dart';
import '../controllers/academy_details_controller.dart';

class AcademyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcademyDetailsController>(
      () => AcademyDetailsController(),
    );
  }
}
