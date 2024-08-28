import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/upcoming_subscription_models.dart' as subscription;
import '../models/upcoming_booking_models.dart' as venue;

import '../../../../utils/colors.dart';
import '../../../data/remote/api_service.dart';
import '../../home/models/booking_orders_model.dart' as booking;

class UpcomingDetailsController extends GetxController {
  RxString detailname = "".obs;
  List<TableRow> rows1 = List.empty(growable: true);
  List<List<TableRow>> rows2 = List.empty(growable: true);
  venue.Data venueOrdersModel = venue.Data();
  subscription.Data subscriptionOrdersModel = subscription.Data();
  booking.Data bookingOrdersModel = booking.Data();
  TextEditingController personnamectrl = TextEditingController();
  String orderid = "";
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    detailname.value = Get.arguments["detailname"];
    update();
    if (detailname.value == "booking") {
      bookingOrdersModel = Get.arguments["data"];
      bookingDetails();
      orderid = bookingOrdersModel.id.toString();
      update();
    } else if (detailname.value == "subscription") {
      subscriptionOrdersModel = Get.arguments["data"];
      subscriptionDetails();
      orderid = subscriptionOrdersModel.id.toString();
      update();
    } else {
      venueOrdersModel = Get.arguments["data"];
      venueDetails();
      orderid = venueOrdersModel.orderId.toString();
      update();
    }
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
    // Map<String, dynamic> ordernotesdata = {"note": personnamectrl.text};
    // Map resi = await ApiService().createOrdernotes(ordernotesdata, orderid);
    Map result = await ApiService().updateOrder({
      "status": status,
      "payment_method": "bank",
      "payment_method_title": "COD Payment"
    }, orderid);
    print(result);
    if (detailname.value == "booking") {
      bookingOrdersModel.status = status;
      await resonseapi(orderid, bookingOrdersModel.customer!.id.toString());
      update();
    } else if (detailname.value == "subscription") {
      subscriptionOrdersModel.status = status;
      await resonseapi(
          orderid, subscriptionOrdersModel.customer!.id.toString());
      update();
    } else {
      venueOrdersModel.status = status;
      await resonseapi(orderid, venueOrdersModel.customer!.id.toString());
      update();
    }
    Get.back();
    isLoading(false);
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
  }

  void bookingDetails() {
    rows1.add(buildTableRow("Booking ID", bookingOrdersModel.id.toString()));
    rows1.add(buildTableRow(
        "Booking Status", bookingOrdersModel.status ?? "Pending"));
    rows1.add(buildTableRow(
        "Customer Name", bookingOrdersModel.customer?.firstName ?? "Harsh"));
    rows1.add(buildTableRow("Phone Number",
        bookingOrdersModel.customer?.phone ?? "+91 9353478558"));
    for (booking.Items item in bookingOrdersModel.items ?? []) {
      rows2.add([
        buildTableRow(
            "Transaction ID",
            bookingOrdersModel.transactionId!.isNotEmpty
                ? bookingOrdersModel.transactionId ?? "Cash"
                : "Cash"),
        // buildTableRow(
        //     "Transaction Type",
        //     bookingOrdersModel.transactionId != null
        //         ? bookingOrdersModel.transactionId!.isNotEmpty
        //             ? "Online"
        //             : "Offline"
        //         : "Offline"),
        // if (bookingOrdersModel.total != null)
        //   buildTableRow("Total Amount", "₹ ${bookingOrdersModel.total ?? 499}"),
        if (bookingOrdersModel.total != null)
          buildTableRow("Bill Amount",
              "₹ ${bookingOrdersModel.totalDiscountedAmount != null ? bookingOrdersModel.totalDiscountedAmount : bookingOrdersModel.total}"),
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
        buildTableRow("Order ID", subscriptionOrdersModel.id.toString()));
    rows1.add(buildTableRow(
        "Booking Status", subscriptionOrdersModel.status ?? "Pending"));
    rows1.add(buildTableRow("Customer Name",
        subscriptionOrdersModel.items?[0].personName ?? "Harsh"));
    rows1.add(buildTableRow(
        "Phone Number", subscriptionOrdersModel.customer?.phone ?? "No Data"));

    for (subscription.Items item in subscriptionOrdersModel.items ?? []) {
      rows2.add([
        if(subscriptionOrdersModel.transactionId != null && subscriptionOrdersModel.transactionId!.isNotEmpty )
        buildTableRow(
            "Transaction ID",
            subscriptionOrdersModel.transactionId!.isNotEmpty
                ? subscriptionOrdersModel.transactionId ?? "Cash"
                : "Cash"),
        buildTableRow(
            "Transaction Type",
            subscriptionOrdersModel.transactionId != null
                ? subscriptionOrdersModel.transactionId!.isNotEmpty
                    ? "Online"
                    : "Offline"
                : "Offline"),
        if (subscriptionOrdersModel.total != null)
          buildTableRow("Bill Amount",
              "₹ ${subscriptionOrdersModel.totalDiscountedAmount != null ? subscriptionOrdersModel.totalDiscountedAmount : subscriptionOrdersModel.total ?? 499}"),
        // if (subscriptionOrdersModel.totalDiscountedAmount != null)
        // buildTableRow("Bill Amount",
        // "₹ ${subscriptionOrdersModel.totalDiscountedAmount ?? 499}"),
        buildTableRow("Booking Date",
            subscriptionOrdersModel.createdDate?.date ?? "No Data"),
        buildTableRow("Academy Name", item.academyName ?? "No data"),
        buildTableRow("Academy Address", item.academyAddress ?? "No data"),
        buildTableRow("Package Name", item.packageName ?? "Welcome Plan"),
        buildTableRow("Package Amount", "₹ ${item.packageAmount ?? 499}"),
        buildTableRow('Subscription Start Date',
            subscriptionOrdersModel.subscriptions?[0].start ?? "No Data"),
        buildTableRow("Next Renewal",
            subscriptionOrdersModel.subscriptions?[0].nextPayment ?? "No Data"),
      ]);
    }
  }

  void venueDetails() {
    rows1.add(buildTableRow("Order ID", venueOrdersModel.orderId.toString()));
    rows1.add(buildTableRow("Booking ID", venueOrdersModel.bookingId.toString()));
    rows1.add(
        buildTableRow("Booking Status", venueOrdersModel.status ?? "Pending"));
    rows1.add(buildTableRow(
        "Customer Name",
        venueOrdersModel.slot?.item?.personName != "No Data"
            ? venueOrdersModel.slot?.item?.personName ?? "No Data"
            : venueOrdersModel.customer?.name ?? "No Data"));
    rows1.add(buildTableRow(
        "Phone Number", venueOrdersModel.customer?.phone ?? "No Data"));
    rows1.add(buildTableRow(
        "Transaction Type",
        venueOrdersModel.transactionId != null
            ? venueOrdersModel.transactionId!.isNotEmpty
                ? "Online"
                : "Online"
            : "Online"));

    rows1.add(buildTableRow(
        "Transaction ID",
        venueOrdersModel.transactionId != ""
            ? venueOrdersModel.transactionId ?? "No Data"
            : "No Data"));
    // if (venueOrdersModel.bookingAmount != null)
    //   rows1.add(buildTableRow(
    //       "Total Amount", "₹ ${venueOrdersModel.bookingAmount.toString()}"));
    if (venueOrdersModel.orderTotal != null)
      rows1.add(buildTableRow(
          "Bill Amount", "₹ ${venueOrdersModel.bookingAmount != null ? venueOrdersModel.bookingAmount : venueOrdersModel.orderTotal.toString()}"));
    if (venueOrdersModel.orderTotalDiscountedAmount != null)
      rows1.add(buildTableRow("Bill Amount",
          "₹ ${venueOrdersModel.orderTotalDiscountedAmount.toString()}"));
    if (venueOrdersModel.orderItems != null)
      rows1.add(buildTableRow("No. of Slots in Order",
          "${venueOrdersModel.orderItems.toString()}"));
    rows1.add(buildTableRow(
        "Booking Date",
        DateFormat('yyyy-MMM-dd').format(
            DateTime.parse(venueOrdersModel.createdDate!.date.toString()))));
    rows1.add(buildTableRow(
        "Venue Name", venueOrdersModel.slot?.item?.name ?? "No data"));
    rows1.add(buildTableRow(
        "Venue Address", venueOrdersModel.slot?.item?.address ?? "No data"));
    rows1.add(buildTableRow(
        "Slot Amount", " ₹ ${venueOrdersModel.slot?.slotAmount ?? 499}"));

    rows1.add(buildTableRow("Slot Start Time",
        "${venueOrdersModel.slot!.slotStartDate ?? ""}  ${venueOrdersModel.slot?.slotStartTime ?? "No data"}"));
    rows1.add(buildTableRow("Slot End Time",
        "${venueOrdersModel.slot!.slotEndDate ?? ""}  ${venueOrdersModel.slot?.slotEndTime ?? "No data"}"));
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
    await ApiService.sendBookingNotification(customerId, "");
  } catch (e) {
    print(e);
  }
}
