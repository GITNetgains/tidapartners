import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/customer_model.dart';
import '../../../data/remote/api_service.dart';
import '../models/academy_model.dart';
import '../models/venue_model.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  var name = MySharedPref.getName().obs;
  var job = MySharedPref.getEmail().obs;
  var location = MySharedPref.getcity().obs;
  AcademyModel academyDataModel = AcademyModel();
  VenueModel venueModel = VenueModel();

  final TextEditingController nameController =
      TextEditingController(text: MySharedPref.getName());
  final TextEditingController emailController =
      TextEditingController(text: MySharedPref.getEmail());
  final TextEditingController phoneController =
      TextEditingController(text: MySharedPref.getPhone());

  void updateProfile(String newName, String newJob, String newLocation) {
    name.value = newName;
    job.value = newJob;
    location.value = newLocation;
  }

  Future<void> editProfileDetails() async {
    try {
      isLoading = true;
      update();
      Map<String, dynamic> data = {
        "email": emailController.text,
        "first_name": nameController.text,
        "billing": {
          "first_name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
        },
        "shipping": {
          "first_name": nameController.text,
          "phone": phoneController.text,
        }
      };
      print(data);
      print(MySharedPref.getUserId());
      dynamic res = await ApiService()
          .updateUserDetails(data, MySharedPref.getUserId().toString());
      if (res.statusCode == 200) {
        Map<String, dynamic> updateResponse = jsonDecode(res.body);
        print(updateResponse);
        CustomerModel customerModel =
            await CustomerModel.fromJson(updateResponse);
        if (customerModel.email!.isNotEmpty &&
            customerModel.firstName!.isNotEmpty &&
            customerModel.billing!.phone!.isNotEmpty) {
          print(customerModel);
          MySharedPref.setEmail(customerModel.email.toString());
          MySharedPref.setName(customerModel.firstName.toString());
          MySharedPref.setPhone(customerModel.billing!.phone.toString());
          isLoading = false;
          update();
          Get.snackbar("Successfull", "Profile updated successfully",
              backgroundColor: kSuccessColor,
              colorText: kWhiteColor,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          isLoading = false;
          update();
          Get.snackbar("Error", "Couldn't Update your Profile Details",
              backgroundColor: Colors.red,
              colorText: kWhiteColor,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        isLoading = false;
        update();
        // Get.snackbar("Error", "Couldn't Update your Profile Details",
        //     backgroundColor: Colors.red,
        //     colorText: kWhiteColor,
        //     snackPosition: SnackPosition.BOTTOM) ;
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar("Error", "Couldnt Update your Profile Details",
          backgroundColor: Colors.red,
          colorText: kWhiteColor,
          snackPosition: SnackPosition.BOTTOM);
      throw e;
    }
  }

  @override
  void onInit() async {
    isLoading = true;
    update();
    await Future.wait([getAcademies(), getVenues()]);
    isLoading = false;
    update();
    super.onInit();
  }

  Future<void> getAcademies() async {
    try {
      Map<String, dynamic> data = {
        "partner": MySharedPref.getUserId(),
        "type": "academy",
        "page": 1,
        "limit_per_page": 2
      };
      dynamic res = await ApiService().getListAcademies(data);
      res = jsonDecode(res.body);
      print(res);
      if (res["status"] == "success") {
        academyDataModel = AcademyModel.fromJson(res);
      } else {
        academyDataModel = AcademyModel();
        return;
      }
    } catch (e) {
      return;
    }
  }

  Future<void> getVenues() async {
    try {
      Map<String, dynamic> data = {
        "partner": MySharedPref.getUserId(),
        "type": "venue",
        "page": 1,
        "limit_per_page": 2
      };
      dynamic res = await ApiService().getListVenues(data);
      res = jsonDecode(res.body);
      print(res);
      if (res["status"] == "success") {
        venueModel = VenueModel.fromJson(res);
      } else {
        venueModel = VenueModel();
        return;
      }
    } catch (e) {
      return;
    }
  }
}
