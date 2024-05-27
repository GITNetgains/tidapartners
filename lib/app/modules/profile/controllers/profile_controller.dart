import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../../utils/colors.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/customer_model.dart';
import '../../../data/remote/api_interface.dart';
import '../../../data/remote/api_service.dart';
import '../../../data/remote/endpoints.dart';
import '../models/academy_model.dart';
import '../models/venue_model.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  bool light0 = true;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  bool isLoading = false;
  var name = MySharedPref.getName().obs;
  var job = MySharedPref.getEmail().obs;
  var location = MySharedPref.getcity().obs;
  AcademyModel academyDataModel = AcademyModel();
  VenueModel venueModel = VenueModel();
  File? croppedFile;
  XFile? selectedAvatar;
  String? userImage;
  bool? isUploading = false;

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

  Future<bool> checkcod() async {
    dynamic res =
        await ApiService().availablecodoption({"partnerid": MySharedPref.getUserId()});
    res = jsonDecode(res.body);
    print(res["enable_cod"]);
    if (res["enable_cod"] == "1") {
      return true;
    } else {
      return false;
    }
  }

  void updatecashmode() {
    light0 = !light0;
    dynamic res = ApiService().togglecodpayment({
      "userid": MySharedPref.getUserId(),
      "enable_cod": light0 == true ? "1" : "0"
    });
    update();
  }

  bool? isProperString(String? s) {
    if (s != null && s.trim().isNotEmpty && s.trim() != "null") {
      return true;
    } else {
      return false;
    }
  }

  void pickImage(ImageSource source) async {
    selectedAvatar = await ImagePicker().pickImage(source: source);
    print(selectedAvatar?.path);
    if (selectedAvatar != null) {
      CroppedFile? cf = await ImageCropper().cropImage(
        sourcePath: selectedAvatar!.path,
        cropStyle: CropStyle.circle,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 20,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.red,
            toolbarWidgetColor: Colors.white,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );
      if (cf != null) {
        croppedFile = File(cf.path);
      }
    }
    update();
  }

  Future<void> addPropicApi2() async {
    // var headers = {
    //   'Content-Type': 'multipart/form-data;',
    // };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiInterface.baseUrl + Endpoints.updateProfileImg));
    request.fields.addAll({
      'user_id': MySharedPref.getUserId().toString(),
    });
    if (croppedFile != null) {
      request.files.add(
          await http.MultipartFile.fromPath('async-upload', croppedFile!.path));
    }
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      var res = await response.stream.transform(utf8.decoder).join();
      Map<String, dynamic> data = json.decode(res);
      MySharedPref.setAvatar(data["data"]["profile_url"]);
      userImage = data["data"]["profile_url"];
      update();
    }
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
          if (selectedAvatar != null) {
            await addPropicApi2();
          }
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
    light0 = await checkcod();
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
