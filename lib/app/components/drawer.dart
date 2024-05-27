import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/common_utils.dart';
import '../data/local/my_shared_pref.dart';
import '../routes/app_pages.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              MySharedPref.getEmail() == "guest@email.com"
                  ? print("---------")
                  : Get.toNamed(AppPages.HOME);
              MySharedPref.getEmail() == "guest@email.com"
                  ? print("---------")
                  : Get.toNamed(AppPages.HOME);
            },
            child: ListTile(
              minVerticalPadding: 30,
              title: Text(
                MySharedPref.getName().capitalize ?? "",
                style: TextStyle(color: kWhiteColor, fontSize: 25.sp),
              ),
              subtitle: MySharedPref.getEmail() == "guest@email.com"
                  ? Container(
                      height: 10,
                      width: 10,
                    )
                  : Text(
                      MySharedPref.getEmail(),
                      style: TextStyle(color: kWhiteColor, fontSize: 16.sp),
                    ),
              // currentAccountPicture: Container(
              //   width: 120,
              //   height: 120,
              //   padding: const EdgeInsets.all(2),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(60)),
              //   //backgroundColor: Colors.white70,
              //   //minRadius: 60.0,
              //   child: Container(
              //     width: 120,
              //     height: 120,
              //     decoration: BoxDecoration(
              //         //  color: Colors.white70,
              //         borderRadius: BorderRadius.circular(60)),
              //     child: ClipOval(
              //         child: Image.asset(
              //       "assets/user.png",
              //       width: 90,
              //       fit: BoxFit.cover,
              //       errorBuilder: (BuildContext context, Object exception,
              //           dynamic stackTrace) {
              //         return Container(
              //             color: Colors.red.withOpacity(0.1),
              //             width: 90,
              //             height: 90,
              //             child: Center(
              //               child: Icon(
              //                 Icons.add_a_photo_outlined,
              //                 color: Colors.red.withOpacity(0.3),
              //                 size: 28,
              //               ),
              //             ));
              //       },
              //       height: 90,
              //     )),
              //   ),
              // ),
              // decoration: const BoxDecoration(
              tileColor: kPrimaryColor,
              // ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 14.sp),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 14.sp),
            ),
            onTap: () => {Get.toNamed(AppPages.PROFILE)},
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(
              'Academies',
              style: TextStyle(fontSize: 14.sp),
            ),
            onTap: () => {Get.toNamed(AppPages.ACADEMY_LISTING)},
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(
              'Venues',
              style: TextStyle(fontSize: 14.sp),
            ),
            onTap: () => {Get.toNamed(AppPages.VENUE_LISTING)},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 14.sp),
            ),
            onTap: () {
              Get.offAllNamed(AppPages.SIGNIN);
              MySharedPref.clearSession();
            },
          ),
          ExpansionTile(
            title: Text(
              "Support",
              style: TextStyle(color: kSecondaryColor, fontSize: 14.sp),
            ),
            initiallyExpanded: true,
            children: [
              ListTile(
                minLeadingWidth: 1,
                dense: true,
                leading: const Icon(Icons.support_agent_sharp),
                title: Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 14.sp),
                ),
                onTap: () {
                  launchUrlString("https://tidasports.com/contact-us/",
                      mode: LaunchMode.externalApplication);
                },
              ),
              const Divider(),
              ListTile(
                minLeadingWidth: 1,
                dense: true,
                leading: const Icon(Icons.phone_forwarded),
                title:  Text('Call Us',  style: TextStyle(fontSize: 14.sp),),
                onTap: () {
                  makePhoneCall("+918195944444");
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/app_icon.png",
              fit: BoxFit.contain,
              width: 120.w,
              height: 100.h,
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(
                top: 20.0.h, bottom: 20.0.h, left: 5.0.w, right: 5.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      launch(('https://www.facebook.com/tidasports/'));
                    },
                    child: Image.asset(
                      "assets/icons/facebook.png",
                      height: 30,
                    )),
                GestureDetector(
                    onTap: () {
                      launchurl(
                          Uri.parse('https://www.instagram.com/tidasports/'));
                    },
                    child: Image.asset(
                      "assets/icons/instagram.png",
                      height: 30,
                    )),
                GestureDetector(
                    onTap: () {
                      launchurl(Uri.parse(
                          'https://www.linkedin.com/company/tidasports/'));
                    },
                    child: Image.asset(
                      "assets/icons/linkedIn.png",
                      height: 30,
                    )),
                GestureDetector(
                    onTap: () {
                      launchurl(
                          Uri.parse('https://www.youtube.com/@tidasports'));
                    },
                    child: Image.asset(
                      "assets/icons/youtube.png",
                      height: 30,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
