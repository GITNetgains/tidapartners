import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/modules/profile/controllers/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class EditProfileScreen extends StatelessWidget {
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
            body: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(16.0.dg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: 200.h,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                      // title: const Text('Choose Options'),
                                      // message: const Text('Your options are '),
                                      actions: <Widget>[
                                    CupertinoActionSheetAction(
                                      child: const Text(
                                        "Select photo",
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context, "Select photo");
                                        print("--------");
                                        controller.pickImage(ImageSource.gallery);
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: const Text(
                                        "Take photo",
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context, "Take photo");
                                        print("--------");
                                        controller.pickImage(ImageSource.camera);
                                      },
                                    )
                                  ],
                                      cancelButton: CupertinoActionSheetAction(
                                        isDefaultAction: true,
                                        onPressed: () {
                                          Navigator.pop(context, "Cancel");
                                        },
                                        child: const Text(
                                          "Cancel",
                                        ),
                                      )),
                            );
                          },
                          child: Container(
                              width: 120.w,
                              height: 120.h,
                              padding: EdgeInsets.all(5.dg),
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(60.r)),
                              //backgroundColor: Colors.white70,
                              //minRadius: 60.0,
                              child: Container(
                                width: 120.w,
                                height: 120.h,
                                //padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    //  color: Colors.white70,
                                    borderRadius: BorderRadius.circular(60.r)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60.r),
                                    child: controller.croppedFile != null
                                        ? Image.file(
                                            File(controller.croppedFile!.path),
                                            fit: BoxFit.cover,
                                          )
                                        : controller.isProperString(
                                                controller.userImage)!
                                            ? Image.network(
                                                controller.userImage.toString())
                                            : Container(
                                                color:
                                                    Colors.red.withOpacity(0.1),
                                                width: 100.w,
                                                height: 100.h,
                                                child: Center(
                                                  child: Icon(
                                                    Icons
                                                        .image_not_supported_outlined,
                                                    color: Colors.red
                                                        .withOpacity(0.3),
                                                    size: 48.sp,
                                                  ),
                                                ))),
                              )),
                        ),
                      ),
                    ),
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
            ),
          );
        });
  }
}
