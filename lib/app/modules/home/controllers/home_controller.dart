import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  SubscriptionOrdersModel subscriptionOrdersModelPending =
      SubscriptionOrdersModel();
  VenueOrdersModel venueOrdersModelPending = VenueOrdersModel();
  BookingOrdersModel bookingOrdersModelPending = BookingOrdersModel();
  bool isLoading = false;
  List<DetailsModel> bookingsDetailsList = List.empty(growable: true);
  List<DetailsModel> subscriptionDetailsList = List.empty(growable: true);
  List<DetailsModel> slotsDetailsList = List.empty(growable: true);
  List<DetailsModel> bookingsDetailsListPending = List.empty(growable: true);
  List<DetailsModel> subscriptionDetailsListPending =
      List.empty(growable: true);
  List<DetailsModel> slotsDetailsListPending = List.empty(growable: true);
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  DateTime pickedStartDate = DateTime.now();
  DateTime pickedEndDate = DateTime.now();
  String startdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String enddate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int selectedOption = 1;
  RxBool isFilter = false.obs;
  RxInt totalOrders = 0.obs;
  RxString status = "completed".obs;
  RxDouble displayOrdersSucessfull = 0.0.obs;
  RxDouble displayOrdersPending = 0.0.obs;
  RxInt totalOrdersPending = 0.obs;
  RxInt totalBookingsOrdersValue = 0.obs;
  RxInt totalSlotOrdersValue = 0.obs;
  RxInt totalSubscriptionOrderValue = 0.obs;

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

  Future<void> filterorders() async {
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
      getAcademyOrdersPending(),
      getVenueOrdersPending(),
      getSubscriptionOrdersPending(),
    ]);
    isLoading = false;
    totalOrders.value = (int.parse(bookingOrdersModel.totalOrders.toString()) +
        int.parse(subscriptionOrdersModel.totalOrders.toString()) +
        int.parse(venueOrdersModel.totalOrders.toString()));
    displayOrdersSucessfull.value = (bookingOrdersModel.data != null
            ? (bookingOrdersModel.data!.length == 0
                ? 1 * 70.h
                : bookingOrdersModel.data!.length * 107.h)
            : 1 * 70.h) +
        (subscriptionOrdersModel.data != null
            ? (subscriptionOrdersModel.data!.length == 0
                ? 1 * 70.h
                : subscriptionOrdersModel.data!.length * 107.h)
            : 1 * 70.h) +
        (venueOrdersModel.data != null
            ? (venueOrdersModel.data!.length == 0
                ? 1 * 70.h
                : venueOrdersModel.data!.length * 107.h)
            : 1 * 70.h) +
        (50.h * 3);

    totalBookingsOrdersValue.value =
        (int.parse(bookingOrdersModelPending.totalOrders.toString()) +
            int.parse(bookingOrdersModel.totalOrders.toString()));
    totalSubscriptionOrderValue.value =
        (int.parse(subscriptionOrdersModelPending.totalOrders.toString()) +
            int.parse(subscriptionOrdersModel.totalOrders.toString()));
    totalSlotOrdersValue.value =
        (int.parse(venueOrdersModelPending.totalOrders.toString()) +
            int.parse(venueOrdersModel.totalOrders.toString()));

    totalOrdersPending.value =
        (int.parse(bookingOrdersModelPending.totalOrders.toString()) +
            int.parse(subscriptionOrdersModelPending.totalOrders.toString()) +
            int.parse(venueOrdersModelPending.totalOrders.toString()));
    displayOrdersPending.value = (bookingOrdersModelPending.data != null
            ? (bookingOrdersModelPending.data!.length == 0
                ? 1 * 70.h
                : bookingOrdersModelPending.data!.length * 107.h)
            : 1 * 70.h) +
        (subscriptionOrdersModelPending.data != null
            ? (subscriptionOrdersModelPending.data!.length == 0
                ? 1 * 70.h
                : subscriptionOrdersModelPending.data!.length * 107.h)
            : 1 * 70.h) +
        (venueOrdersModelPending.data != null
            ? (venueOrdersModelPending.data!.length == 0
                ? 1 * 70.h
                : venueOrdersModelPending.data!.length * 107.h)
            : 1 * 70.h) +
        (50.h * 3);
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
      getAcademyOrdersPending(),
      getVenueOrdersPending(),
      getSubscriptionOrdersPending(),
      setupInteractedMessage()
    ]);
    isLoading = false;
    totalOrders.value =
        await (int.parse(bookingOrdersModel.totalOrders.toString()) +
            int.parse(subscriptionOrdersModel.totalOrders.toString()) +
            int.parse(venueOrdersModel.totalOrders.toString()));
    displayOrdersSucessfull.value = (bookingOrdersModel.data != null
            ? (bookingOrdersModel.data!.length == 0
                ? 1 * 70.h
                : bookingOrdersModel.data!.length * 107.h)
            : 1 * 70.h) +
        (subscriptionOrdersModel.data != null
            ? (subscriptionOrdersModel.data!.length == 0
                ? 1 * 70.h
                : subscriptionOrdersModel.data!.length * 107.h)
            : 1 * 70.h) +
        (venueOrdersModel.data != null
            ? (venueOrdersModel.data!.length == 0
                ? 1 * 70.h
                : venueOrdersModel.data!.length * 107.h)
            : 1 * 70.h) +
        (50.h * 3);

    totalBookingsOrdersValue.value =
        (int.parse(bookingOrdersModelPending.totalOrders.toString()) +
            int.parse(bookingOrdersModel.totalOrders.toString()));
    totalSubscriptionOrderValue.value =
        (int.parse(subscriptionOrdersModelPending.totalOrders.toString()) +
            int.parse(subscriptionOrdersModel.totalOrders.toString()));
    totalSlotOrdersValue.value =
        (int.parse(venueOrdersModelPending.totalOrders.toString()) +
            int.parse(venueOrdersModel.totalOrders.toString()));

    totalOrdersPending.value =
        (int.parse(bookingOrdersModelPending.totalOrders.toString()) +
            int.parse(subscriptionOrdersModelPending.totalOrders.toString()) +
            int.parse(venueOrdersModelPending.totalOrders.toString()));
    displayOrdersPending.value = (bookingOrdersModelPending.data != null
            ? (bookingOrdersModelPending.data!.length == 0
                ? 1 * 70.h
                : bookingOrdersModelPending.data!.length * 107.h)
            : 1 * 70.h) +
        (subscriptionOrdersModelPending.data != null
            ? (subscriptionOrdersModelPending.data!.length == 0
                ? 1 * 70.h
                : subscriptionOrdersModelPending.data!.length * 107.h)
            : 1 * 70.h) +
        (venueOrdersModelPending.data != null
            ? (venueOrdersModelPending.data!.length == 0
                ? 1 * 70.h
                : venueOrdersModelPending.data!.length * 107.h)
            : 1 * 70.h) +
        (50.h * 3);

    update();
    super.onInit();
  }

  

  Future<void> setupInteractedMessage() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null)
        await ApiService().updateFCMToken(
            {"userid": MySharedPref.getUserId(), "fcm_token": token});
    } catch (e) {
      print(e);
    }
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await ApiService().updateFCMToken(
          {"userid": MySharedPref.getUserId(), "fcm_token": token});
    });
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
        "limit_per_page": 2,
        "status": status.value,
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
                noOfBookings: element.items?.length ?? 1,
                customerName: element.items != null
                    ? element.items!.isNotEmpty
                        ? element.items![0].personName ?? "N/A"
                        : "N/A"
                    : "N/A"));
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
        "end_date": enddate,
        "limit_per_page": 2,
        "status": status.value
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
                name: element.items?.a?.name ?? "N/A",
                location: element.items?.a?.address ?? "N/A",
                noOfBookings: element.items?.slots?.length ?? 1,
                customerName: element.items?.a?.personName ?? "N/A"));
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
        "end_date": enddate,
        "limit_per_page": 2,
        "status": status.value
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
                noOfBookings: element.items?.length ?? 1,
                customerName: element.items?[0].personName ?? "N/A"));
          });
        }
      }
    } catch (e) {
      return;
    }
  }

  Future<void> getAcademyOrdersPending() async {
    try {
      bookingsDetailsListPending.clear();
      Map<String, dynamic> data = {
        "user": MySharedPref.getUserId(),
        "start_date": startdate,
        "end_date": enddate,
        "limit_per_page": 2,
        "status": "pending",
      };
      dynamic res = await ApiService().getAcademyBookings(data);
      res = jsonDecode(res.body);
      print(res);
      bookingOrdersModelPending = BookingOrdersModel.fromJson(res);
      if (bookingOrdersModelPending.data != null) {
        if (bookingOrdersModelPending.data!.isNotEmpty) {
          bookingOrdersModelPending.data?.forEach((element) {
            bookingsDetailsListPending.add(DetailsModel(
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
                        ? element.items![0].personName ?? "N/A"
                        : "N/A"
                    : "N/A"));
          });
        }
      }
    } catch (e) {
      return;
    }
  }

  Future<void> getVenueOrdersPending() async {
    try {
      slotsDetailsListPending.clear();
      Map<String, dynamic> data = {
        "user": MySharedPref.getUserId(),
        "start_date": startdate,
        "end_date": enddate,
        "limit_per_page": 2,
        "status": "pending",
      };
      dynamic res = await ApiService().getVenueBookings(data);
      res = jsonDecode(res.body);
      print(res);
      venueOrdersModelPending = VenueOrdersModel.fromJson(res);
      if (venueOrdersModelPending.data != null) {
        if (venueOrdersModelPending.data!.isNotEmpty) {
          venueOrdersModelPending.data?.forEach((element) {
            print(element);
            slotsDetailsListPending.add(DetailsModel(
                imagePath:
                    "https://tidasports.com/wp-content/uploads/2024/03/20231221132816-2023-12-21tbl_academy132811.png",
                name: element.items?.a?.name ?? "N/A",
                location: element.items?.a?.address ?? "N/A",
                noOfBookings: element.items?.slots?.length ?? 1,
                customerName: element.items?.a?.personName ?? "N/A"));
          });
        }
      }
    } catch (e) {
      return;
    }
  }

  Future<void> getSubscriptionOrdersPending() async {
    try {
      subscriptionDetailsListPending.clear();
      Map<String, dynamic> data = {
        "user": MySharedPref.getUserId(),
        "start_date": startdate,
        "end_date": enddate,
        "limit_per_page": 2,
        "status": "pending",
      };
      dynamic res = await ApiService().getSubscriptionBookings(data);
      res = jsonDecode(res.body);
      print("------------subscriptions");
      print(res);
      subscriptionOrdersModelPending = SubscriptionOrdersModel.fromJson(res);
      if (subscriptionOrdersModelPending.data != null) {
        if (subscriptionOrdersModelPending.data!.isNotEmpty) {
          print(subscriptionOrdersModelPending.data!.length);
          subscriptionOrdersModelPending.data?.forEach((element) {
            print(element);
            subscriptionDetailsListPending.add(DetailsModel(
                imagePath:
                    "https://tidasports.com/wp-content/uploads/2024/03/20231221132816-2023-12-21tbl_academy132811.png",
                name: element.items?[0].academyName ?? "N/A",
                location: element.items?[0].academyAddress ?? "N/A",
                noOfBookings: element.items?.length ?? 1,
                customerName: element.items?[0].personName ?? "N/A"));
          });
        }
      }
    } catch (e) {
      return;
    }
  }
}
