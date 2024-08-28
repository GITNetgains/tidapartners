import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import '../widgets/side_heading.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
                centerTitle: false,
                backgroundColor: kPrimaryColor,
                title: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "Hey, ",
                      style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 16.sp,
                      ),
                    ),
                    TextSpan(
                      text: "${MySharedPref.getName()}",
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ]),
                ),
                actions: [],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                ),
              ),
              drawer: SideDrawer(),
              body: controller.isLoading
                  ? ShowLoader()
                  : RefreshIndicator(
                      onRefresh: () {
                        return controller.filterorders();
                      },
                      child: ListView(
                          padding: EdgeInsets.symmetric(vertical: 16.dg),
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.dg),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SideHeadingWidget(
                                        name: 'Bookings :',
                                        fontSize: 20,
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(2.dg),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        decoration: BoxDecoration(
                                            // border: Border.all(
                                            //     color: kGreySecondaryColor),
                                            borderRadius:
                                                BorderRadius.circular(5.r)),
                                        child: Row(
                                          children: [
                                            Text(
                                              DateFormat("dd-MM-yyyy").format(
                                                  controller.selectedStartDate),
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: kGreySecondaryColor),
                                            ),
                                            Text(" to ",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color:
                                                        kGreySecondaryColor)),
                                            Text(
                                              DateFormat("dd-MM-yyyy").format(
                                                  controller.selectedEndDate),
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: kGreySecondaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.updateFilter();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: kPrimaryColor),
                                      child: ImageIcon(
                                        AssetImage(
                                          AppImages.filterImage,
                                        ),
                                        size: 16.sp,
                                        color: kWhiteColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.dg),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: kblack.withAlpha(150), width: 2),
                                ),
                                child: Row(
                                  children: [
                                    BookingWidget(
                                      image: ImageLocations.bookingImage,
                                      name: 'Bookings',
                                      number: controller
                                              .totalBookingsOrdersValue.value ??
                                          1,
                                      color: Colors.yellow.shade100,
                                    ),
                                    BookingWidget(
                                      image: ImageLocations.subscriptionsImage,
                                      name: 'Subscriptions',
                                      number: controller
                                              .totalSubscriptionOrderValue
                                              .value ??
                                          1,
                                      color: Colors.grey.shade100,
                                    ),
                                    BookingWidget(
                                      image: ImageLocations.slotsImage,
                                      name: 'Slots',
                                      number: (controller
                                              .totalSlotOrdersValue.value) ??
                                          1,
                                      color: Colors.blue.shade100,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            controller.totalOrders.value +
                                        controller.totalOrdersPending.value >
                                    0
                                ? Padding(
                                    padding: EdgeInsets.all(10.0.dg),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: kSettleColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.dg, vertical: 8.dg),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total Bookings',
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            (controller.totalOrders.value +
                                                    controller
                                                        .totalOrdersPending
                                                        .value)
                                                .toString(),
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontSize: 35.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox.shrink(),
                            SizedBox(height: 10.h),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.dg),
                                    padding: EdgeInsets.only(top: 2.dg),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            topRight: Radius.circular(10.r)),
                                        border: Border(
                                          top: BorderSide(
                                              color: kblack.withAlpha(150),
                                              width: 2),
                                          left: BorderSide(
                                              color: kblack.withAlpha(150),
                                              width: 2),
                                          right: BorderSide(
                                              color: kblack.withAlpha(150),
                                              width: 2),
                                        ),
                                        gradient: LinearGradient(colors: [
                                          Colors.yellow.shade100,
                                          Colors.blue.shade100
                                        ], stops: [
                                          0.5,
                                          1
                                        ])),
                                    child: TabBar(
                                      controller: _tabController,
                                      tabs: [
                                        Tab(
                                          child: Container(
                                            width: Get.width * 0.5,
                                            height: 60.h,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Successful",
                                              style: TextStyle(
                                                  color: kHeadingColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Container(
                                            width: Get.width * 0.5,
                                            height: 60.h,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Pending",
                                              style: TextStyle(
                                                  color: kHeadingColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r)),
                                      border: Border(
                                        bottom: BorderSide(
                                            color: kblack.withAlpha(150),
                                            width: 2),
                                        left: BorderSide(
                                            color: kblack.withAlpha(150),
                                            width: 2),
                                        right: BorderSide(
                                            color: kblack.withAlpha(150),
                                            width: 2),
                                      ),
                                    ),
                                    height: max(
                                        controller
                                            .displayOrdersSucessfull.value,
                                        controller.displayOrdersPending.value),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.dg),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.dg),
                                    child: TabBarView(
                                        physics: NeverScrollableScrollPhysics(),
                                        controller: _tabController,
                                        children: [
                                          OrdersListProtoType(controller),
                                          OrdersListProtoTypePending(
                                              controller),
                                        ]),
                                  )
                                ],
                              ),
                            ),
                          ]),
                    ));
        });
  }

  Widget OrdersListProtoType(HomeController controller) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        SideHeadingWidget(
          name: 'Bookings',
          onTap: () {
            Get.toNamed(AppPages.ORDERS_LISTING, arguments: {
              "order_type": "Bookings",
              "start_date": controller.startdate,
              "end_date": controller.enddate,
              "status": controller.status.value
            });
          },
          view: controller.bookingsDetailsList.isEmpty ? false : true,
        ),
        SizedBox(height: 10.h),
        controller.bookingsDetailsList.isEmpty
            ? Container(height: 60.h, child: Center(child: Text("No Bookings")))
            : ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: controller.bookingsDetailsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.offNamed(AppPages.DETAILS_SCREEN, arguments: {
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
        SideHeadingWidget(
          name: 'Subscriptions',
          onTap: () {
            Get.toNamed(AppPages.ORDERS_LISTING, arguments: {
              "order_type": "Subscriptions",
              "start_date": controller.startdate,
              "end_date": controller.enddate,
              "status": controller.status.value
            });
          },
          view: controller.subscriptionDetailsList.isEmpty ? false : true,
        ),
        SizedBox(height: 10.h),
        controller.subscriptionDetailsList.isEmpty
            ? Container(
                height: 60.h, child: Center(child: Text("No Subscriptions")))
            : ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: controller.subscriptionDetailsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.offNamed(AppPages.DETAILS_SCREEN, arguments: {
                        "detailname": "subscription",
                        "data": controller.subscriptionOrdersModel.data?[index],
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
        SideHeadingWidget(
          name: 'Slots/Venues',
          onTap: () {
            Get.toNamed(AppPages.ORDERS_LISTING, arguments: {
              "order_type": "Slots/Venues",
              "start_date": controller.startdate,
              "end_date": controller.enddate,
              "status": controller.status.value
            });
          },
          view: controller.slotsDetailsList.isEmpty ? false : true,
        ),
        SizedBox(height: 10.h),
        controller.slotsDetailsList.isEmpty
            ? Container(
                height: 60.h, child: Center(child: Text("No Slots Booked")))
            : ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: controller.slotsDetailsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.offNamed(AppPages.DETAILS_SCREEN, arguments: {
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
      ],
    );
  }

  Widget OrdersListProtoTypePending(HomeController controller) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        SideHeadingWidget(
          name: 'Bookings',
          onTap: () {
            Get.toNamed(AppPages.ORDERS_LISTING, arguments: {
              "order_type": "Bookings",
              "start_date": controller.startdate,
              "end_date": controller.enddate,
              "status": "pending"
            });
          },
          view: controller.bookingsDetailsListPending.isEmpty ? false : true,
        ),
        SizedBox(height: 10.h),
        controller.bookingsDetailsListPending.isEmpty
            ? Container(height: 60.h, child: Center(child: Text("No Bookings")))
            : ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: controller.bookingsDetailsListPending.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.offNamed(AppPages.DETAILS_SCREEN, arguments: {
                        "detailname": "booking",
                        "data":
                            controller.bookingOrdersModelPending.data?[index]
                      });
                    },
                    child: DetailsWidget(
                        backgroundColor: Colors.grey.shade100,
                        data: controller.bookingsDetailsListPending[index]),
                  );
                }),
              ),
        const Divider(color: kGreyColor),
        SizedBox(height: 10.h),
        SideHeadingWidget(
          name: 'Subscriptions',
          onTap: () {
            Get.toNamed(AppPages.ORDERS_LISTING, arguments: {
              "order_type": "Subscriptions",
              "start_date": controller.startdate,
              "end_date": controller.enddate,
              "status": "pending"
            });
          },
          view:
              controller.subscriptionDetailsListPending.isEmpty ? false : true,
        ),
        SizedBox(height: 10.h),
        controller.subscriptionDetailsListPending.isEmpty
            ? Container(
                height: 60.h, child: Center(child: Text("No Subscriptions")))
            : ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: controller.subscriptionDetailsListPending.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.offNamed(AppPages.DETAILS_SCREEN, arguments: {
                        "detailname": "subscription",
                        "data": controller
                            .subscriptionOrdersModelPending.data?[index],
                      });
                    },
                    child: DetailsWidget(
                        backgroundColor: Colors.grey.shade100,
                        data: controller.subscriptionDetailsListPending[index]),
                  );
                }),
              ),
        const Divider(color: kGreyColor),
        SizedBox(height: 10.h),
        SideHeadingWidget(
          name: 'Slots/Venues',
          onTap: () {
            Get.toNamed(AppPages.ORDERS_LISTING, arguments: {
              "order_type": "Slots/Venues",
              "start_date": controller.startdate,
              "end_date": controller.enddate,
              "status": "pending"
            });
          },
          view: controller.slotsDetailsListPending.isEmpty ? false : true,
        ),
        SizedBox(height: 10.h),
        controller.slotsDetailsListPending.isEmpty
            ? Container(
                height: 60.h, child: Center(child: Text("No Slots Booked")))
            : ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: controller.slotsDetailsListPending.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.offNamed(AppPages.DETAILS_SCREEN, arguments: {
                        "detailname": "slots",
                        "data": controller.venueOrdersModelPending.data?[index]
                      });
                    },
                    child: DetailsWidget(
                        backgroundColor: Colors.grey.shade100,
                        data: controller.slotsDetailsListPending[index]),
                  );
                }),
              ),
      ],
    );
  }
}
