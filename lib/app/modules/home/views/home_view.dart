import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/components/drawer.dart';
import 'package:tidapartners/app/components/show_loader.dart';
import 'package:tidapartners/app/modules/home/controllers/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:tidapartners/app/routes/app_pages.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/image_locations.dart';
import '../../../data/local/my_shared_pref.dart';
import '../widgets/booking_widget.dart';

import '../widgets/details_widget.dart';
import '../widgets/filter_widget.dart';
import '../widgets/side_heading.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: kWhiteColor),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: ImageIcon(AssetImage(AppImages.menubar)),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              centerTitle: false,
              backgroundColor: kPrimaryColor,
              title: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: "Hey, ",
                    style:  TextStyle(
                      color: kWhiteColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  TextSpan(
                    text: "${MySharedPref.getName()}",
                    style:  TextStyle(
                        color: kWhiteColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold),
                  )
                ]),
              ),
              actions: [
                IconButton(
                  icon: ImageIcon(AssetImage(
                    AppImages.filterImage,
                  )),
                  onPressed: () {
                    controller.updateFilter();
                  },
                ),
              ],
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
            ),
            drawer: SideDrawer(),
            body: controller.isLoading ? ShowLoader() : ListView(padding: EdgeInsets.all(16.dg), children: [
               SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SideHeadingWidget(name: 'No. of Bookings'),
                  Container(
                    margin: EdgeInsets.all(2.dg),
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                        border: Border.all(color: kGreySecondaryColor),
                        borderRadius: BorderRadius.circular(5.r)),
                    child: Row(
                      children: [
                        Text(
                          DateFormat("dd-MM-yyyy").format(
                              controller.selectedStartDate),
                          style: TextStyle(
                              fontSize: 10.sp, color: kGreySecondaryColor),
                        ),
                        Text(" to ",
                            style: TextStyle(
                                fontSize: 10.sp, color: kGreySecondaryColor)),
                        Text(
                          DateFormat("dd-MM-yyyy").format(
                              controller.selectedEndDate),
                          style: TextStyle(
                              fontSize: 10.sp, color: kGreySecondaryColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
               SizedBox(height: 10.h),
              Row(
                children: [
                  BookingWidget(
                    image: ImageLocations.bookingImage,
                    name: 'Bookings',
                    number: controller.bookingOrdersModel.totalOrders ?? 1,
                    color: Colors.yellow.shade100,
                  ),
                  BookingWidget(
                    image: ImageLocations.subscriptionsImage,
                    name: 'Subscriptions',
                    number: controller.subscriptionOrdersModel.totalOrders ?? 1,
                    color: Colors.grey.shade100,
                  ),
                  BookingWidget(
                    image: ImageLocations.slotsImage,
                    name: 'Slots',
                    number: controller.venueOrdersModel.totalOrders ?? 1,
                    color: Colors.blue.shade100,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              SideHeadingWidget(name: 'Bookings'),
              SizedBox(height: 10.h),
             controller.bookingsDetailsList.isEmpty ? Center(child: Text("No Bookings")) : ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: controller.bookingsDetailsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
                        "detailname": "booking",
                        "data": controller.bookingOrdersModel.data?[index]
                      });
                    },
                    child: DetailsWidget(
                        backgroundColor: Colors.grey.shade100,
                        data: controller.bookingsDetailsList[index]),
                  );
                }),
              ),
              const Divider(color: kGreyColor),
              SizedBox(height: 10.h),
              SideHeadingWidget(name: 'Subscriptions'),
              SizedBox(height: 10.h),
             controller.subscriptionDetailsList.isEmpty ? Center(child: Text("No Subscriptions")) : ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: controller.subscriptionDetailsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
                        "detailname": "subscription",
                        "data": controller.subscriptionOrdersModel.data?[index]
                      });
                    },
                    child: DetailsWidget(
                        backgroundColor: Colors.grey.shade100,
                        data: controller.subscriptionDetailsList[index]),
                  );
                }),
              ),
              const Divider(color: kGreyColor),
               SizedBox(height: 10.h),
              SideHeadingWidget(name: 'Slots/Venues'),
               SizedBox(height: 10.h),
             controller.slotsDetailsList.isEmpty ? Center(child: Text("No Slots Booked")) : ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: controller.slotsDetailsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
                        "detailname": "slots",
                        "data": controller.venueOrdersModel.data?[index]
                      });
                    },
                    child: DetailsWidget(
                        backgroundColor: Colors.grey.shade100,
                        data: controller.slotsDetailsList[index]),
                  );
                }),
              ),
              const Divider(color: kGreyColor),
             SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.all(10.dg),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Total Bookings',
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      controller.totalOrders.toString(),
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
               SizedBox(height: 100.h),
            ]),
          );
        });
  }
}
