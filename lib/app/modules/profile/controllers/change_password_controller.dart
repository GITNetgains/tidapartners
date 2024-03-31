

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/common_utils.dart';
import '../../../components/snackBar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/remote/api_service.dart';


class ChangePasswordController extends GetxController {
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  RxBool isPasswordView = true.obs;
  RxBool isConfirmPasswordView = true.obs;
  String userid = MySharedPref.getUserId().toString();
  bool isLoading = false;
  void showSnackbar(msg) {
    Get.snackbar("Please provide $msg", "$msg is required.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  void changepasswordview() {
    isPasswordView.value = !isPasswordView.value;
    update();
  }

  void changeConfirmpasswordview() {
    isConfirmPasswordView.value = !isConfirmPasswordView.value;
    update();
  }

  Future<void> changepass() async {
    isLoading = true;
    update();
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      if (newpassword.text.trim().isEmpty) {
        showSnackbar("New Password");
        isLoading = true;
        update();
        return;
      } else if (isPasswordCompliant(newpassword.text.trim().toString()) ==
          false) {
        Get.snackbar("Please provide valid Password",
            "Password should have minimum of 1 special Character, 1 Uppercase letter, 1 lowercase letter, 1 digit and minimum length of 8 characters.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        isLoading = false;
        update();
        return;
      } else if (confirmpassword.text.trim().isEmpty) {
        showSnackbar("Confirm Password");
        isLoading = false;
        update();
        return;
      } else {
        if (confirmpassword.text.trim() != newpassword.text.trim()) {
          Get.snackbar(
              "Not Matching", "Confirm Password not matching newpassword",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          isLoading = false;
          update();
          return;
        } else {
          print(MySharedPref.getUserId());
          dynamic res = await ApiService()
              .changePassword(newpassword.text.trim(), userid);
              print((res.body).toString());
          if (res.statusCode == 200) {
            showSuccessfulSnackbar(jsonDecode(res.body));
          } else {
            Get.snackbar("Error", jsonDecode(res.body),
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM);
          }
          isLoading = false;
          update();
          // await ApiService().changepass(data).then((res) async {
          //   ChangePasswordModel? resp = ChangePasswordModelFromJson(res);
          //   print("-------------");
          //   if (resp!.status == false) {
          //     Get.snackbar("Server Response", "${resp.message}",
          //         backgroundColor: Colors.red,
          //         colorText: Colors.white,
          //         snackPosition: SnackPosition.BOTTOM);
          //   } else {
          //     Get.snackbar("Server Response", "${resp.message}",
          //         backgroundColor: Colors.green,
          //         colorText: Colors.white,
          //         snackPosition: SnackPosition.BOTTOM);
          //   }
          // }).onError((error, stackTrace) {
          //   Get.snackbar("Server Response", error.toString(),
          //       backgroundColor: Colors.red,
          //       colorText: Colors.white,
          //       snackPosition: SnackPosition.BOTTOM);
          // });
          // Get.close(1);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Please check all the credentials",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
      isLoading = false;
      update();
    }
  }
}
