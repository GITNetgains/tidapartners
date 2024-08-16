import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/components/show_loader.dart';
import '../../../../utils/colors.dart';
import '../../details_screen/widgets/contact_bar.dart';
import '../controllers/upcoming_details_controller.dart';

class UpcomingDetailsView extends StatelessWidget {
  const UpcomingDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpcomingDetailsController>(
        init: UpcomingDetailsController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: kWhiteColor),
              toolbarHeight: Get.height / 12,
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              title: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: controller.detailname.value.capitalize,
                    style: const TextStyle(
                        color: kWhiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ]),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            body:controller.isLoading.value ? ShowLoader() : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 10.w),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.black12)),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(0.45),
                            1: FlexColumnWidth(0.05),
                            2: FlexColumnWidth(0.7),
                          },
                          children: controller.rows1,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                      itemCount: controller.rows2.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black12)),
                              child: Table(
                                columnWidths: {
                                  0: FlexColumnWidth(0.45),
                                  1: FlexColumnWidth(0.05),
                                  2: FlexColumnWidth(0.7),
                                },
                                children: controller.rows2[index],
                              ),
                            ),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 40.h,
                  ),
                  
                  ContactBar(text: 'Have a Question? Call Us'),
                ],
              ),
            ) ,
          );
        });
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
            fontWeight: color != kblack ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14.sp,
            color: color,
          ),
        ),
      ),
    );
  }
}
