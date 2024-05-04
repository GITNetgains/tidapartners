import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/local/my_shared_pref.dart';
import '../../../data/remote/api_service.dart';
import '../../profile/models/venue_model.dart';

class VenueListController extends GetxController {
  VenueModel venueModel = VenueModel();
  RxBool isLoading = false.obs;
  int pageingnumb = 1;
  int maxpage = 0;
  @override
  void onInit() async {
    isLoading(true);
    update();
    await getVenues(1);
    isLoading(false);
    update();
    super.onInit();
  }

  Future<void> getVenues(int pageingnumb) async {
    isLoading(true);
    update();
    Map<String, dynamic> data = {
      "partner": MySharedPref.getUserId(),
      "type": "venue",
      "page": pageingnumb,
      "limit_per_page": 10
    };
    dynamic res = await ApiService().getListVenues(data);
    res = jsonDecode(res.body);
    print(res);
    venueModel = VenueModel.fromJson(res);
    maxpage = venueModel.data?.maxNumPages ?? 1;
    isLoading(false);
    update();
  }
}
