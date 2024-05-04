import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tidapartners/app/modules/home/controllers/home_controller.dart';
import 'package:tidapartners/utils/colors.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r))),
            child: Column(
              children: [
                RadioListTile(
                    value: 1,
                    title: Text("Today"),
                    groupValue: controller.selectedOption,
                    visualDensity: VisualDensity(vertical: -4),
                    onChanged: (value) {
                      controller.changefilter(value ?? 1);
                    }),
                RadioListTile(
                    value: 2,
                    title: Text("Last 7 days"),
                    groupValue: controller.selectedOption,
                    visualDensity: VisualDensity(vertical: -4),
                    onChanged: (value) {
                      controller.changefilter(value ?? 2);
                    }),
                RadioListTile(
                    value: 3,
                    title: Text("This Month"),
                    groupValue: controller.selectedOption,
                    visualDensity: VisualDensity(vertical: -4),
                    onChanged: (value) {
                      controller.changefilter(value ?? 3);
                    }),
                RadioListTile(
                    value: 4,
                    title: Text("Last Month"),
                    groupValue: controller.selectedOption,
                    visualDensity: VisualDensity(vertical: -4),
                    onChanged: (value) {
                      controller.changefilter(value ?? 4);
                    }),
                RadioListTile(
                    value: 5,
                    title: Text("Custom Range"),
                    isThreeLine: true,
                    subtitle: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.dg),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: kGreySecondaryColor),
                              borderRadius: BorderRadius.circular(5)),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectStartDate(context);
                            },
                            child: Text(
                              DateFormat("dd/MM/yyyy").format(
                                  controller.pickedStartDate),
                              style: TextStyle(
                                  fontSize: 12, color: kGreySecondaryColor),
                            ),
                          ),
                        ),
                        Text("-"),
                        Container(
                          margin: EdgeInsets.all(8.dg),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: kGreySecondaryColor),
                              borderRadius: BorderRadius.circular(5)),
                          child: GestureDetector(
                            onTap: () {
                              controller.selectEndDate(context);
                            },
                            child: Text(
                              DateFormat("dd/MM/yyyy").format(
                                  controller.pickedEndDate),
                              style: TextStyle(
                                  fontSize: 12, color: kGreySecondaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    groupValue: controller.selectedOption,
                    visualDensity: VisualDensity(vertical: -4),
                    onChanged: (value) {
                      controller.changefilter(value ?? 5);
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.dg),
                  child: Divider(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0.h, bottom: 10.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.dg),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text("Cancel",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.dg),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.dg, vertical: 4.dg),
                          decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: GestureDetector(
                            onTap: () {
                              controller.filterorders();
                            },
                            child: Text(
                              "Filter",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
