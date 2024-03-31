
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../components/elevatedbutton.dart';
import '../../../components/show_loader.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(color: kWhiteColor),
          title: Text(
            "Change Password",
            style: TextStyle(color: kWhiteColor),
          ),
        ),
        body:c.isLoading ? ShowLoader() :  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      "assets/padlock.png",
                      width: 18,
                      height: 18,
                    ),
                  ),
                  Text("New Password"),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.2)),
                child: TextField(
                  controller: c.newpassword,
                  obscureText: c.isPasswordView.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20, top: 10),
                      hintText: "**********",
                      suffixIcon: IconButton(
                          onPressed: () {
                            c.changepasswordview();
                          },
                          icon: Icon(c.isPasswordView.value
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined)),
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image.asset(
                      "assets/padlock.png",
                      width: 18,
                      height: 18,
                    ),
                  ),
                  Text("Confirm New Password"),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.withOpacity(0.2)),
                child: TextField(
                  controller: c.confirmpassword,
                  obscureText: c.isConfirmPasswordView.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20, top: 10),
                      hintText: "**********",
                      suffixIcon: IconButton(
                          onPressed: () {
                            c.changeConfirmpasswordview();
                          },
                          icon: Icon(c.isConfirmPasswordView.value
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined)),
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: MyButton(
                      text: "Save",
                      ontap: () async {
                        // c.showLoader();
                        c.changepass();
                        // // await c.logout();
                        // Get.toNamed(AppRoutes.changepassword);
                        // c.hideLoader();
                      }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
