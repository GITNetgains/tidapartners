import 'dart:async';

import 'package:get/get.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/app_service.dart';

class SplashController extends GetxController {
  RxBool validation = false.obs;

  @override
  void onInit() async {
    super.onInit();
    validation.value = await AppService.isValidString(MySharedPref.getToken());
    print('${validation.value} ---- ${MySharedPref.getToken()}');
    Timer(Duration(seconds: 2), () {
      if (validation.value) {
        Get.offAllNamed(AppPages.HOME);
      } else {
        Get.offAllNamed(AppPages.SIGNUP);
      }
    });
    update();
  }
}
