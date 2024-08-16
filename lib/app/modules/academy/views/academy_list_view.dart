import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/components/show_loader.dart';
import 'package:tidapartners/app/modules/academy/controllers/academy_list_controller.dart';

import '../../../../utils/colors.dart';
import '../../../data/models/details_model.dart';
import '../../../routes/app_pages.dart';
import '../../profile/widgets/product_card.dart';

class AcademyListView extends StatelessWidget {
  const AcademyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcademyListController>(
        init: AcademyListController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: kWhiteColor),
              toolbarHeight: Get.height / 12,
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              title: Text(
                "Academies",
                style: const TextStyle(
                    color: kWhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            body: controller.isLoading.value ? ShowLoader() : controller.academyDataModel.data != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.academyDataModel.data != null) {
                            Get.toNamed(AppPages.ACADEMY_DETAILS, arguments: {
                              "data":
                                  controller.academyDataModel.data?.data?[index]
                            });
                          } else {
                            print("------------");
                          }
                        },
                        child: ProductCard(
                            data: DetailsModel(
                                imagePath: controller.academyDataModel.data
                                        ?.data?[index].image ??
                                    "https://tidasports.com/wp-content/uploads/2024/03/0314image_cropper_1690367587525.jpg",
                                name: controller.academyDataModel.data
                                        ?.data?[index].title ??
                                    "Igniation Football",
                                location: controller.academyDataModel.data
                                        ?.data?[index].address ??
                                    "Shivjot Enclave",
                                noOfBookings: 0, customerName: controller.academyDataModel.data
                                        ?.data?[index].headCoach ?? "No Data")),
                      );
                    },
                    itemCount: controller.academyDataModel.data?.data?.length,
                  )
                : Center(child: Text("No Academies")),
                bottomNavigationBar: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.pageingnumb >= 2
                    ? Padding(
                        padding: EdgeInsets.all(16.0.h),
                        child: GestureDetector(
                          onTap: () {
                            controller
                                .getAcademies((--controller.pageingnumb));
                          },
                          child: Text(
                            "Previous Page",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: kPrimaryColor),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                controller.pageingnumb < controller.maxpage
                    ? Padding(
                        padding: EdgeInsets.all(16.0.h),
                        child: GestureDetector(
                          onTap: () {
                            controller
                                .getAcademies((++controller.pageingnumb));
                          },
                          child: Text(
                            "Next Page",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: kPrimaryColor),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          );
        });
  }
}
