import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/components/show_loader.dart';
import 'package:tidapartners/app/data/models/details_model.dart';
import 'package:tidapartners/app/modules/profile/widgets/product_card.dart';
import 'package:tidapartners/app/routes/app_pages.dart';
import 'package:tidapartners/utils/colors.dart';
import '../../../../utils/common_utils.dart';
import '../controllers/profile_controller.dart';
import '../widgets/booknow_package.dart';
import '../widgets/contact_bar.dart';
import '../widgets/profile_bar.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            body: controller.isLoading
                ? ShowLoader()
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => ProfileBar(
                                name: controller.name.value,
                                job: controller.job.value,
                                location: controller.location.value.toString(),
                                onEditPressed: () {},
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('My Academies',
                                    style: TextStyle(fontSize: 16.sp)),
                                GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppPages.ACADEMY_LISTING);
                                    },
                                    child: Text("view all"))
                              ],
                            ),
                          ),
                          Container(
                            height: (controller.academyDataModel.data != null
                                    ? controller.academyDataModel.data!.data
                                            ?.length ??
                                        1
                                    : 1) *
                                100.h,
                            child: controller.academyDataModel.data != null
                                ? ListView.builder(
                                    itemCount: controller
                                        .academyDataModel.data!.data?.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ProductCard(
                                          onPressed: () {
                                            if (controller
                                                    .academyDataModel.data !=
                                                null) {
                                              Get.toNamed(
                                                  AppPages.ACADEMY_DETAILS,
                                                  arguments: {
                                                    "data": controller
                                                        .academyDataModel
                                                        .data
                                                        ?.data?[index]
                                                  });
                                            } else {
                                              print("------------");
                                            }
                                          },
                                          data: DetailsModel(
                                              imagePath: controller
                                                      .academyDataModel
                                                      .data
                                                      ?.data?[index]
                                                      .image ??
                                                  "https://tidasports.com/wp-content/uploads/2024/03/0314image_cropper_1690367587525.jpg",
                                              name: controller
                                                      .academyDataModel
                                                      .data
                                                      ?.data?[index]
                                                      .title ??
                                                  "Igniation Football",
                                              location: controller
                                                      .academyDataModel
                                                      .data
                                                      ?.data?[index]
                                                      .address ??
                                                  "Shivjot Enclave",
                                              noOfBookings: 0, customerName: ""));
                                    })
                                : Center(child: Text("No Academies")),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('My Venues',
                                    style: TextStyle(fontSize: 16)),
                                GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppPages.VENUE_LISTING);
                                    },
                                    child: Text("view all"))
                              ],
                            ),
                          ),
                          Container(
                            height: (controller.venueModel.data != null
                                    ? controller.venueModel.data!.data?.length
                                    : 1)! *
                                100.h,
                            child: controller.venueModel.data == null
                                ? Center(child: Text("No Venues"))
                                : controller.venueModel.data!.data!.isEmpty
                                    ? Center(child: Text("No Venues"))
                                    : ListView.builder(
                                        itemCount:
                                            controller.venueModel.data != null
                                                ? controller.venueModel.data!
                                                    .data?.length
                                                : 0,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return ProductCard(
                                              onPressed: () {
                                                if (controller
                                                        .venueModel.data !=
                                                    null) {
                                                  Get.toNamed(
                                                      AppPages.VENUE_DETAILS,
                                                      arguments: {
                                                        "data": controller
                                                            .venueModel
                                                            .data
                                                            ?.data?[index]
                                                      });
                                                } else {
                                                  print("------------");
                                                }
                                              },
                                              data: DetailsModel(
                                                  imagePath: controller
                                                          .venueModel
                                                          .data
                                                          ?.data?[index]
                                                          .image ??
                                                      "https://tidasports.com/wp-content/uploads/2024/03/0314image_cropper_1690367587525.jpg",
                                                  name: controller
                                                          .venueModel
                                                          .data
                                                          ?.data?[index]
                                                          .title ??
                                                      "Igniation Football",
                                                  location: controller
                                                          .venueModel
                                                          .data
                                                          ?.data?[index]
                                                          .address ??
                                                      "Shivjot Enclave",
                                                  noOfBookings: 0, customerName: ""));
                                        }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.dg),
                            child: ListTile(
                              title: Text(
                                "Enable Cash",
                                style: TextStyle(fontSize: 17.sp),
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: kPrimaryColor.withAlpha(40)),
                                  borderRadius: BorderRadius.circular(10.r)),
                              trailing: Switch(
                                thumbIcon: controller.thumbIcon,
                                value: controller.light0,
                                activeColor: kPrimaryColor,
                                onChanged: (bool value) {
                                  controller.updatecashmode();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          BookNow(
                            function: () {
                              launchurl(Uri.parse(
                                  'https://tidasports.com/my-account/partner-slots/?mode=mobile'));
                            },
                            name: 'Disable Slot',
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ContactBar(
                            text: 'Have a question? Call us',
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
