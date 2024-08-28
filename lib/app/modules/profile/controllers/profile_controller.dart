import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tidapartners/app/routes/app_pages.dart';
import '../../../../utils/colors.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/customer_model.dart';
import '../../../data/remote/api_interface.dart';
import '../../../data/remote/api_service.dart';
import '../../../data/remote/endpoints.dart';
import '../models/academy_model.dart';
import '../models/venue_model.dart';
import 'package:crypto/crypto.dart';
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
    dynamic res = await ApiService()
        .availablecodoption({"partnerid": MySharedPref.getUserId()});
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

  Future<String?> addPropicApi2() async {
    Map<String, String> headers = {
      'authorization': ApiInterface.auth.toString(),
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(ApiInterface.baseUrl + Endpoints.updateProfileImg));
    request.fields.addAll({
      'user_id': MySharedPref.getUserId().toString(),
    });
    if (croppedFile != null) {
      File imageFile = File(croppedFile!.path);
      String url = await uploadImageToCloudinary(imageFile.path);
      print(url);
      MySharedPref.setAvatar(url);
      return url;
      // request.files.add(
      // await http.MultipartFile.fromPath('async-upload', croppedFile!.path));
    } else {
      return MySharedPref.getAvatar();
    }
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    // print(response.statusCode);

    // if (response.statusCode == 200) {
    //   var res = await response.stream.transform(utf8.decoder).join();
    //   Map<String, dynamic> data = json.decode(res);
    //   print(data);
    //   userImage = data["data"]["profile_url"];
    //   update();
    // }
  }

  Future<String> uploadImageToCloudinary(String imagePath) async {
    // Read the image file
    File imageFile = File(imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();

    // Create the Cloudinary URL
    var url =
        Uri.parse('https://api.cloudinary.com/v1_1/dxvobpwzc/image/upload');

    // Prepare the Cloudinary API request
    var request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'unsigned_preset'
      // ..fields['public_id'] = "Profile Image"
      ..fields['api_key'] = '285531831575646'
      ..fields['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString()
      // ..fields['signature'] = _generateSignature('ULlUBDwTvHzN9_OnyKgVJmx7REw',
      // DateTime.now().millisecondsSinceEpoch.toString())
      ..files.add(http.MultipartFile.fromBytes('file', imageBytes,
          filename: "imagePath.jpg"));

    // Send the request to Cloudinary
    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseString);
    print(jsonResponse);
    print("=========================================");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonResponse['secure_url'];
    } else {
      throw Exception('Failed to upload image to Cloudinary: $responseString');
    }
  }

  String _generateSignature(String apiSecret, String timestamp) {
    var bytes = utf8.encode('timestamp=$timestamp$apiSecret');
    return md5.convert(bytes).toString();
  }


  Future<void> editProfileDetails() async {
    try {
      isLoading = true;
      update();
      if (emailController.text.trim().isEmpty && selectedAvatar == null) {
        isLoading = false;
        update();
        Get.snackbar("Error", "Please enter your email address",
            backgroundColor: Colors.red,
            colorText: kWhiteColor,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      if (nameController.text.trim().isEmpty && selectedAvatar == null) {
        isLoading = false;
        update();
        Get.snackbar("Error", "Please enter your name",
            backgroundColor: Colors.red,
            colorText: kWhiteColor,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      if (phoneController.text.trim().isEmpty && selectedAvatar == null) {
        isLoading = false;
        update();
        Get.snackbar("Error", "Please enter your phone number",
            backgroundColor: Colors.red,
            colorText: kWhiteColor,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      if (phoneController.text.trim().length != 10) {
        isLoading = false;
        update();
        Get.snackbar("Error", "Please provide a valid phone number",
            backgroundColor: Colors.red,
            colorText: kWhiteColor,
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      String profileImg = MySharedPref.getAvatar().toString();
      if (selectedAvatar != null) {
        profileImg = await addPropicApi2() ?? "";
      }
      Map<String, dynamic> data = {
        "user_id": MySharedPref.getUserId(),
        "phone_number": phoneController.text,
        "name": nameController.text,
        "signature": "",
        "image_url": profileImg
      };
      print(data);
      print(MySharedPref.getUserId());
      dynamic res = await ApiService().updateUserDetails(data);
      if (res.statusCode == 200) {
        Map<String, dynamic> updateResponse = jsonDecode(res.body);
        print(updateResponse);
        if (updateResponse["status"] == true) {
          MySharedPref.setName(updateResponse["name"]);
          MySharedPref.setPhone(updateResponse["phone_number"]);
          MySharedPref.setAvatar(updateResponse["image_url"]);
          isLoading = false;
          update();
          Get.snackbar("Successfull", "Profile updated successfully",
              backgroundColor: kSuccessColor,
              colorText: kWhiteColor,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          isLoading = false;
          update();
          if (updateResponse["status"] == false &&
              updateResponse["message"] != null) {
            Get.snackbar("Error", updateResponse["message"],
                backgroundColor: Colors.red,
                colorText: kWhiteColor,
                snackPosition: SnackPosition.BOTTOM);
          }
          else{
            Get.snackbar("Error", "Server Time Out",
                backgroundColor: Colors.red,
                colorText: kWhiteColor,
                snackPosition: SnackPosition.BOTTOM);
          }
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
      Get.snackbar("Error", "Couldn't Update your Profile Details",
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
    userImage = MySharedPref.getAvatar();
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
