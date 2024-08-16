import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/modules/upcoming_bookings/models/upcoming_model.dart';

import '../../home/widgets/universal_button.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget(
      {super.key,
      required this.backgroundColor,
      required this.data,
      this.subscri = false,
      required this.viewDetails});

  final Color backgroundColor;
  final UpcomingModel data;
  final bool subscri;
  final Function() viewDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        viewDetails();
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.dg),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.dg, vertical: 8.0.dg),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0).dg,
                        child: Image.network(
                          data.imagePath,
                          height: 70,
                          width: 70,
                        ),
                      ),
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
                          subscri
                              ? Text(
                                  "Next Renewal Date: ${data.slotdate}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                )
                              : Text(
                                  "Slot Start Time: ${data.slotdate}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                          Text(
                                  "Customer name: ${data.customerName}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  UniversalButton(
                    name: 'View Details',
                    function: () {
                      viewDetails();
                    },
                    fontSize: 10.sp,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
