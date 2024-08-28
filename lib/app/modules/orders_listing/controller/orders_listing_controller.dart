import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/details_model.dart';
import '../../../data/remote/api_service.dart';
import '../../home/models/booking_orders_model.dart';
import '../../home/models/subscription_model.dart';
import '../../home/models/venue_model.dart';

class OrdersListingController extends GetxController {
  String ordertype = "";
  List<DetailsModel> ordersList = List.empty(growable: true);
  String startdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String enddate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  SubscriptionOrdersModel subscriptionOrdersModel = SubscriptionOrdersModel();
  VenueOrdersModel venueOrdersModel = VenueOrdersModel();
  BookingOrdersModel bookingOrdersModel = BookingOrdersModel();
  TextEditingController searchController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool searchText = false.obs;
  int pageingnumb = 1;
  int maxpage = 0;
  String status = "";
  @override
  void onInit() async {
    ordertype = Get.arguments["order_type"];
    startdate = Get.arguments["start_date"];
    enddate = Get.arguments["end_date"];
    status = Get.arguments["status"];
    update();
    await fetchOrders(pageingnumb);

    super.onInit();
  }

  Future<void> fetchOrders(int pageingnumb) async {
    isLoading(true);
    update();
    if (searchController.text.isNotEmpty && searchText == false) {
      pageingnumb = 1;
    }
    if (ordertype == "Bookings") {
      await getAcademyOrders();
    } else if (ordertype == "Subscriptions") {
      await getSubscriptionOrders();
    } else {
      await getVenueOrders();
    }
    isLoading(false);
    update();
  }

  Future<void> getAcademyOrders() async {
    try {
      ordersList.clear();

      Map<String, dynamic> data = {
        "search_term": searchController.text,
        "user": MySharedPref.getUserId(),
        "start_date": startdate,
        "end_date": enddate,
        "page": pageingnumb,
        "status": status
      };
      dynamic res = await ApiService().getAcademyBookings(data);
      res = jsonDecode(res.body);
      print(res);
      bookingOrdersModel = BookingOrdersModel.fromJson(res);
      maxpage = bookingOrdersModel.maxPages ?? 1;
      if (bookingOrdersModel.data != null) {
        if (bookingOrdersModel.data!.isNotEmpty) {
          bookingOrdersModel.data?.forEach((element) {
            ordersList.add(DetailsModel(
                imagePath:
                    "https://tidasports.com/wp-content/uploads/2024/03/20231221132816-2023-12-21tbl_academy132811.png",
                name: element.items != null
                    ? element.items!.isNotEmpty
                        ? element.items![0].academyName ?? "N/A"
                        : "N/A"
                    : "N/A",
                location: element.items != null
                    ? element.items!.isNotEmpty
                        ? element.items![0].academyAddress ?? "N/A"
                        : "N/A"
                    : "N/A",
                noOfBookings: element.items?.length ?? 1,
                customerName: element.items != null
                    ? element.items!.isNotEmpty
                        ? element.items![0].personName ??
                            element.customer?.name ??
                            "N/A"
                        : "N/A"
                    : "N/A"));
          });
        }
      }
      update();
    } catch (e) {
      return;
    }
  }

  Future<void> getVenueOrders() async {
    try {
      ordersList.clear();
      Map<String, dynamic> data = {
        "search_term": searchController.text,
        "user": MySharedPref.getUserId(),
        "start_date": startdate,
        "end_date": enddate,
        "page": pageingnumb,
        "status": status
      };
      dynamic res = await ApiService().getVenueBookings(data);
      res = jsonDecode(res.body);
      print(res);
      venueOrdersModel = VenueOrdersModel.fromJson(res);
      maxpage = venueOrdersModel.maxPages ?? 1;
      if (venueOrdersModel.data != null) {
        if (venueOrdersModel.data!.isNotEmpty) {
          venueOrdersModel.data?.forEach((element) {
            print(element);
            ordersList.add(DetailsModel(
                imagePath:
                    "https://tidasports.com/wp-content/uploads/2024/03/20231221132816-2023-12-21tbl_academy132811.png",
                name: element.items?.a?.name ?? "N/A",
                location: element.items?.a?.address ?? "N/A",
                noOfBookings: element.items?.slots?.length ?? 1,
                customerName: element.items?.a?.personName != null
                    ? element.items?.a?.personName ??
                        element.customer?.name ??
                        "N/A"
                    : element.customer?.name ?? "N/A"));
          });
        }
      }
      update();
    } catch (e) {
      return;
    }
  }

  Future<void> getSubscriptionOrders() async {
    try {
      ordersList.clear();
      Map<String, dynamic> data = {
        "search_term": searchController.text,
        "user": MySharedPref.getUserId(),
        "start_date": startdate,
        "end_date": enddate,
        "page": pageingnumb,
        "status": status,
      };
      dynamic res = await ApiService().getSubscriptionBookings(data);
      res = jsonDecode(res.body);
      print(res);
      subscriptionOrdersModel = SubscriptionOrdersModel.fromJson(res);
      maxpage = subscriptionOrdersModel.maxPages ?? 1;
      if (subscriptionOrdersModel.data != null) {
        if (subscriptionOrdersModel.data!.isNotEmpty) {
          subscriptionOrdersModel.data?.forEach((element) {
            print(element);
            ordersList.add(DetailsModel(
                imagePath:
                    "https://tidasports.com/wp-content/uploads/2024/03/20231221132816-2023-12-21tbl_academy132811.png",
                name: element.items?[0].academyName ?? "N/A",
                location: element.items?[0].academyAddress ?? "N/A",
                noOfBookings: element.items?.length ?? 1,
                customerName: element.items?[0].personName != null
                    ? element.items![0].personName ??
                        element.customer?.name ??
                        "N/A"
                    : element.customer?.name ?? "N/A"));
          });
        }
      }
      update();
    } catch (e) {
      return;
    }
  }
}
