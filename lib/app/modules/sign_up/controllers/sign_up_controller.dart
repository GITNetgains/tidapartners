import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidapartners/utils/colors.dart';

import '../../../components/snackBar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/remote/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../../../utils/common_utils.dart';
import '../../sign_in/controllers/sign_in_controller.dart';

class SignUpController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  RxBool isLoading = false.obs;

  SignInController signInController = SignInController();
  bool isPasswordView = true;
  bool isConfirmPasswordView = true;
  late Color textColor = kPrimaryColor;

  void changepasswordview() {
    isPasswordView = !isPasswordView;
    update();
  }

  void changeConfirmpasswordview() {
    isConfirmPasswordView = !isConfirmPasswordView;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  Future<void> signUp() async {
    isLoading(true);
    update();
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      if (nameController.text.trim().isEmpty) {
        showSnackbar("name");
        isLoading(false);
        update();
        return;
      } else if (emailController.text.trim().isEmpty) {
        showSnackbar("email");
        isLoading(false);
        update();
        return;
      } else if (phoneController.text.trim().isEmpty) {
        showSnackbar("valid phone number");
        isLoading(false);
        update();
        return;
      } else if (emailController.text.trim().isNotEmpty &&
          !validateEmail(emailController.text.trim())) {
        showSnackbar("valid email");
        isLoading(false);
        update();
        return;
      } else if (passwordController.text.trim().isEmpty) {
        showSnackbar("password");
        isLoading(false);
        update();
        return;
      } else if (confirmPasswordController.text.trim().isEmpty) {
        showSnackbar("confirm password");
        isLoading(false);
        update();
        return;
      } else if (confirmPasswordController.text.trim().isNotEmpty &&
          confirmPasswordController.text.trim() !=
              passwordController.text.trim()) {
        showSnackbar("matching password");
        isLoading(false);
        update();
        return;
      } else if (isPasswordCompliant(
              passwordController.text.trim().toString()) ==
          false) {
        Get.snackbar("Please provide valid Password",
            "Password should have minimum of 1 special Character, 1 Uppercase letter, 1 lowercase letter, 1 digit and minimum length of 8 characters.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        isLoading(false);
        update();
        return;
      } else {
        if (passwordController.text == confirmPasswordController.text) {
          Map res = await ApiService().createUserAccount({
            "email": emailController.text,
            "username": emailController.text,
            "password": passwordController.text,
            "first_name": nameController.text,
          });
          if (res["code"] == 200) {
            if (res["user_id"] != null) {
              MySharedPref.setUserId(res["user_id"].toString());
              MySharedPref.setName(nameController.text);
              MySharedPref.setEmail(emailController.text);
              Get.snackbar(
                'Success',
                '${res["message"]}',
                backgroundColor: Colors.green,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                borderRadius: 10.0,
                margin: const EdgeInsets.all(10.0),
                isDismissible: true,
                duration: const Duration(seconds: 3),
              );
              await Get.offAllNamed(AppPages.HOME);
              isLoading(false);
              update();
              return;
            } else {
              Get.snackbar(
                'Error',
                '${res["message"]}',
                backgroundColor: Colors.red,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                borderRadius: 10.0,
                margin: const EdgeInsets.all(10.0),
                isDismissible: true,
                duration: const Duration(seconds: 3),
              );
              isLoading(false);
              update();
              return;
            }
          }
        } else {
          showSnackbar(
            'Provide correct crentidals',
          );
          isLoading(false);
          update();
          return;
        }
      }
    } catch (e) {
      rethrow;
    }
    isLoading(false);
    update();
  }

  @override
  void dispose() {
    confirmPasswordController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
