import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/splashbg.png',
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                     SizedBox(height: 50.h),
                    Image.asset(
                      'assets/tidatext.png',
                      width: 200.w,
                      height: 200.h,
                      filterQuality: FilterQuality.high,
                    ),
                     Text(
                      "TRANSFORMING INDIA's",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: kblack,
                      ),
                    ),
                     Text(
                      "DEVELOPING ATHLETES",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: kblack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
