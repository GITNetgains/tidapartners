import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/modules/profile/controllers/profile_controller.dart';

import '../../../../utils/colors.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';

class EditProfileScreen extends StatelessWidget {
  // final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.red,
              title: const Text('Edit Profile',
                  style: TextStyle(color: kWhiteColor)),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppPages.PROFILE);
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  color: kWhiteColor,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: controller.phoneController,
                    decoration: InputDecoration(labelText: 'Phone'),
                  ),
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(
                    height: Get.height / 9,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        controller.editProfileDetails();
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: kPrimaryColor,
                      ),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height / 9,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppPages.CHANGE_PASSWORD);
                      },
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        backgroundColor: kPrimaryColor,
                      ),
                      child: Text(
                        'Edit Password',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
