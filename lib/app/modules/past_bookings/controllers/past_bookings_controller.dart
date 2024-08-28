import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/local/my_shared_pref.dart';
import '../../../data/remote/api_service.dart';
import '../../upcoming_bookings/models/upcoming_booking_models.dart';
import '../../upcoming_bookings/models/upcoming_model.dart';
import '../../upcoming_bookings/models/upcoming_subscription_models.dart';
import '../widgets/filter_widget.dart';

class PastBookingsController extends GetxController {
  RxBool isLoading = false.obs;
  UpcomingBookingsModel upcomingBookingsModel = new UpcomingBookingsModel();
  UpcomingSubscriptionModel upcomingSubscriptionModel =
      new UpcomingSubscriptionModel();
  List<UpcomingModel> bookingsDetailsList = List.empty(growable: true);
  List<UpcomingModel> subscriptionDetailsList = List.empty(growable: true);
  int pageingnumbBookings = 1;
  int maxpageBookings = 0;
  int pageingnumbSubscription = 1;
  int maxpageSubscription = 0;
  int pageingnumb = 1;
  int maxpage = 0;
  int selectedOption = 1;
  RxInt activeTab = 0.obs;
  RxBool hasData = false.obs;
  RxBool hasDataSub = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading(true);
    update();
    await fetchBookings();
    isLoading(false);
    update();
  }

  Future<void> fetchBookings() async {
    isLoading(true);
    update();
    await Future.wait([
      getBookingOrders(1),
      getSubscriptionOrders(1)
    ]);
    isLoading(false);
    update();
  }

  void updateFilter() {
    Get.dialog(Wrap(children: [
      Material(
        type: MaterialType.transparency,
        child: FilterWidget(),
      ),
    ]));
  }

  void changefilter(int value) {
    selectedOption = value;
    update();
  }

  Future<void> getBookingOrders(int pagenumber) async {
    isLoading(true);
    update();
    bookingsDetailsList.clear();
    try {
      Map<String, dynamic> data = {
        "partner_id": MySharedPref.getUserId(),
        "page": pagenumber,
        "type": "past",
        "sort_by": selectedOption == 1 ? "new" : "old"
      };
      dynamic res = await ApiService().getUpcomingBookings(data);
      res = jsonDecode(res.body);
      if (res["status"] != false) {
        upcomingBookingsModel = UpcomingBookingsModel.fromJson(res);
        maxpageBookings = upcomingBookingsModel.maxPages ?? 1;
        if (upcomingBookingsModel.data != null) {
          if (upcomingBookingsModel.data!.isNotEmpty) {
            hasData(true);
            upcomingBookingsModel.data!.forEach((element) {
              bookingsDetailsList.add(UpcomingModel(
                  imagePath: element.slot!.item!.image.toString(),
                  name: element.slot!.item!.name.toString(),
                  location: element.slot!.item!.address.toString(),
                  customerName: element.customer!.firstName.toString(),
                  slotdate: element.slot!.slotStartDate.toString() +
                      " " +
                      element.slot!.slotStartTime.toString()));
            });
          }
        }
      }
      maxpageBookings = upcomingBookingsModel.maxPages ?? 1;
      isLoading(false);
      update();
    } catch (e) {
      return;
    }
  }

  Future<void> getSubscriptionOrders(int pagenumber) async {
    isLoading(true);
    update();
    subscriptionDetailsList.clear();
    try {
      Map<String, dynamic> data = {
        "partner_id": MySharedPref.getUserId(),
        "page": pagenumber,
        "type": "past",
        "sort_by": selectedOption == 1 ? "new" : "old"
      };
      dynamic res = await ApiService().getUpcomingSubscripitions(data);
      res = jsonDecode(res.body);
      if (res["status"] != false) {
        upcomingSubscriptionModel = UpcomingSubscriptionModel.fromJson(res);
        maxpageSubscription = upcomingSubscriptionModel.maxPages ?? 1;
        if (upcomingSubscriptionModel.data != null) {
          if (upcomingSubscriptionModel.data!.isNotEmpty) {
            upcomingSubscriptionModel.data!.forEach((element) {
              subscriptionDetailsList.add(UpcomingModel(
                  imagePath: element.items![0].image.toString(),
                  name: element.items![0].academyName!.toString(),
                  location: element.items![0].academyAddress!.toString(),
                  customerName: element.customer!.firstName.toString(),
                  slotdate: element.subscriptions != null
                      ? element.subscriptions![0].nextPayment.toString()
                      : ""));
            });
            hasDataSub = true.obs;
          }
        }
        print(subscriptionDetailsList.length);
        isLoading(false);
        update();
      }
    } catch (e) {
      return;
    }
  }
}
