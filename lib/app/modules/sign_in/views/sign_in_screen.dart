import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                            width: 150.w,
                            height: 150.h,
                            filterQuality: FilterQuality.high,
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(
                                horizontal: 16.0.w, vertical: 8.0.h),
                            child: Text(
                              Strings.transforming.toUpperCase(),
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                           SizedBox(height: 20.h),
                          MyTextField(
                            textController: controller.emailController,
                            firstImage: AppImages.kuser,
                            firstText: 'Email',
                            hintText: 'Enter your Email',
                            keyboardType: TextInputType.emailAddress,
                            isPassword: false,
                          ),
                          MyTextField(
                            textController: controller.passwordController,
                            firstImage: AppImages.kpassword,
                            firstText: 'Password',
                            hintText: 'Enter your Password',
                            isPassword: true,
                            isObscure: controller.isPasswordView,
                            keyboardType: TextInputType.visiblePassword,
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
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 14.sp,
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
                            height: 20.h,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text('Login as '),
                          //     GestureDetector(
                          //       onTap: () => {
                          //         controller.loginCustomer(
                          //             "guest@gmail.com", "12345@Dk"),
                          //       },
                          //       child: const Text(
                          //         'Guest',
                          //         style: TextStyle(
                          //           color: kPrimaryColor,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
