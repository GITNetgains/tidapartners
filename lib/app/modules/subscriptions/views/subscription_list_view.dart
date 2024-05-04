import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';
import '../../home/widgets/details_widget.dart';
import '../controllers/subscriptions_list_controller.dart';

class SubscriptionListView extends StatelessWidget {
  const SubscriptionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionListController>(
        init: SubscriptionListController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: kWhiteColor),
              toolbarHeight: Get.height / 12,
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              title: Text(
                "Subscriptions",
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
            body: ListView.builder(
              itemBuilder: (context, index) {
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
              },
              itemCount: controller.subscriptionDetailsList.length,
            ),
          );
        });
  }
}
