import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/modules/venues/controllers/venue_list_controller.dart';

import '../../../../utils/colors.dart';
import '../../../components/show_loader.dart';
import '../../../data/models/details_model.dart';
import '../../../routes/app_pages.dart';
import '../../profile/widgets/product_card.dart';

class VenueListView extends StatelessWidget {
  const VenueListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VenueListController>(
        init: VenueListController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: kWhiteColor),
              toolbarHeight: Get.height / 12,
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              title: Text(
                "Venues",
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
            body: controller.isLoading.value ? ShowLoader() : controller.venueModel.data != null ? ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (controller.venueModel.data != null) {
                      Get.toNamed(AppPages.VENUE_DETAILS, arguments: {
                        "data": controller.venueModel.data?.data?[index]
                      });
                    } else {
                      print("------------");
                    }
                  },
                  child: ProductCard(
                      data: DetailsModel(
                          imagePath: controller
                                  .venueModel.data?.data?[index].image ??
                              "https://tidasports.com/wp-content/uploads/2024/03/0314image_cropper_1690367587525.jpg",
                          name:
                              controller.venueModel.data?.data?[index].title ??
                                  "Igniation Football",
                          location: controller
                                  .venueModel.data?.data?[index].address ??
                              "Shivjot Enclave",
                          noOfBookings: 0)),
                );
              },
              itemCount: controller.venueModel.data?.data?.length,
            ) : Center(child: Text("No Venues")),

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
                                .getVenues((--controller.pageingnumb));
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
                                .getVenues((++controller.pageingnumb));
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
