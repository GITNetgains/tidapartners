import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/local/my_shared_pref.dart';
import '../../../data/remote/api_service.dart';
import '../../profile/models/academy_model.dart';

class AcademyListController extends GetxController {
  AcademyModel academyDataModel = AcademyModel();
  RxBool isLoading = false.obs;
  int pageingnumb = 1;
  int maxpage = 0;
  @override
  void onInit() async {
    isLoading(true);
    update();
    await getAcademies(1);
    isLoading(false);
    update();
    super.onInit();
  }

  Future<void> getAcademies(int pageingnumb) async {
     isLoading(true);
    update();
    Map<String, dynamic> data = {
      "partner": MySharedPref.getUserId(),
      "type": "academy",
      "page": pageingnumb,
      "limit_per_page": 10
    };
    dynamic res = await ApiService().getListAcademies(data);
    res = jsonDecode(res.body);
    print(res);
    academyDataModel = AcademyModel.fromJson(res);
    maxpage = academyDataModel.data?.maxNumPages ?? 1;
     isLoading(false);
    update();
  }
}
