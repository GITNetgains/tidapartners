import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/components/drawer.dart';
import 'package:tidapartners/app/modules/home/controllers/home_controller.dart';

import '../../../../utils/colors.dart';
import '../../../data/local/my_shared_pref.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
             iconTheme: const IconThemeData(color: kWhiteColor),
              toolbarHeight: Get.height / 12,
              centerTitle: false,
              backgroundColor: kPrimaryColor,
              title: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "Hey, ",
                    style: const TextStyle(
                      color: kWhiteColor,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: "${MySharedPref.getName()}",
                    style: const TextStyle(
                        color: kWhiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ]),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    // controller.handlePressButton(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "change",
                          style: TextStyle(color: kblack, fontSize: 12),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: kPrimaryColor,
                              size: 20,
                            ),
                            Text(
                              "",
                              // controller.currentAddress.toString(),
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
          ),
          drawer: SideDrawer(),
        );
      }
    );
  }
}