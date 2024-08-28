import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tidapartners/app/data/local/my_shared_pref.dart';
import 'package:tidapartners/app/modules/home/models/subscription_model.dart'
    as subscription;
import 'package:tidapartners/app/modules/home/models/venue_model.dart' as venue;

import '../../../../utils/colors.dart';
import '../../../data/remote/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../home/models/booking_orders_model.dart' as booking;

class DetailsController extends GetxController {
  RxString detailname = "".obs;
  List<TableRow> rows1 = List.empty(growable: true);
  List<List<TableRow>> rows2 = List.empty(growable: true);
  venue.Data venueOrdersModel = venue.Data();
  subscription.Data subscriptionOrdersModel = subscription.Data();
  booking.Data bookingOrdersModel = booking.Data();
  TextEditingController personnamectrl = TextEditingController();
  String orderid = "";
  RxBool isLoading = false.obs;
  String CustomerpartnerId = "";
  RxBool isAcceptReject = false.obs;

  @override
  void onInit() async {
    detailname.value = Get.arguments["detailname"];
    update();
    if (detailname.value == "booking") {
      bookingOrdersModel = Get.arguments["data"];
      bookingDetails();
      orderid = bookingOrdersModel.id.toString();
      CustomerpartnerId = bookingOrdersModel.customer!.id.toString();
      update();
    } else if (detailname.value == "subscription") {
      subscriptionOrdersModel = Get.arguments["data"];
      subscriptionDetails();
      orderid = subscriptionOrdersModel.id.toString();
      CustomerpartnerId = subscriptionOrdersModel.customer!.id.toString();
      update();
    } else {
      venueOrdersModel = Get.arguments["data"];
      venueDetails();
      orderid = venueOrdersModel.id.toString();
      CustomerpartnerId = subscriptionOrdersModel.customer!.id.toString();
      update();
    }
    isAcceptReject.value = (bookingOrdersModel.transactionType == "offline" ||
            subscriptionOrdersModel.transactionType == "offline" ||
            venueOrdersModel.transactionType == "offline") &&
        (bookingOrdersModel.status == "on-hold" ||
            subscriptionOrdersModel.status == "on-hold");
    update();
    super.onInit();
  }

  void remarks(
    void Function()? onPressed,
  ) {
    Get.dialog(Center(
      child: Wrap(
        children: [
          Material(
            type: MaterialType.transparency,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Remarks",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                        color: Colors.grey.withOpacity(0.2)),
                    child: TextField(
                      controller: personnamectrl,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0.dg),
                          hintText: "Enter Remarks",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kPrimaryColor)),
                      onPressed: onPressed,
                      child: const Text(
                        "Confirm",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void completeOrder(String status) async {
    isLoading(true);
    update();
    Get.back();
    Map<String, dynamic> data = {
      "order_id": orderid,
      "status": status,
      "note": personnamectrl.text,
      "userid": CustomerpartnerId,
      "fcmToken": await FirebaseMessaging.instance.getToken(),
      "customerUserId": MySharedPref.getUserId(),
    };
    dynamic result = await ApiService().updateOrderStatus(data);
    print(result);
    if (detailname.value == "booking") {
      bookingOrdersModel.status = status;
      // await resonseapi(orderid, bookingOrdersModel.customer!.id.toString());
      update();
    } else if (detailname.value == "subscription") {
      subscriptionOrdersModel.status = status;
      // await resonseapi(
      // orderid, subscriptionOrdersModel.customer!.id.toString());
      update();
    } else {
      venueOrdersModel.status = status;
      // await resonseapi(orderid, venueOrdersModel.customer!.id.toString());
      update();
    }
    // Get.back();
    Get.snackbar(
      'Success',
      'Order Updated Sucessfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10.0,
      margin: const EdgeInsets.all(10.0),
      isDismissible: true,
      duration: const Duration(seconds: 3),
    );
    update();
    Get.toNamed(AppPages.HOME);
    isLoading(false);
  }

  void bookingDetails() {
    rows1.add(buildTableRow("Booking ID", bookingOrdersModel.id.toString()));
    rows1.add(buildTableRow(
        "Booking Status", bookingOrdersModel.status ?? "Pending"));
    rows1.add(buildTableRow(
        "Customer Name",
        bookingOrdersModel.items != null
            ? bookingOrdersModel.items![0].personName ?? ""
            : bookingOrdersModel.customer?.name ?? "Harsh"));
    rows1.add(buildTableRow("Phone Number",
        bookingOrdersModel.customer?.phone ?? "+91 9353478558"));
        print(bookingOrdersModel.transactionType);
    for (booking.Items item in bookingOrdersModel.items ?? []) {
      rows2.add([
        if (bookingOrdersModel.transactionId!.isNotEmpty)
          buildTableRow(
              "Transaction ID",
              bookingOrdersModel.transactionId!.isNotEmpty
                  ? bookingOrdersModel.transactionId ?? "Cash"
                  : "Cash"),
        buildTableRow(
            "Transaction Type",
            bookingOrdersModel.transactionType != null
                ? bookingOrdersModel.transactionType!.isNotEmpty
                    ? bookingOrdersModel.transactionType.toString()
                    : "No Data"
                : "No Data"),
        if (bookingOrdersModel.total != null)
          buildTableRow("Total Amount", "₹ ${bookingOrdersModel.total ?? 499}"),
        if (bookingOrdersModel.totalDiscountedAmount != null)
          buildTableRow("Bill Amount",
              "₹ ${bookingOrdersModel.totalDiscountedAmount ?? 499}"),
        buildTableRow(
            "Booking Date", bookingOrdersModel.createdDate?.date ?? "No Data"),
        buildTableRow("Academy Name", item.academyName ?? "No Data"),
        buildTableRow("Academy Address", item.academyAddress ?? "No Data"),
        buildTableRow("Package Name", item.packageName ?? "No Data"),
        buildTableRow("Package Amount", "₹ ${item.packageAmount ?? 499}"),
      ]);
    }
  }

  void subscriptionDetails() {
    rows1.add(
        buildTableRow("Booking ID", subscriptionOrdersModel.id.toString()));
    rows1.add(buildTableRow(
        "Booking Status", subscriptionOrdersModel.status ?? "Pending"));
    rows1.add(buildTableRow(
        "Customer Name",
        subscriptionOrdersModel.items != null
            ? subscriptionOrdersModel.items![0].personName ??
                subscriptionOrdersModel.customer?.name ??
                "N/A"
            : subscriptionOrdersModel.customer?.name ?? "Harsh"));
    rows1.add(buildTableRow("Phone Number",
        subscriptionOrdersModel.customer?.phone ?? "+91 9353478338"));

    for (subscription.Items item in subscriptionOrdersModel.items ?? []) {
      rows2.add([
        if (subscriptionOrdersModel.transactionId!.isNotEmpty)
          buildTableRow(
              "Transaction ID",
              subscriptionOrdersModel.transactionId!.isNotEmpty
                  ? subscriptionOrdersModel.transactionId ?? "No Data"
                  : "No Data"),
        buildTableRow(
            "Transaction Type",
            subscriptionOrdersModel.transactionType != null
                ? subscriptionOrdersModel.transactionType!.isNotEmpty
                    ? subscriptionOrdersModel.transactionType.toString()
                    : "No Data"
                : "No Data"),
        if (subscriptionOrdersModel.total != null)
          buildTableRow(
              "Total Amount", "₹ ${subscriptionOrdersModel.total ?? 499}"),
        if (subscriptionOrdersModel.totalDiscountedAmount != null)
          buildTableRow("Bill Amount",
              "₹ ${subscriptionOrdersModel.totalDiscountedAmount ?? 499}"),
        buildTableRow("Booking Date",
            subscriptionOrdersModel.createdDate?.date ?? "No Data"),
        buildTableRow("Academy Name", item.academyName ?? "No data"),
        buildTableRow("Academy Address", item.academyAddress ?? "No data"),
        buildTableRow("Package Name", item.packageName ?? "Welcome Plan"),
        buildTableRow("Package Amount", "₹ ${item.packageAmount ?? 499}"),
        buildTableRow('Subscription Start Date',
            subscriptionOrdersModel.subscriptions?[0].start ?? "27, Feb 2024"),
        buildTableRow(
            "Next Renewal",
            subscriptionOrdersModel.subscriptions?[0].nextPayment ??
                "27,Feb 2024"),
      ]);
    }
  }

  void venueDetails() {
    rows1.add(buildTableRow("Booking ID", venueOrdersModel.id.toString()));
    rows1.add(
        buildTableRow("Booking Status", venueOrdersModel.status ?? "Pending"));
    rows1.add(buildTableRow(
        "Customer Name",
        venueOrdersModel.items?.a?.personName != ""
            ? venueOrdersModel.items?.a?.personName ??
                venueOrdersModel.customer!.name ??
                "No Data"
            : venueOrdersModel.customer?.name ?? "No Data"));
    rows1.add(buildTableRow(
        "Phone Number", venueOrdersModel.customer?.phone ?? "No Data"));
    rows1.add(buildTableRow(
        "Transaction Type",
        venueOrdersModel.transactionType != null
            ? venueOrdersModel.transactionId!.isNotEmpty
                ? "Online"
                : "Online"
            : "Online"));
    // if (venueOrdersModel.transactionId != null
    //     ? venueOrdersModel.transactionId!.isEmpty
    //     : false) {
    if (venueOrdersModel.transactionId!.isNotEmpty)
      rows1.add(buildTableRow(
          "Transaction ID",
          venueOrdersModel.transactionId != ""
              ? venueOrdersModel.transactionId ?? "No Data"
              : "No Data"));
    if (venueOrdersModel.total != null)
      rows1.add(buildTableRow(
          "Total Amount", "₹ ${venueOrdersModel.total.toString()}"));
    if (venueOrdersModel.totalDiscountedAmount != null)
      rows1.add(buildTableRow("Bill Amount",
          "₹ ${venueOrdersModel.totalDiscountedAmount.toString()}"));
    // }
    rows1.add(buildTableRow(
        "Booking Date", venueOrdersModel.createdDate?.date ?? "No Data"));
    rows1.add(buildTableRow(
        "Venue Name", venueOrdersModel.items?.a?.name ?? "No data"));
    rows1.add(buildTableRow(
        "Venue Address", venueOrdersModel.items?.a?.address ?? "No data"));
    if (venueOrdersModel.items?.slots != null) {
      if (venueOrdersModel.items!.slots!.isNotEmpty) {
        for (venue.Slots item in venueOrdersModel.items?.slots ?? []) {
          rows2.add([
            // buildTableRow("Slot Name", item.slotName ?? "No Data"),
            buildTableRow("Slot Amount", " ₹ ${item.slotAmount ?? 499}"),
            buildTableRow("Slot Date", item.slotStartDate ?? ""),
            buildTableRow("Slot Start Time", item.slotStartTime ?? "09:00 AM"),
            buildTableRow("Slot End Time", item.slotEndTime ?? "10:00 AM")
          ]);
        }
      }
    }
  }

  TableRow buildTableRow(String label, String value) {
    return TableRow(
      children: [
        _buildTableCell(label, alignment: TextAlign.left, color: kHeadingColor),
        _buildTableCell(':', alignment: TextAlign.left),
        _buildTableCell(value, alignment: TextAlign.left),
      ],
    );
  }

  TableCell _buildTableCell(String text,
      {TextAlign alignment = TextAlign.center, Color color = kblack}) {
    return TableCell(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        child: Text(
          text,
          textAlign: alignment,
          style: TextStyle(
            height: 2,
            fontWeight: color != kblack ? FontWeight.w600 : FontWeight.normal,
            fontSize: 12.sp,
            color: color,
          ),
        ),
      ),
    );
  }

  Future resonseapi(String orderId, String customerId) async {
    try {
      await ApiService.sendBookingNotification(customerId, orderid);
    } catch (e) {
      print(e);
    }
  }
}
