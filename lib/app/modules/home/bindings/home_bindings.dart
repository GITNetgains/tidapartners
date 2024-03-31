import 'package:get/get.dart';
import 'package:tidapartners/app/modules/home/controllers/home_controller.dart';




class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}