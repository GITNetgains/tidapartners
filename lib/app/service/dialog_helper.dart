import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../components/show_loader.dart';




class DialogHelper {
  static get context => null;

  //show error dialog
  static void showErrorDialog(String title, String description,
      {bool isSuccess = false}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.toUpperCase(),
                style: Get.textTheme.headlineSmall,
              ),
              SizedBox(height: 10.h),
              Lottie.asset(
                isSuccess
                    ? 'animations/success.json'
                    : 'animations/apiError.json',
                height: 140.h,
                repeat: true,
                reverse: true,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10.h),
              Text(
                description,
                style: Get.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text("Okay"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showLoading() {
    Get.dialog(const ShowLoader());
  }

  //hide loading
  static void hideLoading() {
    print("called");
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
