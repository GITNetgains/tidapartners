import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/modules/home/models/subscription_model.dart'
    as subscription;
import 'package:tidapartners/app/modules/home/models/venue_model.dart' as venue;

import '../../../../utils/colors.dart';
import '../../home/models/booking_orders_model.dart' as booking;

class DetailsController extends GetxController {
  RxString detailname = "".obs;
  List<TableRow> rows1 = List.empty(growable: true);
  List<List<TableRow>> rows2 = List.empty(growable: true);
  venue.Data venueOrdersModel = venue.Data();
  subscription.Data subscriptionOrdersModel = subscription.Data();
  booking.Data bookingOrdersModel = booking.Data();

  @override
  void onInit() {
    detailname.value = Get.arguments["detailname"];
    update();
    if (detailname.value == "booking") {
      bookingOrdersModel = Get.arguments["data"];
      bookingDetails();
    } else if (detailname.value == "subscription") {
      subscriptionOrdersModel = Get.arguments["data"];
      subscriptionDetails();
    } else {
      venueOrdersModel = Get.arguments["data"];
      venueDetails();
    }
    super.onInit();
  }

  void bookingDetails() {
    rows1.add(buildTableRow("Booking ID", bookingOrdersModel.id.toString()));
    rows1.add(buildTableRow(
        "Booking Status", bookingOrdersModel.status ?? "Pending"));
    rows1.add(buildTableRow(
        "Customer Name", bookingOrdersModel.customer?.name ?? "Harsh"));
    rows1.add(buildTableRow("Phone Number",
        bookingOrdersModel.customer?.phone ?? "+91 9353478558"));
    for (booking.Items item in bookingOrdersModel.items ?? []) {
      rows2.add([
        buildTableRow(
            "Transaction ID",bookingOrdersModel.transactionId!.isNotEmpty ?  bookingOrdersModel.transactionId ?? "No Data" : "No Data"),
        buildTableRow(
            "Transaction Type",
            bookingOrdersModel.transactionId != null
                ? bookingOrdersModel.transactionId!.isNotEmpty
                    ? "Online"
                    : "Offline"
                : "Offline"),
        buildTableRow(
            "Booking Date", bookingOrdersModel.createdDate?.date ?? "No Data"),
        buildTableRow("Academy Name", item.academyName ?? "No Data"),
        buildTableRow("Package Name", item.packageName ?? "No Data"),
        buildTableRow("Package Amount", "₹ ${item.packageAmount ?? 499}")
      ]);
    }
  }

  void subscriptionDetails() {
    rows1.add(
        buildTableRow("Booking ID", subscriptionOrdersModel.id.toString()));
    rows1.add(buildTableRow(
        "Booking Status", subscriptionOrdersModel.status ?? "Pending"));
    rows1.add(buildTableRow(
        "Customer Name", subscriptionOrdersModel.customer?.name ?? "Harsh"));
    rows1.add(buildTableRow("Phone Number",
        subscriptionOrdersModel.customer?.phone ?? "+91 9353478338"));

    for (subscription.Items item in subscriptionOrdersModel.items ?? []) {
      rows2.add([
       
        buildTableRow("Transaction ID", subscriptionOrdersModel.transactionId!.isNotEmpty ?
            subscriptionOrdersModel.transactionId ?? "No Data" : "No Data"),
        buildTableRow(
            "Transaction Type",
            subscriptionOrdersModel.transactionId != null
                ? subscriptionOrdersModel.transactionId!.isNotEmpty
                    ? "Online"
                    : "Offline"
                : "Offline"),
        buildTableRow("Booking Date",
            subscriptionOrdersModel.createdDate?.date ?? "No Data"),
        buildTableRow("Academy Name", item.academyName ?? "No data"),
        buildTableRow("Package Name", item.packageName ?? "Welcome Plan"),
        buildTableRow("Package Amount", "₹ ${item.packageAmount ?? 499}"),
        buildTableRow(
            "Next Renewal",
            subscriptionOrdersModel.subscriptions?[0].nextPayment ??
                "27,Feb 2024")
      ]);
    }
  }

  void venueDetails() {
    rows1.add(buildTableRow("Booking ID", venueOrdersModel.id.toString()));
    rows1.add(
        buildTableRow("Booking Status", venueOrdersModel.status ?? "Pending"));
    rows1.add(buildTableRow(
        "Customer Name", venueOrdersModel.customer?.name ?? "No data"));
    rows1.add(buildTableRow(
        "Phone Number", venueOrdersModel.customer?.phone ?? "No Data"));
    rows1.add(buildTableRow(
        "Transaction Type",
        venueOrdersModel.transactionId != null
            ? venueOrdersModel.transactionId!.isNotEmpty
                ? "Online"
                : "Offline"
            : "Offline"));
    if (venueOrdersModel.transactionId != null
        ? venueOrdersModel.transactionId!.isEmpty
        : false) {
      rows1.add(buildTableRow(
          "Transaction ID", venueOrdersModel.transactionId ?? "No Data"));
    }
    rows1.add(buildTableRow(
        "Booking Date", venueOrdersModel.createdDate?.date ?? "No Data"));
    rows1.add(buildTableRow(
        "Venue Name", venueOrdersModel.items?.venue?.name ?? "No data"));
    if (venueOrdersModel.items?.slots != null) {
      if (venueOrdersModel.items!.slots!.isNotEmpty) {
        for (venue.Slots item in venueOrdersModel.items?.slots ?? []) {
          rows2.add([
            buildTableRow("Slot Name", item.slotName ?? "No Data"),
            buildTableRow("Slot Amount", " ₹ ${item.slotAmount ?? 499}"),
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: alignment,
          style: TextStyle(
            height: 2,
            fontWeight: color != kblack ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
            color: color,
          ),
        ),
      ),
    );
  }
}
