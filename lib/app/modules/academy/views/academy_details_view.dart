import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constants.dart';
import '../../../components/show_loader.dart';
import '../../../routes/app_pages.dart';
import '../../profile/widgets/contact_bar.dart';
import '../controllers/academy_details_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/table.dart';

class AcademyDetailsView extends StatelessWidget {
  const AcademyDetailsView({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcademyDetailsController>(
      init: AcademyDetailsController(),
      builder: (controller) {
        return controller.isLoading.value
            ? ShowLoader()
            : Scaffold(
              appBar: AppBar(
              iconTheme: const IconThemeData(color: kWhiteColor),
              // toolbarHeight: Get.height / 12,
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              title: Text(
                "${controller.academyDataModel.title}",
                style:  TextStyle(
                    color: kWhiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: Get.height / 4,
                          child: CarouselSlider(
                              options: CarouselOptions(
                                height: Get.height / 4,
                                aspectRatio: 16 / 9,
                                viewportFraction: 1.0,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {},
                                scrollDirection: Axis.horizontal,
                              ),
                              items: [
                                CachedNetworkImage(
                                  imageUrl: controller.academyDataModel.image
                                      .toString(),
                                  fit: BoxFit.cover,
                                  memCacheHeight: 200,
                                  memCacheWidth: 400,
                                  fadeInDuration: const Duration(seconds: 1),
                                  errorWidget:
                                      (context, exception, stacktrace) {
                                    return Icon(Icons.error);
                                  },
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return Image.asset(
                                      AppImages.overallloading,
                                      fit: BoxFit.contain,
                                    );
                                  },
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    controller.academyDataModel.title
                                        .toString(),
                                    style: TextStyle(
                                        color: kHeadingColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700)),
                                controller.academyDataModel.address != ""
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                          Expanded(
                                            child: Text(
                                              controller
                                                  .academyDataModel.address
                                                  .toString(),
                                              style: TextStyle(fontSize: 12.0),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Divider(),
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      color: kHeadingColor,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(controller.academyDataModel.content
                                    .toString(), textAlign: TextAlign.left,),
                                SizedBox(
                                  height: 20,
                                ),
                                _buildTable([
                                  _buildTableRow(
                                      "Opening Hours",
                                      controller.academyDataModel.sessionTimings
                                          .toString()),
                                  _buildTableRow(
                                      "Head Coach",
                                      controller.academyDataModel.headCoach
                                          .toString()),
                                  _buildTableRow(
                                      "Skill level",
                                      controller.academyDataModel.skillLevel
                                          .toString()),
                                  _buildTableRow(
                                      "Assistant Coach",
                                      controller
                                          .academyDataModel.assistantCoachName
                                          .toString()),
                                  _buildTableRow(
                                      "Coach Exp(Years)",
                                      controller
                                          .academyDataModel.coachExperience
                                          .toString()),
                                  _buildTableRow(
                                      "Flood Lights",
                                      controller.academyDataModel.floodLights ==
                                              true
                                          ? "Yes"
                                          : "No"),
                                ]),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Amenities',
                                        style: TextStyle(
                                            color: kHeadingColor,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                SimpleTable(
                                  controller: controller,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Packages',
                                  style: TextStyle(
                                      color: kHeadingColor,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller
                                        .academyDataModel.packages!.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        color: const Color.fromARGB(
                                            255, 7, 50, 113),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .academyDataModel
                                                          .packages![index]
                                                          .name
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: kWhiteColor,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      controller
                                                          .academyDataModel
                                                          .packages![index]
                                                          .content
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(height: 4.0),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${krupeeValue} ${controller.academyDataModel.packages![index].price.toString()}',
                                                    style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 8.0),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                ContactBar(text: 'Have a Question? Call Us'),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '*Terms & Conditions Apply',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 30))
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}

Widget _buildTable(List<TableRow> rows) {
  return Table(
    columnWidths: {
      0: FlexColumnWidth(2),
      1: FlexColumnWidth(0.5),
      2: FlexColumnWidth(2),
    },
    children: rows,
  );
}

TableRow _buildTableRow(String label, String value) {
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: alignment,
        style: TextStyle(
          fontWeight: color != kblack ? FontWeight.w600 : FontWeight.normal,
          fontSize: 14,
          color: color,
        ),
      ),
    ),
  );
}
