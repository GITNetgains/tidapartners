import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/models/academy_model.dart';

class AcademyDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  Data1 academyDataModel = Data1();
  RxString address = "".obs;
  String orderkey = "wc_order";
  String orderid = "0";
  String subscriptionid = "";
  TextEditingController personnamectrl = TextEditingController();

  @override
  void onInit() async {
    isLoading.value = true;
    update();
    academyDataModel = Get.arguments["data"];
    isLoading.value = false;
    update();
    super.onInit();
  }
}
