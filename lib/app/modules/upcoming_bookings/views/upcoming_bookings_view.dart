import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/components/show_loader.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/upcoming_bookings_controller.dart';
import '../widgets/details_widget.dart';

class UpcomingBookingsView extends StatelessWidget {
  const UpcomingBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: UpcomingBookingsController(),
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: kWhiteColor),
                toolbarHeight: Get.height / 12,
                centerTitle: true,
                backgroundColor: kPrimaryColor,
                title: Text(
                  "Upcoming Bookings",
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      controller.updateFilter();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kPrimaryColor),
                      child: ImageIcon(
                        AssetImage(
                          AppImages.filterImage,
                        ),
                        size: 18.sp,
                        color: kWhiteColor,
                      ),
                    ),
                  ),
                ],
                bottom: TabBar(
                  indicatorColor: kWhiteColor,
                  indicatorWeight: 5.0,
                  dividerColor: Colors.white,
                  unselectedLabelColor: kGreyColor,
                  labelColor: kWhiteColor,
                  tabs: [
                    Tab(
                      child: Center(
                        child: Text(
                          "Slot Bookings",
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          "Subscriptions",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                upcomingBookings(controller),
                upcomingSubscripitions(controller)
              ]),
            ),
          );
        });
  }

  Widget upcomingBookings(UpcomingBookingsController controller) {
    return controller.isLoading.value
        ? ShowLoader()
        : controller.hasData.value == false
            ? Center(child: Text("No Upcoming Bookings Currently"))
            : ListView(
                shrinkWrap: true,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.bookingsDetailsList.length,
                      itemBuilder: (context, index) {
                        return DetailsWidget(
                          backgroundColor: Colors.grey.shade100,
                          data: controller.bookingsDetailsList[index],
                          viewDetails: () {
                            Get.toNamed(AppPages.UPCOMING_DETAILS_SCREEN,
                                arguments: {
                                  "detailname": "slots",
                                  "data": controller
                                      .upcomingBookingsModel.data?[index]
                                });
                          },
                        );
                      }),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.pageingnumb >= 2
                            ? Padding(
                                padding: EdgeInsets.all(16.0.dg),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.getBookingOrders(
                                        (--controller.pageingnumb));
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
                        controller.pageingnumb < controller.maxpageBookings
                            ? Padding(
                                padding: EdgeInsets.all(16.0.dg),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.getBookingOrders(
                                        (++controller.pageingnumb));
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
                      ])
                ],
              );
  }

  Widget upcomingSubscripitions(UpcomingBookingsController controller) {
    return controller.isLoading.value
        ? ShowLoader()
        : controller.hasDataSub.value == false
            ? Center(
                child: Text("No Upcoming Subscriptions Renewals Currently"))
            : ListView(
                shrinkWrap: true,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.subscriptionDetailsList.length,
                      itemBuilder: (context, index) {
                        return DetailsWidget(
                          backgroundColor: Colors.grey.shade100,
                          data: controller.subscriptionDetailsList[index],
                          subscri: true,
                          viewDetails: () {
                            Get.toNamed(AppPages.UPCOMING_DETAILS_SCREEN,
                                arguments: {
                                  "detailname": "subscription",
                                  "data": controller
                                      .upcomingSubscriptionModel.data?[index]
                                });
                          },
                        );
                      }),
                  Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.pageingnumbSubscription >= 2
                            ? Padding(
                                padding: EdgeInsets.all(16.0.dg),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.getSubscriptionOrders(
                                        (--controller.pageingnumbSubscription));
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
                        controller.pageingnumbSubscription <
                                controller.maxpageSubscription
                            ? Padding(
                                padding: EdgeInsets.all(16.0.dg),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.getSubscriptionOrders(
                                        (++controller.pageingnumbSubscription));
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
                      ])
                ],
              );
  }
}
