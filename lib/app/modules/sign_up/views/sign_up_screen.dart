import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../components/elevatedbutton.dart';
import '../../../components/show_loader.dart';
import '../../../components/text_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
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
                          const SizedBox(height: 20),
                          MyTextField(
                            textController: controller.nameController,
                            firstImage: AppImages.kuser,
                            firstText: 'Name',
                            hintText: 'Enter Your Name',
                            isPassword: false,
                          ),
                          MyTextField(
                            textController: controller.phoneController,
                            firstImage: AppImages.kuser,
                            firstText: 'Phone Number',
                            hintText: 'Enter Your Phone Number',
                            keyboardType: TextInputType.number,
                            textInputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            isPassword: false,
                          ),
                          MyTextField(
                            textController: controller.emailController,
                            firstImage: AppImages.kpassword,
                            firstText: 'Email Id',
                            hintText: 'enter your Email Id',
                            keyboardType: TextInputType.emailAddress,
                            isPassword: false,
                          ),
                          MyTextField(
                            textController: controller.passwordController,
                            firstImage: AppImages.kpassword,
                            firstText: 'Password',
                            hintText: 'enter your Password',
                            keyboardType: TextInputType.visiblePassword,
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
                          MyTextField(
                              textController:
                                  controller.confirmPasswordController,
                              firstImage: AppImages.kpassword,
                              firstText: 'Confirm password',
                              hintText: 'enter your Password',
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                              isObscure: controller.isConfirmPasswordView,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.changeConfirmpasswordview();
                                  },
                                  icon: Icon(controller.isConfirmPasswordView
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye_outlined))),
                          MyButton(
                            ontap: () {
                            // Get.toNamed(AppPages.HOME);
                              controller.signUp();
                            },
                            text: 'Register',
                          ),
                          // CustomTextButton(
                          //     imagePath: 'assets/search.png',
                          //     buttonText: 'Sign Up with Google',
                          //     onPressed: () => {}),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              GestureDetector(
                                onTap: () => {
                                  Get.toNamed(AppPages.SIGNIN),
                                },
                                child: Text('Login here',
                                    style: TextStyle(
                                      color: controller.textColor,
                                      fontWeight: FontWeight.bold,
                                    )),
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
