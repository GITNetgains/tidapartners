import 'package:flutter/material.dart';
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
                    const SizedBox(height: 50),
                    Image.asset(
                      'assets/tidatext.png',
                      width: 200,
                      height: 200,
                      filterQuality: FilterQuality.high,
                    ),
                    const Text(
                      "Transforming INDIA's",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kblack,
                      ),
                    ),
                    const Text(
                      "DEVELOPING ATHLETES",
                      style: TextStyle(
                        fontSize: 20,
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
