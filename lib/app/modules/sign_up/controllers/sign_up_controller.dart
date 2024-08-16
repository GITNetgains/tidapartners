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
import '../../sign_in/models/sign_in_model.dart';

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
            "password": passwordController.text,
            "name": nameController.text,
            "phone": phoneController.text,
            "role":"partner"
          });
          if (res["status"] == true) {
        print(res);
        LoginResponseModel loginResponseModel =
            LoginResponseModel.fromJson(res["data"] as Map<String, dynamic>);
        MySharedPref.setEmail(loginResponseModel.userEmail.toString());
        MySharedPref.setName(loginResponseModel.userDisplayName.toString());
        MySharedPref.setToken(loginResponseModel.token.toString());
        MySharedPref.setUserId(loginResponseModel.id.toString());
        MySharedPref.setAvatar(loginResponseModel.image.toString());
        MySharedPref.setPhone(loginResponseModel.phone_number.toString());
        print(MySharedPref.getUserId());
        await Get.offAllNamed(AppPages.HOME);
        isLoading(false);
        update();
      } else if (res["status"] == false) {
        if (res["role"] != null) {
          Get.snackbar(
            'Error',
            res["message"],
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
        } else {
          Get.snackbar(
            'Error',
            "Please enter Correct Username and Password",
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
        }
      } else {
        Get.snackbar(
          'Error',
          "Please enter Correct Username and Password",
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
      }
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
