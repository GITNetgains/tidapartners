import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/data/local/my_shared_pref.dart';
import 'package:tidapartners/app/routes/app_pages.dart';

import '../../../../utils/colors.dart';
import '../views/profile_edit.dart';

class ProfileBar extends StatelessWidget {
  final String name;
  final String job;
  final String location;
  final VoidCallback onEditPressed;

  ProfileBar({
    Key? key,
    required this.name,
    required this.job,
    required this.location,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(18.0),
        bottomRight: Radius.circular(18.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        child: Stack(
          children: [
            Image.asset(
              'assets/profilebg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.offNamed(AppPages.HOME);
                        },
                        child: Icon(
                          CupertinoIcons.back,
                          color: kWhiteColor,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.to(() => EditProfileScreen(),
                              transition: Transition.rightToLeft);
                        },
                        child: Icon(
                          CupertinoIcons.pencil,
                          color: kWhiteColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 35.0.dg,
                        backgroundImage:
                            NetworkImage(MySharedPref.getAvatar() ?? ""),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MySharedPref.getName().capitalize.toString(),
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            MySharedPref.getEmail(),
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              color: kWhiteColor,
                            ),
                          ),
                          location.toString() != ""
                              ? Text(
                                  'Phone Number: ${location.capitalize.toString()}',
                                  style: TextStyle(
                                      fontSize: 12.0.sp, color: kWhiteColor),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
