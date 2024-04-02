import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../components/snackBar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/customer_model.dart';
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
  late Color textColor = const Color(0xFF3463B4);

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
            "username": nameController.text,
            "password": passwordController.text,
            "first_name": nameController.text,
            "role": "partner",
            "billing": {
              "first_name": nameController.text,
              "email": emailController.text,
              "phone": phoneController.text
            },
            "shipping": {
              "first_name": nameController.text,
            }
          });
          if (res["data"] != null) {
            if (res["data"]["status"] != null) {
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
          if (res['id'] != null) {
            Map<String, dynamic> data = {
              "username": emailController.text,
              "password": passwordController.text
            };
            Map result = await ApiService().loginUser(data);
            if (result['token'] != null) {
              CustomerModel customerModel =
                  CustomerModel.fromJson(res as Map<String, dynamic>);
              LoginResponseModel loginResponseModel =
                  LoginResponseModel.fromJson(result as Map<String, dynamic>);
              MySharedPref.setEmail(loginResponseModel.userEmail.toString());
              MySharedPref.setUserId(customerModel.id.toString());
              MySharedPref.setName(customerModel.firstName.toString());
              MySharedPref.setToken(loginResponseModel.token.toString());
              MySharedPref.setPhone(customerModel.billing!.phone.toString());
              Get.snackbar(
                'Message',
                '${customerModel.firstName} Registered Successfully',
                backgroundColor: kSuccessColor,
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                borderRadius: 10.0,
                margin: const EdgeInsets.all(10.0),
                isDismissible: true,
                duration: const Duration(seconds: 3),
              );
              isLoading(false);
              update();
              print(res.toString());
              Timer(const Duration(seconds: 2), () {
                Get.offAllNamed(AppPages.HOME);
              });
            } else {
              showSnackbar(
                'Provide correct crentidals',
              );
              isLoading(false);
              update();
              return;
            }
          } else {
            showSnackbar(
              'Provide correct crentidals',
            );
            isLoading(false);
            update();
            return;
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
