import 'dart:convert';
import 'package:get/get.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/remote/api_service.dart';

class ProfileController extends GetxController {
  var name = MySharedPref.getName().obs;
  var job = MySharedPref.getEmail().obs;
  var location = MySharedPref.getcity().obs;
  // AcademyDataModel academyDataModel = AcademyDataModel();

  void updateProfile(String newName, String newJob, String newLocation) {
    name.value = newName;
    job.value = newJob;
    location.value = newLocation;
  }

  @override
  void onInit() async {
    await getAcademyOrders();
    await getVenueOrders();
    await getSubscriptionOrders();
    super.onInit();
  }

  getAcademyOrders() async {
    Map<String, dynamic> data = {"user": MySharedPref.getUserId()};
    dynamic res = await ApiService().getAcademyBookings(data);
    res = jsonDecode(res.body);
    print(res);
    // academyDataModel = AcademyDataModel.fromJson(res);
  }

  getVenueOrders() async {
    Map<String, dynamic> data = {"user": MySharedPref.getUserId()};
    dynamic res = await ApiService().getVenueBookings(data);
    res = jsonDecode(res.body);
    print(res);
    // academyDataModel = AcademyDataModel.fromJson(res);
  }

  getSubscriptionOrders() async {
    Map<String, dynamic> data = {"user": MySharedPref.getUserId()};
    dynamic res = await ApiService().getSubscriptionBookings(data);
    res = jsonDecode(res.body);
    print(res);
    // academyDataModel = AcademyDataModel.fromJson(res);
  }
}
