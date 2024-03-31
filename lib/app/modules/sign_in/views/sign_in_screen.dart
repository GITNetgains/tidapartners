import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/Strings.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/elevatedbutton.dart';
import '../../../components/show_loader.dart';
import '../../../components/text_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
        init: SignInController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: controller.isLoading.value
                ? ShowLoader()
                : Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.kappicon,
                            width: 150,
                            height: 150,
                            filterQuality: FilterQuality.high,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Text(
                              Strings.transforming.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          MyTextField(
                            textController: controller.emailController,
                            firstImage: AppImages.kuser,
                            firstText: 'Email Id',
                            hintText: 'enter your Email Id',
                            isPassword: false,
                          ),
                          MyTextField(
                            textController: controller.passwordController,
                            firstImage: AppImages.kpassword,
                            firstText: 'Password',
                            hintText: 'enter your Password',
                            isPassword: true,
                            isObscure: controller.isPasswordView,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.changepasswordview();
                                },
                                icon: Icon(controller.isPasswordView
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined)),
                          ),
                          MyButton(
                            ontap: () {
                              controller.loginCustomer(
                                  controller.emailController.text,
                                  controller.passwordController.text);
                            },
                            text: 'Sign In',
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.forgotpassworddialog();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account? '),
                              GestureDetector(
                                onTap: () => {Get.toNamed(AppPages.SIGNUP)},
                                child: const Text(
                                  'Register Now',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Login as '),
                              GestureDetector(
                                onTap: () => {
                                  controller.loginCustomer(
                                      "guest@gmail.com", "12345@Dk"),
                                },
                                child: const Text(
                                  'Guest',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
