import 'dart:convert';

import 'package:get/get.dart';

import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/details_model.dart';
import '../../../data/remote/api_service.dart';
import '../../home/models/subscription_model.dart';

class SubscriptionListController extends GetxController {
  SubscriptionOrdersModel subscriptionOrdersModel = SubscriptionOrdersModel();
  RxBool isLoading = false.obs;
  List<DetailsModel> subscriptionDetailsList = List.empty(growable: true);

  @override
  void onInit() async {
    isLoading(true);
    update();
    await getSubscriptionOrders();
    isLoading(true);
    super.onInit();
  }

  Future<void> getSubscriptionOrders() async {
    subscriptionDetailsList.clear();
    Map<String, dynamic> data = {
      "user": MySharedPref.getUserId(),
      "start_date": "2024-03-01",
      "end_date": "2024-04-14"
    };
    dynamic res = await ApiService().getSubscriptionBookings(data);
    res = jsonDecode(res.body);
    print(res);
    subscriptionOrdersModel = SubscriptionOrdersModel.fromJson(res);
    if (subscriptionOrdersModel.data != null) {
      if (subscriptionOrdersModel.data!.isNotEmpty) {
        subscriptionOrdersModel.data?.forEach((element) {
          print(element);
          subscriptionDetailsList.add(DetailsModel(
              imagePath:
                  "https://tidasports.com/wp-content/uploads/2024/03/20231221132816-2023-12-21tbl_academy132811.png",
              name: element.items?[0].academyName ?? "N/A",
              location: element.items?[0].academyAddress ?? "N/A",
              noOfBookings: element.items?.length ?? 1));
        });
      }
    }
  }
}
