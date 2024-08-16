import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tidapartners/app/components/show_loader.dart';
import 'package:tidapartners/app/modules/orders_listing/controller/orders_listing_controller.dart';

import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';
import '../../home/widgets/details_widget.dart';

class OrdersListingView extends StatelessWidget {
  const OrdersListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersListingController>(
      init: OrdersListingController(),
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
                  text: controller.ordertype.capitalize,
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
          body: controller.isLoading.value
              ? ShowLoader()
              : ListView(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    searchbar(),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10.dg),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (controller.ordertype == "Bookings") {
                              Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
                                "detailname": "booking",
                                "data":
                                    controller.bookingOrdersModel.data?[index]
                              });
                            } else if (controller.ordertype ==
                                "Subscriptions") {
                              Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
                                "detailname": "subscription",
                                "data": controller
                                    .subscriptionOrdersModel.data?[index]
                              });
                            } else {
                              Get.toNamed(AppPages.DETAILS_SCREEN, arguments: {
                                "detailname": "slots",
                                "data": controller.venueOrdersModel.data?[index]
                              });
                            }
                          },
                          child: DetailsWidget(
                              backgroundColor: Colors.grey.shade100,
                              data: controller.ordersList[index]),
                        );
                      },
                      itemCount: controller.ordersList.length,
                    ),
                  ],
                ),
          bottomNavigationBar: controller.isLoading.value
              ? SizedBox.shrink()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.pageingnumb >= 2
                        ? Padding(
                            padding: EdgeInsets.all(16.0.h),
                            child: GestureDetector(
                              onTap: () {
                                controller
                                    .fetchOrders((--controller.pageingnumb));
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
                                    .fetchOrders((++controller.pageingnumb));
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
      },
    );
  }

  Widget searchbar() {
    return GetBuilder<OrdersListingController>(
        init: OrdersListingController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width / 20, vertical: Get.height / 80),
            child: TextFormField(
              controller: controller.searchController,
              onEditingComplete: () async {
                await controller.fetchOrders(controller.pageingnumb);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: kGreyColor, width: 0.1),
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 25.sp,
                    color: kGreyColor,
                  ),
                ),
                hintText: "Search ${controller.ordertype}",
              ),
            ),
          );
        });
  }
}
