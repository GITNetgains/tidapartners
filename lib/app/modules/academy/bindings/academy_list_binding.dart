import 'package:get/get.dart';
import '../controllers/academy_list_controller.dart';

class AcademyListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcademyListController>(
      () => AcademyListController(),
    );
  }
}
