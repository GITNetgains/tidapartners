import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../widgets/booking_bar.dart';
import '../widgets/contact_bar.dart';
import '../widgets/profile_bar.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
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
                          Text('Acedemy Bookings',
                              style: TextStyle(fontSize: 16)),
                          Text("view all")
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height / 3,
                      child: ListView.builder(
                          itemCount: 2,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BookingBar(imagePath: './assets/venue1.png');
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Venue Bookings',
                              style: TextStyle(fontSize: 16)),
                          Text("view all")
                        ],
                      ),
                    ),       
                    BookingBar(
                      imagePath: './assets/venue1.png',
                    ),
                    ContactBar(
                      text: 'Have a question? Call us',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
