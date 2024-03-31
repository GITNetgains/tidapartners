import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../utils/colors.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../routes/app_pages.dart';

class EditProfileScreen extends StatelessWidget {
  // final ProfileController profileController = Get.find();
  final TextEditingController nameController = TextEditingController(text: MySharedPref.getName());
  final TextEditingController emailController = TextEditingController(text: MySharedPref.getEmail());
  final TextEditingController phoneController = TextEditingController(text: MySharedPref.getPhone());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title:
            const Text('Edit Profile', style: TextStyle(color: kWhiteColor)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
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
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: Get.height/9,),
            Center(
              child: TextButton(
                onPressed: () {
                  // profileController.updateProfile(
                  //   nameController.text,
                  //   emailController.text,
                  //   phoneController.text,
                  // );
                  Get.back();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: kPrimaryColor,
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white,fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: Get.height/9,),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed(AppPages.CHANGE_PASSWORD);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: kPrimaryColor,
                ),
                child: Text(
                  'Edit Password',
                  style: TextStyle(color: Colors.white,fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
