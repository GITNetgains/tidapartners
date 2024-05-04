import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/models/venue_model.dart';

class VenueDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  Data1 venueDataModel = Data1();
  RxString address = "".obs;
  String orderkey = "wc_order";
  String orderid = "0";
  String subscriptionid = "";
  TextEditingController personnamectrl = TextEditingController();
  List<Slots> uniqueSlots = List.empty(growable: true);
  @override
  void onInit() async {
    isLoading.value = true;
    update();
    venueDataModel = Get.arguments["data"];
    await filteruniqueslots();
    isLoading.value = false;
    update();
    super.onInit();
  }

  filteruniqueslots() {
    Set<String> uniqueNames = {};
    uniqueSlots.clear();
    print(venueDataModel.slots?.length);
    for (var slot in venueDataModel.slots ?? []) {
      print(slot.runtimeType);
      if (!uniqueNames.contains(slot.slotName)) {
        uniqueNames.add(slot.slotName ?? "");
        uniqueSlots.add(slot);
      }
    }
    update();
    uniqueSlots.forEach((slot) {
      print(slot.toJson());
    });
  }
}
