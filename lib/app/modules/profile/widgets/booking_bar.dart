import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import 'check_status.dart';


class BookingBar extends StatelessWidget {
  final String imagePath;
  final bool status;
  final Color iconColor;

  const BookingBar(
      {Key? key,
      required this.imagePath,
      this.status = false,
      this.iconColor = kPrimaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: Get.width,
      height: Get.height / 7,
      child: Card(
        color: kDarkGrey,
        elevation: 0,
        child: ListTile(
          contentPadding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
          leading: Image.asset(imagePath),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ignition Football Academy"),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: iconColor,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Shivjot Enclave, Kharar, Punjab 140031",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: iconColor,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "20th February, 2024",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.watch,
                    color: iconColor,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "9:00 AM - 10:00 PM",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "$krupeeValue 1,350",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        " Paid by 19-Feb-2024",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  CheckStatus()
                ],
              )
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(6.0),
        //   child: Row(
        //     children: [
        //       Image.asset(
        //         imagePath,
        //         width: 100,
        //         height: 150,
        //       ),
        //       SizedBox(width: 15),
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Booking Details',
        //                   style: TextStyle(fontWeight: FontWeight.bold),
        //                 ),
        //                 StatusBar(
        //                   isCompleted: false,
        //                 )
        //               ],
        //             ),
        //             Text(
        //               'March 21, 2024',
        //               style: TextStyle(
        //                 fontSize: 12,
        //               ),
        //             ),
        //             Text(
        //               '10:00 AM',
        //               style: TextStyle(
        //                 fontSize: 12,
        //               ),
        //             ),
        //             Text(
        //               'XYZ',
        //               style: TextStyle(
        //                 fontSize: 12,
        //               ),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text(
        //                   'Emerald Hall',
        //                   style: TextStyle(
        //                     fontSize: 12,
        //                   ),
        //                 ),
        // CheckStatus()
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
