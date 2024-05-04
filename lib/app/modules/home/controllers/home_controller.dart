import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tidapartners/app/modules/home/models/booking_orders_model.dart';
import 'package:tidapartners/app/modules/home/widgets/filter_widget.dart';

import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/details_model.dart';
import '../../../data/remote/api_service.dart';
import '../models/subscription_model.dart';
import '../models/venue_model.dart';

class HomeController extends GetxController {
  SubscriptionOrdersModel subscriptionOrdersModel = SubscriptionOrdersModel();
  VenueOrdersModel venueOrdersModel = VenueOrdersModel();
  BookingOrdersModel bookingOrdersModel = BookingOrdersModel();
  bool isLoading = false;
  List<DetailsModel> bookingsDetailsList = List.empty(growable: true);
  List<DetailsModel> subscriptionDetailsList = List.empty(growable: true);
  List<DetailsModel> slotsDetailsList = List.empty(growable: true);
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  DateTime pickedStartDate = DateTime.now();
  DateTime pickedEndDate = DateTime.now();
  String startdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String enddate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int selectedOption = 1;
  RxBool isFilter = false.obs;
  int totalOrders = 0;

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

  void filterorders() async {
    Get.back();
    isLoading = true;
    update();
    if (selectedOption == 1) {
      selectedStartDate = DateTime.now();
      selectedEndDate = DateTime.now();
    } else if (selectedOption == 2) {
      selectedEndDate = DateTime.now();
      selectedStartDate = DateTime.now().subtract(Duration(days: 7));
    } else if (selectedOption == 3) {
      selectedEndDate = DateTime.now();
      selectedStartDate =
          DateTime(DateTime.now().year, DateTime.now().month, 1);
    } else if (selectedOption == 4) {
      selectedStartDate = DateTime(DateTime.now().year, DateTime.now().month, 1)
          .subtract(Duration(days: 30));
      selectedEndDate = selectedStartDate.add(Duration(days: 30));
    } else {
      selectedStartDate = pickedStartDate;
      selectedEndDate = pickedEndDate;
      update();
    }
    startdate = DateFormat("yyyy-MM-dd").format(selectedStartDate);
    enddate = DateFormat("yyyy-MM-dd").format(selectedEndDate);
    await Future.wait([
      getAcademyOrders(),
      getVenueOrders(),
      getSubscriptionOrders(),
    ]);
    isLoading = false;
    totalOrders = (bookingsDetailsList.length) +
        (subscriptionDetailsList.length) +
        (slotsDetailsList.length);
    update();
  }

  @override
  void onInit() async {
    isLoading = true;
    update();
    await Future.wait([
      getAcademyOrders(),
      getVenueOrders(),
      getSubscriptionOrders(),
    ]);
    isLoading = false;
    totalOrders = (bookingsDetailsList.length) +
        (subscriptionDetailsList.length) +
        (slotsDetailsList.length);
    update();
    super.onInit();
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickedStartDate != null ? pickedStartDate! : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != pickedStartDate) {
      pickedStartDate = picked;
      update();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: pickedEndDate != null ? pickedEndDate : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != pickedEndDate) {
      pickedEndDate = picked;
      update();
    }
  }

  Future<void> getAcademyOrders() async {
    try {
      bookingsDetailsList.clear();
      Map<String, dynamic> data = {
        "user": MySharedPref.getUserId(),
        "start_date": startdate,
        "end_date": enddate,
      };
      dynamic res = await ApiService().getAcademyBookings(data);
      res = jsonDecode(res.body);
      print(res);
      bookingOrdersModel = BookingOrdersModel.fromJson(res);
      if (bookingOrdersModel.data != null) {
        if (bookingOrdersModel.data!.isNotEmpty) {
          bookingOrdersModel.data?.forEach((element) {
            bookingsDetailsList.add(DetailsModel(
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
                noOfBookings: element.items?.length ?? 1));
          });
        }
      }
    } catch (e) {
      return;
    }
  }

  Future<void> getVenueOrders() async {
    try {
      slotsDetailsList.clear();
      Map<String, dynamic> data = {
        "user": MySharedPref.getUserId(),
        "start_date": startdate,
        "end_date": enddate
      };
      dynamic res = await ApiService().getVenueBookings(data);
      res = jsonDecode(res.body);
      print(res);
      venueOrdersModel = VenueOrdersModel.fromJson(res);
      if (venueOrdersModel.data != null) {
        if (venueOrdersModel.data!.isNotEmpty) {
          venueOrdersModel.data?.forEach((element) {
            print(element);
            slotsDetailsList.add(DetailsModel(
                imagePath:
                    "https://tidasports.com/wp-content/uploads/2024/03/20231221132816-2023-12-21tbl_academy132811.png",
                name: element.items?.venue?.name ?? "N/A",
                location: element.items?.venue?.address ?? "N/A",
                noOfBookings: element.items?.slots?.length ?? 1));
          });
        }
      }
    } catch (e) {
      return;
    }
  }

  Future<void> getSubscriptionOrders() async {
    try {
      subscriptionDetailsList.clear();
      Map<String, dynamic> data = {
        "user": MySharedPref.getUserId(),
        "start_date": startdate,
        "end_date": enddate
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
    } catch (e) {
      return;
    }
  }
}
