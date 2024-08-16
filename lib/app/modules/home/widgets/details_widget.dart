import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/models/details_model.dart';
import 'universal_button.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget(
      {super.key, required this.backgroundColor, required this.data});

  final Color backgroundColor;
  final DetailsModel data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.dg),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.dg, vertical: 8.0.dg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name.length > 25
                      ? "${data.name.substring(0, 23).capitalize}..."
                      : data.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data.location.length > 40
                      ? "${data.location.substring(0, 37).capitalize}..."
                      : data.location,
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  "Customer Name:- ${data.customerName.length > 20 ? "${data.customerName.substring(0, 17)}..." : data.customerName}",
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  data.noOfBookings.toString(),
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UniversalButton(
                  name: 'View Details',
                  function: () {},
                  fontSize: 10.sp,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
