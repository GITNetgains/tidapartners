import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';

void showSnackbar(msg) {
  Get.snackbar("Please provide $msg", "$msg is required.",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);
}

void showSuccessfulSnackbar(msg) {
  Get.snackbar("SuccessFull", msg,
      backgroundColor: kSuccessColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM);
}
